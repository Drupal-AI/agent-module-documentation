# Permissions — content_planner (base)

From `content_planner.permissions.yml`:

- `view content planner dashboard` — access the dashboard at
  `/admin/content-planner/dashboard`. Not `restrict access: true`.
- `administer content planner dashboard settings` — access the dashboard settings and per-widget
  config forms (add/order/title widgets, edit Views/Text-HTML widget content). Not
  `restrict access: true`. Holders can author `full_html` Text/HTML widget markup rendered to all
  dashboard viewers (through `check_markup`).

Submodule permissions are documented with each submodule (`content_calendar`, `content_kanban`).
