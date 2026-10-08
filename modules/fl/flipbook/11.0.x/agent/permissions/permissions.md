# Flipbook — permissions

Declared in `flipbook.permissions.yml`; enforced by `FlipbookAccessControlHandler`.

| Permission (title) | Gates |
|---|---|
| `view flipbook entity` | `view` op on a flipbook (canonical `/flipbook/{id}`). |
| `add contact entity` (title "Add Flipbook entity") | **See typo note** — intended to gate create. |
| `edit flipbook entity` | `edit`/`update` op. |
| `delete flipbook entity` | `delete` op. |
| `administer flipbook entity` (`restrict access: TRUE`) | The entity `admin_permission`: full access, plus the collection/settings/choose-style routes. |

## Access handler logic (`FlipbookAccessControlHandler`)

```
checkAccess:  view   → allowedIfHasPermission('view flipbook entity')
              edit/update → allowedIfHasPermission('edit flipbook entity')
              delete → allowedIfHasPermission('delete flipbook entity')
              default → AccessResult::allowed()     // e.g. non-standard ops
checkCreateAccess → allowedIfHasPermission('add flipbook entity')
```

Because `administer flipbook entity` is the entity's `admin_permission`, core's
`EntityAccessControlHandler::access()` grants **all** operations to anyone holding it, regardless of
the per-op checks above.

## Gotcha: create-permission name mismatch

`checkCreateAccess()` checks the permission **`add flipbook entity`**, but `flipbook.permissions.yml`
actually defines **`add contact entity`** (a leftover from the example "contact" entity these files
were derived from). That machine name (`add flipbook entity`) is therefore **not grantable in the UI**
— so *Add flipbook* works only for users who also have `administer flipbook entity` (which bypasses
the create check via the admin-permission grant). If you need a non-admin role to create flipbooks,
either grant it `administer flipbook entity` or patch the permission name. This is a functionality
bug, not an access-bypass (it fails closed — it grants *less* access, not more).

## Grant with Drush

```bash
ddev drush role:perm:add editor 'view flipbook entity'
ddev drush role:perm:add editor 'edit flipbook entity'
ddev drush role:perm:add flipbook_manager 'administer flipbook entity'  # needed to create
```
