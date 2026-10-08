<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IP API (ip_api) — agent index

**Wraps the ip-api.com geolocation endpoint; resolves the client IP to an `IpApiParameters` value object.**

- **Version:** 1.0.x
- **Core:** ^8 || ^9 || ^10 || ^11
- **Config route:** `ip_api.settings_form` → `/admin/config/system/ip-api` (permission `administer ip_api configuration`, restricted)
- **Service:** `ip_api.geolocation` (`IpApiGeolocation`) → `callIpApi()` returns `IpApiParameters`
- **Config:** `ip_api.settings` (`ip_api_key`)
- **No public/anonymous routes** — service consumed by other code.

**Security:** admin config route is permission-gated. Note: outbound calls use plain **`http://`** — `http://ip-api.com/json/<ip>` and, when a key is set, `http://pro.ip-api.com/json/<ip>?key=<KEY>` — so the API key and results travel unencrypted (`src/IpApiGeolocation.php:80,83`). The client IP from `getClientIp()` is interpolated into the URL unvalidated; behind an untrusted/misconfigured proxy a spoofed `X-Forwarded-For` could influence the outbound path.

See [api/service.md](api/service.md)
