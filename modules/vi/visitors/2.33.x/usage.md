<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Visitors is a native, self-hosted Drupal web-analytics module: it logs each visit to its own database table and renders reports (recent hits, top pages, hosts, referrers, devices, browsers, and more) as Views + Chart.js charts inside Drupal, with an optional per-content hit counter.

---

A small JavaScript tracker is attached to pages (via `PageAttachmentsService`) and posts each visit to the `/visitors/_track` endpoint (`Visitors::track`), which the `visitors.tracker` service records to the `visitors` log table; a `visitors.visibility` service decides which pages/roles/users are tracked. Reports live under `/visitors` (permission `access visitors`) — hits, top pages, hosts, referrers, etc. — built from the log with `visitors.report` and Chart.js (the `charts` / `charts_chartjs` dependency). Device, browser and OS data come from the bundled `matomo/device-detector` library (`visitors.device`), and geolocation from the optional **visitors_geoip** submodule (`geoip2/geoip2`). All behaviour is controlled by one config object, **`visitors.config`** (settings form at `/admin/config/system/visitors`, route `visitors.settings`): log/bot retention timers, `items_per_page`, admin `theme`, `disable_tracking`, `track.userid`, a `counter` block (per-entity hit counter: `enabled`, `entity_types`, `display_max_age`), a `visibility` block (path/role/account tracking rules, `exclude_user1`), and `script_type` (minified vs full tracker). Because logs store raw request data, the module can reprocess them: **rebuild** forms/commands recompute routes, IP addresses, and device info from the existing log (`visitors:rebuild:route`, `visitors:rebuild:ip-address`, `visitors:rebuild:device`). A hook_cron job (`visitors.cron`) prunes old log rows. Three permissions gate report access, tracking opt-out, and the content hit-counter display. It depends on core Views and Path.

---

- Get self-hosted web analytics without sending data to a third party (privacy-friendly).
- See which pages were hit most (Top pages report).
- Review recent individual hits with referrer, device, and location.
- Show a per-node "views" counter, enabled per entity type via `counter`.
- Track logged-in user IDs alongside anonymous visits (`track.userid`).
- Exclude admin pages from tracking with the visibility path rules.
- Track only (or exclude) specific roles via the visibility role rules.
- Let users opt out of tracking with the `opt-out of visitors tracking` permission.
- Exclude user 1 (the superuser) from analytics (`exclude_user1`).
- Break down traffic by device, browser, and operating system (device-detector).
- View referrers and top external sites sending traffic.
- Add country/region/city reports with the visitors_geoip submodule.
- Choose how many rows each report lists (`items_per_page`).
- Prune old log entries automatically on cron (`flush_log_timer`, `bot_retention_log`).
- Rebuild route data for historic log rows after a URL/alias change (`visitors:rebuild:route`).
- Rebuild IP-address-derived data for existing logs (`visitors:rebuild:ip-address`).
- Rebuild device/browser data for existing logs (`visitors:rebuild:device`).
- Serve a minified or full tracker script (`script_type`).
- Disable all tracking site-wide temporarily (`disable_tracking`).
- Pick which admin theme the report pages render in (`theme`).
- Restrict who can see analytics with the `access visitors` permission.
- Show a hit counter only where wanted using `view visitors counter`.
- Cache a content view-count for a period to reduce writes (`counter.display_max_age`).
- Build custom analytics views on the `visitors` log table (Views integration).
- Monitor who is online now (`visitors.online` service).
