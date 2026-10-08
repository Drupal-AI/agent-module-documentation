<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Redirect Extensions (redirect_extensions) — agent index

Add-on to the contrib **Redirect** module. It layers three things on top of core Redirect:
bulk-edit forms for a selection of redirects (change the HTTP status code, or change the
destination, for many at once), a replacement admin listing View with a CSV export, and
per-redirect authorship/timestamp tracking (created-by, created, modified).

- **Dependencies:** `redirect`, `views_data_export` (info.yml). composer.json requires only `drupal/core`.
- **Core:** `^9.4 || ^10 || ^11`.
- **Settings page:** none — no `configure` route, no config schema, no permissions of its own, no drush.
- **Access:** every surface reuses Redirect's existing **`administer redirects`** permission; this module declares no permission.

## Solutions
- **Bulk-change status code or destination on many redirects at once** → [configure/bulk-operations.md](configure/bulk-operations.md)
- **The replacement redirect listing View and its CSV export** → [views/redirects.md](views/redirects.md)
- **Track who/when a redirect was created or last modified** → [hooks/tracking.md](hooks/tracking.md)

## Key facts
- Routes: `entity.redirect.edit_status_code` → `/admin/config/search/redirect/edit/status`; `entity.redirect.edit_dest` → `/admin/config/search/redirect/edit/dest` (both `_permission: administer redirects`, both `_form`).
- VBO action plugins on the `redirect` entity type: `redirect_status_action` (`EditStatusRedirect`) and `redirect_dest_action` (`EditDestRedirect`); shipped as `system.action.*` config in `config/install`.
- Service `redirect_extensions.redirect_storage` = `Drupal\redirect_extensions\RedirectDatabaseStorage` (args `@database`, `@current_user`, `@datetime.time`).
- Custom DB table `redirect_extensions` (columns `aid`, `rid`, `uid_created`, `created`, `modified`) — `hook_schema` in the `.install`.
- View `views.view.url_redirects` (page at `/admin/config/search/redirect`, CSV export at `/admin/config/search/redirect/redirects.csv`); `hook_install` disables core's `redirect` view.
- Hooks implemented: `hook_redirect_insert` / `hook_redirect_update` / `hook_redirect_delete`, `hook_views_data`, `hook_views_api`, `hook_help`.
