# Seeds Toolbar — agent index

Restyles core/Admin Toolbar into a vertical, mobile-first, RTL-aware admin toolbar with
light/dark modes, an "Add" tray, local-tasks tray, a support link, and an admin-menu search box.
Depends on `toolbar` + `admin_toolbar` + `admin_toolbar_tools`. No Drush; no config schema.

- **Settings form, every `seeds_toolbar.settings` key, the configure route** →
  [configure/settings.md](configure/settings.md)
- **The two permissions and what they gate** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config route `seeds_toolbar.configuration` → `/admin/config/user-interface/seeds-toolbar`
  (permission `administer seeds toolbar`). Config object `seeds_toolbar.settings` (install
  defaults: `compact: true`, `search: true`, `style: dark`, `support: 'https://sprintive.com'`).
- Replaces toolbar/admin_toolbar CSS+JS via `hook_library_info_alter`; builds trays in
  `hook_toolbar` / `hook_toolbar_alter` and many `hook_preprocess_*`.
- Add tray links built by `SeedsManager::buildMenu()` (`src/SeedsManager.php`), access-filtered
  per entity type (node_type, taxonomy_vocabulary, media_type, block_content_type).
- Admin search: `_seeds_toolbar_search_links()` flattens the admin menu tree into `data-search`
  links; shown only with `use admin search` + `search` setting on.
- Permissions: `administer seeds toolbar`, `use admin search` (`seeds_toolbar.permissions.yml`).
