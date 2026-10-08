<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Matomo Reports — agent index

Displays reports from an **external Matomo server** inside Drupal admin, plus an in-page
statistics block. Talks to Matomo's HTTP API with a `token_auth`. **No hard dependency on the
`matomo` tracking module**, but the block needs it (for `site_id`).

- **Connection settings: server URL, global/per-user `token_auth`, allowed sites, SSL flag** →
  [configure/settings.md](configure/settings.md)
- **Report pages, routes, report ids, the `matomo_page_report` block, and the `MatomoData` helper** →
  [api/data-and-block.md](api/data-and-block.md)

Key facts:
- Config object **`matomo_reports.matomoreportssettings`** — keys `matomo_server_url`,
  `matomo_reports_token_auth`, `matomo_reports_allowed_sites`, `matomo_server_url_ignore_ssl`.
- Settings form: route `matomo_reports.matomo_reports_settings` → `/admin/config/system/matomo-reports`.
- Reports UI: `/admin/reports/matomo-reports` (controller `MatomoReportsController::reports`).
- Permissions: **`access matomo reports`** (view), **`administer matomo reports`** (configure).
- Per-user token stored via the `user.data` service under module `matomo_reports`,
  key `matomo_reports_token_auth`.
- Block plugin id **`matomo_page_report`** ("Matomo page statistics").
- No config schema shipped, no Drush, no plugin types defined.
