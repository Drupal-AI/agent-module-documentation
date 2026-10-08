Simple User Management gives non-administrator roles (e.g. a client's "editor") a lightweight interface to approve, create, deactivate, delete, and password-change other users without the powerful `administer users` permission, using the Role Delegation module to bound which roles they may touch.

---

The module ships four confirm-style forms under `/admin/manage-users/{approve,change-password,deactivate,delete}/{user}`, each gated by its own permission (`approve user accounts`, `change user passwords`, `deactivate user accounts`, `delete user accounts`). It also swaps the access requirement on core's user-create route (`user.admin_create`, `/admin/people/create`) from `administer users` to its own `create user accounts` permission via a `RouteSubscriber`. It depends on `role_delegation` (`DelegatableRolesInterface::getAssignableRoles()`): the deactivate, delete, and change-password forms only allow acting on a target user whose every non-`authenticated` role is delegatable by the current user — so an editor who can delegate only "editor"/"author" cannot block, delete, or repassword an administrator. Deactivate/delete wrap core `user_cancel()` (block, reassign-content, or delete-content methods); approve calls `$user->activate()`. There is no global settings page (`configure` is null) and no config schema. A single alter hook, `hook_simple_user_management_delete_role_delegation_check_alter()`, lets code bypass the delegation gate for deletion (e.g. for externally-synced roles). The intended setup grants the delegating role `view user information` plus specific Role Delegation "assign X role" permissions, and points the core People view at `view user information`.

---

- Let a client's editor approve (activate) newly self-registered accounts that are pending approval.
- Give editors a "Create new account" flow without granting `administer users`.
- Allow editors to assign only a safe subset of roles (via Role Delegation) when creating/editing users.
- Deactivate (block) a user while keeping their content, from the People list.
- Delete a user and reassign their content to Anonymous.
- Delete a user together with all their content.
- Manually set/reset a user's password (restricted permission; implies the operator learns the password).
- Prevent editors from blocking/deleting/repassword-ing administrators by not delegating the admin role.
- Add quick approve/deactivate/delete operations links to the People (`user_admin_people`) view.
- Run an approval workflow: open registration "visitors create accounts with admin approval", then delegate approval to a client.
- Stop an editor from deactivating or deleting themselves (self-action is blocked).
- Bypass the delegation check for deletion of users holding externally-synced roles via the alter hook.
- Delegate day-to-day people management to a non-technical site owner.
- Keep a clear separation between "can manage editors" and "can administer the whole site".
- Expose a minimal People management surface to a role that should never reach `admin/config`.
- Reassign or purge spam accounts without full user administration rights.
- Activate an account that an admin left blocked, as part of a moderation queue.
- Give support staff password-reset capability without full account administration.
- Combine with a restricted People view so delegated managers see only the users they may manage.
- Model "team lead approves new team members" using approval + role delegation.
- Provide account lifecycle actions (approve → deactivate → delete) as discrete permissions you can mix per role.
