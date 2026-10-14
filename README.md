<div align="center">
<h1>A1 Memory RMX3741 Safe</h1>
<a href="http://cppmicroservices.org/"><img alt="C Language" src="https://img.shields.io/badge/-C-black?logo=c&style=flat-square&logoColor=ffffff"></a>
<a href="http://cppmicroservices.org/"><img alt="C++ Language" src="https://img.shields.io/badge/-C++-808080?logo=c%2B%2B&style=flat-square&logoColor=ffffff"></a>
<a href="https://www.python.org/"><img alt="Bash Shell" src="https://img.shields.io/badge/-Bash-ae9a5a?style=flat-square&logo=shell&logoColor=ffffff"></a>
<img alt="Android Support" src="https://img.shields.io/badge/Android%2015%20RMX3741-Profile-green">
<img alt="arm64-v8a Support" src="https://img.shields.io/badge/arm64--v8a-Support-green">
<a href="https://t.me/HCha1234"><img alt="Join Telegram Channel" src="https://img.shields.io/badge/Join%20group-Telegram-brightgreen.svg?logo=telegram"></a>
<p><b><a href="README.md">English</a> | <a href="README-zh.md">简体中文</a> | <a href="README-ru.md">Русский</a></b></p>
<p>Device-specific cached-process cleanup profile for Realme RMX3741 / Android 15.</p>
</div>

## RMX3741 safety profile

This fork keeps the arm64 `HC_memory` cleanup engine and its conservative
cached-process policy. It removes the upstream system_server Xposed APK,
`libhook_lmkd.so`, and `system.prop` overrides. There is no lmkd kill bypass,
excessive-power check bypass, thermal override, swap resize, or automatic
network client.

The boot service waits for Android to finish booting, then starts the native
cleanup process. If that process exits, the shell retries after 180 seconds;
there is no recursive shell call or tight retry loop.
The profile protects Android system/telephony, Google services, Termux,
WhatsApp, Facebook/Messenger, and Root Call SMS Manager from cached cleanup.

The native executable is stripped third-party code, so static review cannot
prove absence of every hidden behavior. The arm64 Android 15 smoke test ran it
with all destructive features disabled and traced `execve`, network, `kill`,
and `ptrace`: only expected Android inventory commands were observed and no
network syscall occurred. This profile must remain disabled if that evidence
is insufficient for your trust requirements.

## ✨important function
- Managing the survival and termination of background processes
- Specifying the release of background application child processes
- Automatically releasing non-essential memory
- Leaving Android 15's Low Memory Killer policy in control

## 💡Description
- This build is tailored to Realme RMX3741 on Android 15 and is limited to arm64-v8a.
- Magisk version should be 20.4+ and ksu is mostly compatible.
- This module is unlikely to conflict with other modules.

### Default List Path
![列表图片](image/list.jpg)
- List File: /sdcard/Android/HChai/HC_memory/名单列表.conf

## 📝Custom Configuration
The built-in configuration is suitable for most devices, but there are still some devices that may not work with the default configuration. Therefore, more adjustable parameters are provided. This requirement was already taken into consideration when designing the HAMv2 framework, and most parameters can be customized and adjusted. Moreover, this project can be embedded and run within other modules. The JSON configuration file is located at `/data/adb/modules/Hc_memory/config/memory.json`

### Project Information
```json
"project": {
    "name": "官方配置 [23.06.25]",
    "author": "火機@coolapk"
}
```

| Field  | Type   | Description                                  |
| ------ | ------ | -------------------------------------------- |
| name   | string | Name of the configuration file               |
| author | string | Author information of the configuration file |

The `name` and `author` are reflected in the logs in the following format:
```
[2023-07-06 19:00:22] [info] config 官方配置 [23.06.25] | by: 火機@coolapk
```

- For more detailed instructions on the JSON configuration file, please refer to[here.](config/JSON-CONFIG.md)

## 🔍Frequently Asked Questions

Can it be used in conjunction with other memory optimization modules?
- A1 memory management works completely differently from other memory optimization methods, so using it together with other modules will only yield a cumulative effect of 1+1=2.

Does it consume power?
- Not at all. I spent a considerable amount of time optimizing the core code while developing the HAMv2 framework. It is implemented in low-level languages such as C/C++, resulting in minimal power consumption that can be completely ignored.

Does it conflict with other Magisk modules or Xposed modules?
- It is highly unlikely to conflict with other modules. So far, no conflicts have been encountered with this module.

Does it cause power consumption during standby?
- The HAMv2 framework does not cause power consumption during standby, as the A1 memory management enters a sleep state when the device is in standby mode.

Can this build prevent lmkd from killing background processes?
- No. The RMX3741 profile deliberately leaves Android's lmkd and power policy active.

How to configure the smart list?
- Child-process KILL rules are disabled in this RMX3741 profile. Edit the protected `WHITE` entries only if you understand the app's background services.

Why is the process playing audio being paused?
- The occurrence of audio process being paused is rare. If it indeed happens, you can add the process to the whitelist or disable the app hibernation feature. This will ensure continuous operation of the audio process without being paused.

Not compatible with this platform: xxxx error when installing the module.
- Currently, the module only supports the arm-v8a platform and does not support other platforms temporarily.

## 🚀download
- [Go to Github to download](https://github.com/shamrat05/A1Memory/releases)

## 🌟Star History

<a href="https://star-history.com/#shamrat05/A1Memory&Timeline">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=shamrat05/A1Memory&type=Timeline&theme=dark" />
    <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=shamrat05/A1Memory&type=Timeline" />
    <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=shamrat05/A1Memory&type=Timeline" />
  </picture>
</a>

## 🙏Acknowledgments

Thanks to the following users or projects for their source code contributions to this project:  
- [@yc9559](https://github.com/yc9559)
- [@HChenX](https://github.com/HChenX)

Thanks to the following users for their testing feedback and bug identification:
- @火機(coolapk)

## 🎉Support Donations
If you find this module useful, you can make a donation to support me.
- [爱发电](https://afdian.net/a/HCha1)
- [patreon](https://patreon.com/A1memory)
- USDT(TRC20)
  > Address: TSqTqn2NcyUAbEwsdGgsrYoU5pokno5PnQ
