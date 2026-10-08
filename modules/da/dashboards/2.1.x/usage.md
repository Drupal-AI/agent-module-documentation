<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Dashboards lets you build admin (or front-end) dashboard pages out of Layout Builder sections, filling them with pluggable "dashboard" widgets — charts, statistics, feeds, system info, and more — that are also exposed as ordinary blocks.

---

The module defines a `dashboard` config entity (Layout Builder based): each dashboard has an `admin_label`, a `category`, a `weight`, a `frontend` flag, and a set of Layout Builder `sections`. Dashboards are managed at `/admin/structure/dashboards` (the `configure` route `entity.dashboard.collection`) with add/edit/delete forms and a Layout Builder editor; the rendered page is at `/dashboard/{dashboard}`. Widgets come from a plugin type the module defines — **Dashboard** plugins (manager `plugin.manager.dashboard`, annotation `@Dashboard`, base class `DashboardBase`) — each implementing `buildRenderArray()` and optionally `buildSettingsForm()`. Every Dashboard plugin is automatically exposed as a block via a derivative, so in Layout Builder you place block `dashboards_block:dashboard:<plugin_id>`. Nine widgets ship in the base module (`account`, `add_content_menu`, `view_embed`, `report_not_found`, `system_info`, `node_statistics`, `status_updates`, `error_report`, `rss_news`), and submodules add comment/statistics/webform/matomo widgets. Chart-style widgets use a shared `ChartTrait` whose colors are driven by the `dashboards.settings` config (`colormap`, `alpha`, `shades`, set at `/admin/system/dashboards-settings`). Access is controlled by `administer dashboards` plus dynamically generated per-dashboard permissions (`can view <id> dashboard`, `can override <id> dashboard`); the override permission lets a user personalize their own copy of a dashboard through a user-specific section storage. A theme negotiator, toolbar integration (a Dashboards tray), and optional Layout Builder Restrictions integration round it out. RSS feed widgets rely on `laminas/laminas-feed`.

---

- Build an editorial dashboard with recent content, quick "add content" links, and site status.
- Create an operations dashboard showing the system status report summary (errors/warnings/checked).
- Chart node view statistics (most-read content) on a reporting dashboard.
- Show comment activity per content type as a chart (via the comments submodule).
- Display webform submission trends over time (via the webform submodule).
- Pull in Matomo analytics (visitors, top URLs, countries, browsers, OS) as widgets (matomo submodule).
- Embed an existing View into a dashboard with the "Embed a view" widget.
- Add an RSS news feed widget (e.g. Drupal.org planet) to a dashboard.
- Show the current user's account/profile as a widget.
- Present a "page not found" report on an admin dashboard.
- Compose dashboard layouts using the module's 1-, 2-, and 3-column Layout Builder layouts.
- Place dashboard widgets anywhere as blocks (`dashboards_block:dashboard:<id>`) outside a dashboard too.
- Give a role access to only specific dashboards via the per-dashboard "can view" permissions.
- Let users personalize their own copy of a dashboard with the "can override" permission.
- Expose a dashboard on the front end (not just admin) with the `frontend` flag.
- Order multiple dashboards in the toolbar tray with the `weight` field.
- Tune chart colors globally by choosing a colormap, transparency (alpha), and number of shades.
- Write a custom widget by extending `DashboardBase` and implementing `buildRenderArray()`.
- Add a settings form to a widget (e.g. choose a view mode, count type, or date range).
- Cache widget data with the plugin's `getCache()` / `setCache()` helpers (dedicated `dashboards` cache bin).
- Restrict which blocks/layouts editors can use on a dashboard via Layout Builder Restrictions.
- Provide a landing dashboard as the first item in the admin toolbar's Dashboards tray.
- Group widgets by category (e.g. "Dashboards: System", "Statistics") in the block picker.
