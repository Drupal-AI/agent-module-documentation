# Varbase Total Control Dashboard — agent index

Admin dashboard built on Total Control + Panels/Page Manager + Charts. Ships a two-column Page
Manager dashboard page populated with four custom blocks plus a Views recent-content block, gated
by the `have total control` permission (from Total Control). No config UI (`configure` null), no
own permissions.yml, no schema, no Drush.

- **The blocks, the Condition plugin, the dashboard page/route + access, the recipe, and how to customize** →
  [configure/dashboard.md](configure/dashboard.md)

Key facts:
- Block plugins: `varbase_dashboard_user`, `varbase_quick_links`, `varbase_create_content`
  (configurable content types), `varbase_content_overview` (types/comments/spam overview).
- Condition plugin `module_enabled` (show a pane only when a named module is enabled).
- Access: `RouteSubscriber` sets `_permission: 'have total control'` on the dashboard's Page
  Manager routes (`page_manager.page_view_total_control_dashboard_…panels_variant-0/-1`).
- Dashboard page config in `config/optional` (panels_variant); dashboard CSS
  `varbase_total_control/vtc` attached on those routes only. Recipe `recipes/default` grants the
  permission to editor/content_admin/seo_admin/site_admin.
- Depends on `total_control`; composer also pulls `charts` (`~5`) + `charts_c3`.
