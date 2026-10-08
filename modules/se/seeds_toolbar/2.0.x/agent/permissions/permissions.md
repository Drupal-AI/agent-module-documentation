# Permissions

From `seeds_toolbar.permissions.yml`:

| Permission | Gates |
|---|---|
| `administer seeds toolbar` | Access to the settings form (`/admin/config/user-interface/seeds-toolbar`, route `seeds_toolbar.configuration`). Administrative — grant to trusted roles. |
| `use admin search` | Whether the admin-menu search box is built and rendered for the user. Checked in `hook_preprocess_seeds_toolbar_menu` and `_seeds_toolbar_search_links` (together with the `search` setting). |

Notes:
- Neither permission is `restrict access: true` in the YAML, but `administer seeds toolbar` only
  exposes the module's own styling/config form (a normal admin config page).
- The toolbar itself renders for anyone with core's **`access toolbar`** permission
  (`hook_page_attachments` / `hook_preprocess_html` gate on it) — that core permission, not a
  Seeds one, controls who sees the toolbar.
- The "Add" tray links are additionally access-filtered per entity type in
  `SeedsManager::buildMenu()` (e.g. `create <type> block content` / `access block library` /
  `administer blocks` for blocks), so users only see create links they can actually use.
