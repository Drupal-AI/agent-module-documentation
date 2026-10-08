# Permissions & the routes they gate

Defined in `simple_user_management.permissions.yml`; routes in `simple_user_management.routing.yml`.

| Permission | `restrict access` | Gates | Delegation guard? |
|---|---|---|---|
| `approve user accounts` | no | `/admin/manage-users/approve/{user}` (`UserApprovalForm`) | no |
| `deactivate user accounts` | no | `/admin/manage-users/deactivate/{user}` (`UserDeactivateForm`) | yes |
| `delete user accounts` | no | `/admin/manage-users/delete/{user}` (`UserDeleteForm`) | yes (+ bypass hook) |
| `change user passwords` | **yes** | `/admin/manage-users/change-password/{user}` (`UserChangePasswordForm`) | yes |
| `create user accounts` | no | core `user.admin_create` (`/admin/people/create`), via `RouteSubscriber` | n/a (roles bounded by Role Delegation on the account form) |

`{user}` is constrained to `\d+`.

## The delegation guard

Deactivate, delete, and change-password each load the target user's roles and compare against
`\Drupal::service('delegatable_roles')->getAssignableRoles($current_user)` (Role Delegation). If the
target holds any role (other than `authenticated`) the current user cannot delegate, the operation is
refused with a warning. This is what stops an "editor" from blocking/deleting/repassword-ing an
administrator.

- Change-password also refuses when the current user has **no** assignable roles at all.
- Delete additionally fires `hook_simple_user_management_delete_role_delegation_check_alter()` which can
  set `$bypass_role_delegation_check = TRUE` to skip the guard (see `../api/hooks.md`).

## Operations behaviour

- **Approve** (`UserApprovalForm`) — if the target is inactive, shows username/email and an *Approve*
  button; submit calls `$user->activate()->save()`. Warns if already active.
- **Deactivate** (`UserDeactivateForm`) — blocks self-deactivation and re-deactivation of an already
  blocked user; on submit calls core `user_cancel(..., 'user_cancel_block')`.
- **Delete** (`UserDeleteForm`) — blocks self-deletion; offers `user_cancel_reassign`
  (content → Anonymous) or `user_cancel_delete` (content removed); calls `user_cancel()`.
- **Change password** (`UserChangePasswordForm`) — `password_confirm` element; sets and saves the new
  password directly.

All redirect back to `/admin/people` on success.
