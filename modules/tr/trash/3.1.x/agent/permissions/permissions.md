<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Static permissions in `trash.permissions.yml`; dynamic per-entity-type (and per-translation)
permissions from `TrashPermissions::entityTypePermissions` (`permission_callbacks`).

| Permission | Gates |
|---|---|
| `administer trash` | Configure which entity types/bundles use the trash bin (settings form) and access the trash listing. Trusted permission. |
| `access trash` | View the contents of the trash bin at `/admin/content/trash`. |
| `view deleted entities` | View individual soft-deleted entities (in the `in_trash` view context). |
| dynamic `restore <type> entities` | Restore trashed entities of that entity type. |
| dynamic `purge <type> entities` | Permanently delete (purge) trashed entities of that type. |
| dynamic `restore <type> translations` | (Translatable types only) restore individual translations. |
| dynamic `purge <type> translations` | (Translatable types only) purge individual translations. |

## How they are enforced

- The listing routes (`trash.admin_content_trash[_entity_type]`) require
  `access trash+administer trash` (either grants access).
- The single restore/purge forms are routed with `_entity_access: {type}.restore|purge`, which
  runs through `Drupal\trash\Hook\TrashEntityAccess::entityAccess()`
  (`hook_entity_access`). That hook forbids restore/purge unless the account holds the matching
  `restore/purge <type> entities` (or, for a translation, `<type> translations`) permission,
  and — for purge under Workspaces — only in the workspace the entity belongs to (checked
  against the undecorated workspace information service). Restoring/purging a translation whose
  default translation is also deleted requires access to the default too, plus the relevant
  content-translation permissions.
- The bulk restore/purge multiple forms are routed with `_permission: access trash`, but the
  submit handlers re-check `access('restore'|'purge')` per entity/translation and skip anything
  the user may not act on (reporting an "insufficient permissions" warning). The bulk actions
  `entity:restore_action` / `entity:purge_action` override `access()` the same way.
- All state-changing operations use Form API confirm forms (POST + CSRF token) or the
  confirmed Drush/CLI path; there are no state-changing GET routes.

```
drush role:perm:add content_editor 'access trash'
drush role:perm:add content_editor 'restore node entities'
```
