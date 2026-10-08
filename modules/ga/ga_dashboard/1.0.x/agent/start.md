<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Google Analytics dashboard (ga_dashboard) — agent index

**Dashboard page embedding Charts-based Google Analytics report views.**

- **Version:** 1.0.x  | **Core:** ^8 || ^9 || ^10  | **Package:** Custom Module
- **Depends:** charts, charts_google, google_analytics_reports.
- **Route:** `/admin/ga-dashboard` (`GaDashboardController::gaDashboard`) embeds view `ga_reports_page` displays (sessions_and_pageviews, top_pages_block, top_cities, site_speed, top_sources_block).
- **Surface:** no settings/permissions of its own.

**Security note:** the dashboard route requires only `_permission: 'access content'` (granted to anonymous by default), so the page is broadly reachable; the embedded views enforce their own access, but consider restricting if GA data is sensitive. D1-level access observation.
