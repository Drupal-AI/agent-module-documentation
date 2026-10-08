<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Analytics — agent index

Two modes: inject third-party analytics markup (GA/Matomo/custom) and/or an internal tracker. Tracker endpoint `/simple_analytics/api/track` is `_access: TRUE` (anonymous by design) and stores visit rows via the DB API. Reports at `/admin/reports/simple_analytics/*` (`simple_analytics view_*`); settings behind `simple_analytics admin`. Example submodule `simple_analytics_event`. Version **3.0.0**, core 8–10.

Security: open tracker accepts arbitrary POST data with no throttling (DoS/data-pollution, low); reports use `#theme table` so stored values are escaped (no stored XSS); queries parameterized (no SQLi).