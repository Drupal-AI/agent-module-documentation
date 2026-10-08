<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Time Ticker (time_ticker) — agent index

**A block that shows a live-updating clock/date for a configured timezone, polled over AJAX.**

- **Version:** 9.1.x
- **Core:** ^8 || ^9 || ^10
- **Depends:** block
- **Configure:** `/admin/config/regional/time-ticker` (`time_ticker.admin_settings`, perm `administer blocks`)

**Routes:** `time_ticker.admin_settings` (settings form, `administer blocks`); `time_ticker.time` → `/time_ticker/ajax` (JSON, perm `access content`). **Service:** `time_ticker.time` (`TimeService`, reads `time_ticker.settings.timezone`). Block plugin + JS library poll the AJAX route.

**Security:** admin form permission-gated; the anonymous-readable AJAX endpoint returns only the formatted current time (no user/system data), so exposure is nil. No mutating endpoints.
