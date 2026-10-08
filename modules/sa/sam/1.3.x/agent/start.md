# sam (Simple Add More) — agent start

Improves fixed multi-value field widgets: hides surplus empty elements and shows a single
"Add another item" button (client-side JS, library `sam/simplify`). Acts only on fields with
cardinality > 1 and on an allow-list of widget types. No PHP deps, no services, no plugins,
no submodules. Config UI: **Admin → Config → Content authoring → Simple Add More Settings**
(`/admin/config/content/simple-add-more-settings`), route `sam.admin_settings`.

- Configure labels/help text + per-widget skip + supported widget types → [configure/settings.md](configure/settings.md)
- Extend the list of simplifiable widget types via hook → [hooks/hooks.md](hooks/hooks.md)
- Permission that gates the settings form → [permissions/permissions.md](permissions/permissions.md)
