<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GeoDeny (geodeny) — agent index

**Blocks visitors by geolocated country (returns HTTP 400) via a response subscriber.**

- **Version:** 1.0.x  | **Core:** ^9 || ^10  | **Package:** Other
- **Depends:** ip2country (geolocation lookup).
- **Configure:** `/admin/config/services/geodeny` (route `geodeny.config_form`, perm `administer site configuration`); blocked list in config `geodeny.settings` key `geoList`.
- **Mechanism:** `GeoDenyResponseSubscriber::alterResponse()` on `KernelEvents::RESPONSE` resolves `getClientIp()` -> country and, if in `geoList`, replaces the response with `new Response('', 400)`.

**Security/enforcement notes:** (1) enforcement runs on the RESPONSE event, i.e. **after** the controller has executed — the body is discarded but side effects already happened; it is a display/output block, not a pre-execution access gate. (2) relies on `getClientIp()`, which is spoofable via X-Forwarded-For unless trusted-proxy settings are configured. (3) IPs that ip2country cannot resolve are not blocked (fail-open). Coarse geo-block by design; no clean vuln.
