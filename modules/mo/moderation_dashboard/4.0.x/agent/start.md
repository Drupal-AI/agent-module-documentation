# moderation_dashboard — agent start

Provides a per-user moderation dashboard at **`user/{uid}/moderation-dashboard`** (Views route
`view.moderation_dashboard.page_1`, path `user/%user/moderation-dashboard`). The page is a
`moderation_dashboard` user view-mode laid out with **Layout Builder** (a three-region
"Moderation Dashboard Layout") that combines four shipped Views (recent changes, recently
created, in review, and the master `moderation_dashboard` view) with two custom blocks —
`moderation_dashboard_activity` (Chart.js graph) and `moderation_dashboard_add_links`.
Depends on core `content_moderation`, `node`, `views`, `layout_builder`. Because it is all
Views + Layout Builder, you customise it in the UI; the module ships no update hooks.

- Settings (`redirect_on_login`, `chart_js_cdn`), the config form route, the dashboard/Views route, and Layout-Builder customisation → [configure/moderation_dashboard.md](configure/moderation_dashboard.md)
- Permissions (`use moderation dashboard`, `view any moderation dashboard`) and how dashboard access is computed → [permissions/moderation_dashboard.md](permissions/moderation_dashboard.md)
- Programmatic surface: shipped Views ids, blocks, conditions, the Views access plugin, the `link_to_latest_version` field, and services → [api/moderation_dashboard.md](api/moderation_dashboard.md)
