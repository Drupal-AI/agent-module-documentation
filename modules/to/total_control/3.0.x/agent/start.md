# Total Control — agent index

A pre-built **admin dashboard** at `/admin/dashboard` (a Page Manager / Panels page) with
overview + admin + listing panes. Requires `page_manager`, `panels`, `ctools`, `block`,
`views`, `contextual`. Access gated by the single permission **`have total control`**. No
settings form (`configure` = null); you customise via Page Manager and Views.

- **The dashboard page & path, the permission, the pane block plugins, the control views (and
  their page paths), and how to customise / place panes** →
  [configure/dashboard.md](configure/dashboard.md)

Key facts:
- Page Manager page `total_control_dashboard`, route
  `page_manager.page_view_total_control_dashboard_total_control_dashboard-http_status_code-0`,
  path `/admin/dashboard`. A `RouteSubscriber` adds the `have total control` requirement.
- 7 Dashboard-category block plugins (panes): `content_overview`, `create_content`,
  `administer_content_types`, `administer_menus`, `administer_taxonomy`,
  `administer_panel_pages`, `total_control_dashboard`.
- Views: `control_content` (`/admin/dashboard/content/all`), `control_users`
  (`/admin/dashboard/users`), `*_panes` variants, `control_terms`
  (`/admin/dashboard/categories`), `control_comments` (when Comment enabled).
- No config schema; state lives in Page Manager pages, Panels variants, Views, block placements.
