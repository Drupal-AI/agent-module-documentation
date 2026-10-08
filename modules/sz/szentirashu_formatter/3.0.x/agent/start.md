<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# szentiras.eu Reference Formatter (szentirashu_formatter) — agent index

**Field formatter + proxy that renders Bible reference strings as scripture text from the szentiras.eu API.**

- **Version:** 3.0.x (3.0.0) · **Core:** ^9 || ^10 || ^11 · **Depends:** field
- **Configure:** `szentirashu_formatter.settings` (`administer szentirashu api`) — stores API key + default translation.
- **Routes:** `szentirashu_formatter.proxy` `/szentirashu/proxy/{ref}/{translation}` — `_permission: 'access content'` (effectively anonymous), returns passage JSON.
- **Service:** `szentirashu_formatter.api` → `SzentirasService` (Guzzle to fixed host `szentiras.eu`, `X-API-Key` header, cache.default).
- **Field API:** `SzentirashuFormatter` formatter.
- **Security:** proxy is `access content` (anonymous-reachable) but `$ref` is only `rawurlencode`d into a **hardcoded** host — no SSRF, no dangerous sink, TLS at defaults. Caveat: anonymous users can drive API-key-authenticated lookups to szentiras.eu (quota abuse) — see `SzentirasService.php:52-66`.
