# Duplicate Role — permission & duplicate flow

## Permission
| Permission | restrict access | Gates |
|---|---|---|
| `administer duplicate role` | **TRUE** | The duplicate form/route, the per-row "Duplicate" operation, and the "Duplicate role" local action. |

## Route & UI
- `duplicaterole.overview` — `/admin/people/roles/duplicate/{role}` (`{role}` defaults to `none`),
  form `Drupal\duplicate_role\Form\DuplicateRoleForm`, `_permission: administer duplicate role`.
- `hook_entity_operation` adds a `duplicate` operation on each `user_role` row (only when the
  current user has the permission).
- Local action `duplicate_role.role_duplicate` appears on `entity.user_role.collection`.

## Form behavior (`DuplicateRoleForm`)
- `buildForm`: a `base_role` select (all roles; hidden when the route already carries a valid
  `role`), a required `label` textfield (max 40), and a required `id` machine_name (uniqueness
  checked via `Role::load`).
- `submitForm`: resolves the base role id from the route parameter, else from `base_role`. If the
  base role loads, it does:
  ```php
  $new_role = Role::create(['id' => $new_role_id, 'label' => $new_role_name]);
  $new_role->save();
  user_role_grant_permissions($new_role->id(), $base_role->getPermissions());
  ```
  then redirects to `entity.user_role.collection`. If the base role is missing, an error message is
  shown and nothing is created.

## Scope / notes
- Copies **permissions only** — no fields, view/form displays, or other role config.
- The new role's permissions are exactly the base role's; the actor cannot inject arbitrary
  permissions through this form.
- Because the trigger permission is `restrict access: TRUE`, this is intended for trusted admins;
  grant it only to roles you also trust with role/permission administration.
