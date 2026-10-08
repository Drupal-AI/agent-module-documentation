# editoria11y — agent start

In-page, editor-facing accessibility checker (JS) + site-wide dashboard. Depends on node,
taxonomy, user, views. Config UI: **Admin → Config → Content → Editoria11y**
(`/admin/config/content/editoria11y`, route `editoria11y.settings`). Dashboard: **Admin →
Reports → Content Accessibility Issues** (`/admin/reports/editoria11y`). Submodules:
`editoria11y_csa`, `editoria11y_export`.

- Configure tests, theming, scan regions, live checking → [configure/settings.md](configure/settings.md)
- Dashboard + JSON API endpoints (report/dismiss/purge) → [api/endpoints.md](api/endpoints.md)
- Alter front-end config in code (2 hooks) → [hooks/hooks.md](hooks/hooks.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
