# trash — agent start

Soft-deletes content entities into a recycle bin instead of removing them. No module deps.
Settings UI: **Admin → Config → Content authoring → Trash** (`/admin/config/content/trash`,
route `trash.settings.form`). Trash listing: `/admin/content/trash`.

- Enable entity types, auto-purge settings → [configure/settings.md](configure/settings.md)
- Soft-delete / restore / context API in code → [api/trash-manager.md](api/trash-manager.md)
- Add trash support to a custom entity type (handler) → [extend/trash-handler.md](extend/trash-handler.md)
- React to trash/restore events (hooks) → [hooks/hooks.md](hooks/hooks.md)
- Drush commands (restore / purge / export-views) → [drush/commands.md](drush/commands.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
