# Allow a content type only once (Only One) — agent index

Restricts chosen content types to **one node per language**. Adding a second sends the editor
to edit the existing node. Enforcement is an `OnlyOne` entity constraint on `node`.

- **Configure which types are restricted + the two settings (menu entry, redirect)** →
  [configure/onlyone.md](configure/onlyone.md)
- **How it works: the `onlyone` service, the OnlyOne constraint, the event, dynamic route** →
  [api/mechanism.md](api/mechanism.md)
- **Permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Restricted types: `onlyone.settings.onlyone_node_types` (sequence of node-type machine names).
- Settings: `onlyone.settings.onlyone_new_menu_entry` (bool), `onlyone.settings.onlyone_redirect`
  (bool, default true = redirect to edit form). `configure` route = `onlyone.admin_settings`.
- Admin pages: `/admin/config/content/onlyone` (pick types) and `.../settings` (options);
  permission `administer onlyone`.
- Submodule `onlyone_admin_toolbar` (see `modules/onlyone_admin_toolbar/`).
- The bundled `onlyone.drush.inc` is legacy (Drush 8/9 API) and does **not** run on Drush 12+;
  set `onlyone.settings` directly instead.
