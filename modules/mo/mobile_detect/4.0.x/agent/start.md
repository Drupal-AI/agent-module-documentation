<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mobile Detect — agent index

Server-side, User-Agent device detection. Wraps `mobiledetect/mobiledetectlib` as the
`mobile_detect` service, adds Twig functions, cache contexts, `<body>` classes, two block
visibility conditions and a status block. Library dep `mobiledetect/mobiledetectlib:4.8.09`.
No module dependencies.

- **Settings form, config key, permission, the status block** →
  [configure/settings.md](configure/settings.md)
- **The `mobile_detect` service, Twig functions, cache contexts, body classes** →
  [api/detection.md](api/detection.md)
- **Block-visibility Condition plugins (`mobile_detect_device_type`, `mobile_detect_platform`)** →
  [plugins/conditions.md](plugins/conditions.md)

Quick reference:
- Service `mobile_detect` = `Detection\MobileDetect` (methods `isMobile()`, `isTablet()`, etc.).
- Twig functions: `is_mobile()`, `is_tablet()`, `is_device(name)`, `is_ios()`, `is_android_os()`.
- Cache contexts: `mobile_detect_is_mobile`, `mobile_detect_device_type`, `mobile_detect_platform`.
- Body classes added on mobile/tablet: `is-mobile`, `is-tablet`.
- Condition plugin ids: `mobile_detect_device_type`, `mobile_detect_platform`.
- Block id `mobile_detect_status_block`; theme hook `mobile_detect_status_block`.
- Settings: route `mobile_detect.settings` → `/admin/config/user-interface/mobile-detect`,
  config `mobile_detect.settings` key `mobile_detect_is_mobile` (bool). Permission
  `administer mobile_detect configuration`.
