# imce — agent start

Web file manager with per-role/per-user personal folders; plugs into CKEditor 5, BUEditor
and file fields. Config UI: **Admin → Config → Media → Imce File Manager**
(`/admin/config/media/imce`, route `imce.admin`). Browser at `/imce/{scheme}`.

- Profiles, settings, role assignment, folder permissions → [configure/profiles.md](configure/profiles.md)
- Define a new file operation (ImcePlugin plugin type) → [plugins/imce-plugin.md](plugins/imce-plugin.md)
- Programmatic API (`Imce` façade: access, scan, file entities) → [api/imce-service.md](api/imce-service.md)
- Hooks & integration points (plugin alter, file widget, editor dialogs) → [hooks/hooks.md](hooks/hooks.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
- Templates & theme hooks → [theming/theming.md](theming/theming.md)
