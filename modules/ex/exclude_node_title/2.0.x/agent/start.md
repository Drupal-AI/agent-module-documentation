# exclude_node_title — agent start

Hides the node title (h1 / page title) from display, chosen per content type, per view mode,
or per individual node — without deleting the title value. Depends on core `node`. Config UI:
**Admin → Config → Content authoring → Exclude Node Title**
(`/admin/config/content/exclude-node-title`); settings route `exclude_node_title.settings`.

- Settings: exclude mode per content type, view modes, render type, per-node override, search →
  [configure/settings.md](configure/settings.md)
- Permissions (admin + per-node exclude) → [permissions/permissions.md](permissions/permissions.md)
- How the title is suppressed in templates (preprocess hooks, classes, DS field) →
  [theming/exclude_node_title.md](theming/exclude_node_title.md)

