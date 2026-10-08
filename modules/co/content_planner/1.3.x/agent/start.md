# Content Planner — agent index

Editorial planning suite: an admin **Dashboard** of pluggable widgets, plus **Content Calendar**
and **Content Kanban** submodules. Requires core `image` + `content_moderation` and contrib
`scheduler`; installing it also enables both submodules. Boards need a valid Content Moderation
workflow with ≥1 enabled entity type. No global `configure` route on the base module (dashboard is
configured at `/admin/content-planner/dashboard/settings`).

- **Dashboard settings, the `blocks` config, shipped widgets (User / Views / Text-HTML)** →
  [configure/dashboard.md](configure/dashboard.md)
- **Define your own dashboard widget (`DashboardBlock` plugin type)** →
  [plugins/dashboard-block.md](plugins/dashboard-block.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Submodules (own docs):
- `content_calendar` → [../../modules/content_calendar/1.3.x/agent/start.md](../../modules/content_calendar/1.3.x/agent/start.md)
- `content_kanban` → [../../modules/content_kanban/1.3.x/agent/start.md](../../modules/content_kanban/1.3.x/agent/start.md)

Key facts:
- Dashboard route `content_planner.dashboard` (`view content planner dashboard`); settings
  `content_planner.dashboard_settings` (`administer content planner dashboard settings`).
- Widget config stored in config object `content_planner.dashboard_settings` → `blocks[<id>]`
  = `{plugin_id, title, weight, configured, plugin_specific_config}`.
- Plugin type: `dashboard_block` (manager `content_planner.dashboard_block_plugin_manager`,
  annotation `@DashboardBlock`, interface `DashboardBlockInterface`, base `DashboardBlockBase`).
- Text/HTML widgets store a `text_format` value rendered with `check_markup` (default format
  `full_html`); per-widget `allowed_roles` gate visibility.
