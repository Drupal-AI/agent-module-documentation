<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dashboards — agent index

Build dashboard pages from **Layout Builder** sections filled with pluggable **Dashboard** widgets
(also exposed as blocks). Depends on `layout_builder` + `views`. Has 5 submodules (comments, matomo,
statistic, views, webform). Requires `laminas/laminas-feed`.

- **The `dashboard` config entity, creating/editing dashboards, module settings (colormap/alpha/shades)** →
  [configure/dashboards.md](configure/dashboards.md)
- **The Dashboard plugin type — write a widget, the block derivative, shipped widgets, ChartTrait** →
  [plugins/dashboard-plugins.md](plugins/dashboard-plugins.md)
- **Permissions (`administer dashboards` + dynamic per-dashboard view/override)** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config entity type `dashboard`; config names `dashboards.dashboard.<id>`; fields `admin_label`,
  `category`, `sections`, `frontend`, `weight`. Managed at `/admin/structure/dashboards`
  (`configure` route `entity.dashboard.collection`); rendered at `/dashboard/{dashboard}`.
- Plugin type `dashboard` (manager `plugin.manager.dashboard`, base `DashboardBase`,
  `@Dashboard(id,label,category)`), each widget → block `dashboards_block:dashboard:<plugin_id>`.
- Base widgets: `account`, `add_content_menu`, `view_embed`, `report_not_found`, `system_info`,
  `node_statistics`, `status_updates`, `error_report`, `rss_news`.
- Settings `dashboards.settings`: `colormap`, `alpha`, `shades` (`/admin/system/dashboards-settings`).
- Submodules add widgets: [comments](../../modules/dashboards_comments/2.1.x/agent/start.md),
  [matomo](../../modules/dashboards_matomo/2.1.x/agent/start.md),
  [statistic](../../modules/dashboards_statistic/2.1.x/agent/start.md),
  [views](../../modules/dashboards_views/2.1.x/agent/start.md),
  [webform](../../modules/dashboards_webform/2.1.x/agent/start.md).
