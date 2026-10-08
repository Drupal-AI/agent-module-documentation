# admin_toolbar — agent start

Renders the core Toolbar's admin menu as expandable hover drop-downs. Depends on core
`toolbar`. Config UI: **Admin → Config → User interface → Admin Toolbar Tools**? — no, this
module's own form is at `/admin/config/user-interface/admin-toolbar` (route
`admin_toolbar.settings`). Adds no menu links itself; submodules do.

- Display settings (menu depth, sticky, shortcut, hoverIntent) → [configure/settings.md](configure/settings.md)
- Submodules: `admin_toolbar_tools` (cache/cron action links), `admin_toolbar_search`
  (link search), `admin_toolbar_links_access_filter` (deprecated) — each documented separately.
