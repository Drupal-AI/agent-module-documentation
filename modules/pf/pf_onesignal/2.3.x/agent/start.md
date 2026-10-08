<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Push Framework OneSignal (pf_onesignal) — agent index

**OneSignal mobile push as a Push Framework channel, with per-user device registration.**

- **Version:** 2.3.x (2.3.1)
- **Core:** ^10 || ^11 — depends on user, push_framework.
- **Configure:** `/admin/config/system/push_framework/onesignal` (route `onesignal.settings`, perm `administer site configuration`) — App ID + REST auth key in `pf_onesignal.settings`.
- **Channel plugin:** `src/Plugin/PushFrameworkChannel/OneSignal.php` — POSTs to `https://onesignal.com/api/v1/notifications` over HTTPS, 3 attempts, `Authorization: Basic <authkey>`.
- **Entity:** `onesignal_device` (`src/Entity/Device.php`); view `my_devices`.
- **Routes:**
  - `/onesignal/register` — `_custom_access` `Register::access` (**authenticated only**); creates/updates the current user's device from a JSON body.
  - `/user/{user}/devices` — core personal-contact-tab access.
  - `/apple-app-site-association` + `/.well-known/apple-app-site-association` — `_access: 'TRUE'`, **public by design** (universal-link manifest).
- **Security:** (already reviewed) the `_access: TRUE` routes are the public AASA files; `/onesignal/register` is guarded by `_custom_access` and scoped to `currentUser`. TLS not disabled; auth key sent over HTTPS. No new findings.

See [configure/settings.md](configure/settings.md).