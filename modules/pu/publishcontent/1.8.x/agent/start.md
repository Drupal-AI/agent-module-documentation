# Publish Content — agent index

Granular publish/unpublish permissions for Drupal core **nodes**, plus a one-click
Publish/Unpublish local task tab, an optional node-form checkbox, and a Views toggle
link. Requires only core `node`. Applies to nodes only.

- **Configure** the UI, revisioning, logging, and labels: [configure/configure.md](configure/configure.md)
- **Permissions** (5 global + 6 per content type): [permissions/permissions.md](permissions/permissions.md)
- **Access API, service & events** (toggle route, `publishcontent.access`, publish/unpublish events, Views field): [api/api.md](api/api.md)
- **Hooks** to allow/deny publishing programmatically: [hooks/hooks.md](hooks/hooks.md)

Config route: `publishcontent.settings` → `/admin/config/workflow/publishcontent`.
Permissions UI: `/admin/people/permissions/module/publishcontent`.
