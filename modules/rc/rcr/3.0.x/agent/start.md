<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CIS currencies rates (rcr) — agent index

**Fetches USD/EUR rates against CIS currencies from national-bank feeds and shows them in a block.**

- **Version:** 3.0.x
- **Core:** ^11 — requires core `block`.
- **Config route:** `rcr.currency_settings` → `/admin/config/system/currency-settings` (perm `change currency rate`).
- **Service:** `rcr.service` (`RcrService`) — fetches from fixed central-bank URLs.
- **Block:** `RatesBlock`. **Drush:** `rcr-getrates` (refresh). Rates stored in State.

**Security:** Settings route is permission-gated. `RcrService` fetches **hardcoded** national-bank URLs (not request-supplied), so no SSRF; it uses `file_get_contents` over HTTPS (default TLS). No security findings. See [configure/rcr.md](configure/rcr.md).
