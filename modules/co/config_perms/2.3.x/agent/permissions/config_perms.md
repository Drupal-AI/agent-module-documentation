# Custom Permissions — permissions

## Static permission (defined in `config_perms.permissions.yml`)

| Permission | Title | Notes |
|---|---|---|
| `administer config permissions` | Administer custom permissions | `restrict access: true`. Gates the admin form at `/admin/people/custom-permissions/list` (route `custom_perms_select_list_form`). This is also the entity's `admin_permission`. |

Grant it to trusted admins only — anyone with it can create custom permissions and rewire
which routes they gate. (Update hook `config_perms_update_8202` auto-granted it to roles
that already had `administer site configuration` when the module was upgraded.)

## Dynamic permissions (one per enabled config entity)

`Drupal\config_perms\CustomPermissions::permissions()` (a `permission_callbacks` entry)
generates one grantable permission for **every enabled `custom_perms_entity`**. The
permission's machine name and title are the entity's **`label`**. Each carries the fixed
warning description: *"Warning: This permission may have security implications."*

Out of the box the module ships four such entities, so four dynamic permissions appear:

| Permission (label) | Route it unlocks |
|---|---|
| Administer account settings | `entity.user.admin_form` |
| Administer date time | `entity.date_format.collection` |
| Administer error logs | `dblog.overview` |
| Administer file system | `system.file_system_settings` |

## How access is decided for a gated route

1. `RouteSubscriber` (on router rebuild) replaces the target route's access requirements
   with the module's `_config_perms_access_check`.
2. `ConfigPermsAccessCheck` grants access iff the current user holds the permission named
   by the entity's label; otherwise **forbidden**.

Because the subscriber *removes* the route's original requirements, a role that previously
reached the page via `administer site configuration` will be blocked unless it is given the
matching custom permission. **User 1 always retains access.** To make scoping meaningful,
remove the broad `administer site configuration` from the roles you want to constrain, then
grant them only the specific custom permission(s) they need.
