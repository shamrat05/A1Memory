#!/system/bin/sh
#
#Copyright (C) 2022-2023 OneB1ank
#
#This program is free module: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program. If not, see <http://www.gnu.org/licenses/>.
#

MODDIR="$(dirname "$0")"
COUNT=0
CONFIG_DIR="/data/media/0/Android/HChai/HC_memory"
LOGFILE="$CONFIG_DIR/Run.log"

# Wait for boot completion with a hard bound. Never leave a recursive shell
# stack or a tight retry loop on a hot device.
while [ "$(getprop sys.boot_completed 2>/dev/null)" != "1" ] && [ "$COUNT" -lt 30 ]; do
    sleep 2
    COUNT=$((COUNT + 1))
done
[ "$(getprop sys.boot_completed 2>/dev/null)" = "1" ] || exit 0

mkdir -p "$CONFIG_DIR"
chmod 0755 "$CONFIG_DIR" 2>/dev/null || true
touch "$LOGFILE"
chmod 0644 "$LOGFILE" 2>/dev/null || true

# Run native cleanup. If it exits, retry after three minutes. Android lmkd
# remains authoritative; no lmkd hook, process-killer bypass, or foreground kill.
while :; do
    if [ -f "$LOGFILE" ] && [ "$(wc -c < "$LOGFILE" 2>/dev/null || echo 0)" -gt 1048576 ]; then
        : > "$LOGFILE"
    fi
    # Keep native code in an empty network namespace when Android permits it.
    # Its inventory uses Binder/system commands, so it does not need network.
    [ -x /system/bin/unshare ] || exit 0
    /system/bin/nice -n 10 /system/bin/ionice -c 3 -t \
        /system/bin/unshare -n "$MODDIR/HC_memory" >> "$LOGFILE" 2>&1 || true
    sleep 180
done
