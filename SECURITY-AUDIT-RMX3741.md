# A1Memory RMX3741 security audit

Audit target: fork commit based on upstream `a54e53d`, device `RMX3741`,
Android 15 / SDK 35, arm64.

## Removed from the installable module

- `module/app/app-release.apk`: upstream Xposed module scoped to `android`.
  Its hooks return `false` from `ActivityManagerService.checkExcessivePowerUsageLPr`
  and suppress `ProcessKillerIdler.onStartJob`, which bypasses Android power and
  process management.
- `module/lib/arm64-v8a/libhook_lmkd.so`: unused lmkd hook payload.
- `module/system.prop`: upstream LMK/vendor property overrides.
- `module/system/bin/UI_memory` and its `amui` launcher: optional opaque terminal UI binaries.
- `module.prop` `updateJson`: removed, so Magisk does not follow the upstream
  update channel.

## Static checks

- Remaining shell files contain no `curl`, `wget`, `nc`, HTTP client, socket
  command, or background download.
- `HC_memory` links only Android system libraries. Its imports include process
  inventory/control functions (`execv`, `popen`, `kill`, `ptrace`) expected in
  the upstream native engine. No socket/connect/send/recv import was present.
- The remaining module has no APK, no Xposed entry point, no UI binary, and no
  Java network permission surface.
- The service starts the native process inside an empty network namespace when
  `/system/bin/unshare` is available; it has no reason to access network.
- The service starts it at nice `10` and idle I/O priority, reducing scheduler
  and storage competition with foreground work.

## Runtime smoke test

`HC_memory` was run from a temporary root path with every destructive feature
disabled. `strace` observed Android inventory commands (`pm`, `dumpsys`,
`appops`, `cmd`, `which`) and no network syscall, `ptrace`, or kill syscall.
The binary remained resident until the bounded test timeout, so the service
uses one long-lived native pass with a bounded shell wrapper rather than a
recursive restart loop.

The native binary is stripped and not rebuilt from this fork. Static and smoke
tests reduce risk but cannot prove that opaque native code has no hidden
behavior. Do not install this fork if you require source-level verification of
the native engine.
