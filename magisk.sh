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

set -eu

MODPATH=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
CURRENT_DATE=$(date +%Y-%m-%d)

init() {
    echo "- module source: $MODPATH/module"
}

packaged_Modules() {
    build_dir="$MODPATH/build"
    stage=$(mktemp -d "$MODPATH/.work/build.XXXXXX")
    trap 'rm -rf "$stage"' EXIT
    cp -a "$MODPATH/module/." "$stage/"
    cp -f "$MODPATH/config/memory.json" "$stage/config/memory.json"
    mkdir -p "$build_dir"
    output="$build_dir/A1Memory-RMX3741.zip"
    rm -f "$output"
    (cd "$stage" && zip -r -9 "$output" . >/dev/null)
    echo "- package built: $output"
}

init
packaged_Modules
