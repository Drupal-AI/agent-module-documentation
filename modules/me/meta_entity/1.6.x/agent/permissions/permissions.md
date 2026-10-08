<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

## Static permission (`meta_entity.permissions.yml`)

| Permission | Notes |
|------------|-------|
| `administer meta entity` | `restrict access: true`. `admin_permission` of both `meta_entity` and `meta_entity_type`. Grants full access to type admin (`/admin/structure/meta-entity`), the meta-entity content UI, and every meta entity operation. |

## Dynamic per-type permissions (permission callback)

`meta_entity.permissions.yml` registers a `permission_callbacks` entry pointing at
`Drupal\meta_entity\MetaEntityPermissionProvider::getPermissions`. It loads every `meta_entity_type`
and emits four permissions per type (`<type_id>` is the type's machine name; the entity-key suffix is
`meta-entity`, i.e. `meta_entity` with `_`→`-`):

| Permission string | Operation granted |
|-------------------|-------------------|
| `create <type_id> meta-entity` | Create a meta entity of that type. |
| `view <type_id> meta-entity` | View meta entities of that type. |
| `update <type_id> meta-entity` | Edit meta entities of that type. |
| `delete <type_id> meta-entity` | Delete meta entities of that type. |

Example for a type `visits`: `create visits meta-entity`, `view visits meta-entity`,
`update visits meta-entity`, `delete visits meta-entity`.

## How access is decided

`MetaEntityAccessControlHandler` (extends core `EntityAccessControlHandler`):
- `checkAccess()` — for `view`/`update`/`delete`: first defers to core (which grants on
  `administer meta entity`); otherwise allows if the account has
  `"{$operation} {$bundle} meta-entity"`, adding the meta entity as a cacheable dependency.
- `checkCreateAccess()` — core first (admin permission), else `"create {$bundle} meta-entity"`.

These per-type permissions and the admin permission are the *only* gate on meta entity operations
and on the canonical route `/meta-entity/{meta_entity}` (`_entity_access: meta_entity.view`). Grant
them deliberately — a role with `view <type> meta-entity` can view any meta entity of that type
through the content list and canonical route.

## Grant via drush

```bash
drush role:perm:add editor 'view visits meta-entity'
drush role:perm:add editor 'update visits meta-entity'
```
