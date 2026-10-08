<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Frontend Asset Debugger (frontend_asset_debugger) — agent index

**Admin reports that audit declared asset libraries for duplicates, unused libraries, render-blocking files, per-component usage and a dependency graph, with CSV/JSON export.**

- **Version:** 1.0.x — core `^10 || ^11`
- **Reports:** `/admin/reports/frontend-assets` (+ `/duplicates`, `/unused`, `/render-blocking`, `/per-component`, `/dependency-graph`, `/all`, `/export/{section}`) — `access frontend asset debugger`
- **Settings/scan:** `/admin/config/development/frontend-assets`, `/run-scan`, `POST /scan-pages` — `administer frontend asset debugger` (restricted)
- **Services:** `asset_analyzer` (library discovery/theme/module inspection), `page_scanner` (HTTP client fetches real URLs into state)
- **Security:** reports read-only under `access frontend asset debugger`; scan/settings under a restricted admin permission. `PageScanner.php:87` sets `verify => FALSE` on same-site public-page fetches for the admin debug report — no credentials, below security bar.
