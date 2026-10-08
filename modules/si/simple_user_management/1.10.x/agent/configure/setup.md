# Setting up Simple User Management

No settings form (`configure` is null). "Configuration" is entirely a matter of granting permissions and
adjusting the People view so a non-admin role can reach the operations.

## Steps (from the module README, condensed)

1. Enable the module (pulls in `role_delegation`).
2. Grant the delegating role (e.g. `editor`) the core **`view user information`** permission.
3. Grant that role the relevant **Role Delegation** "assign *X* role" permissions (e.g. assign
   `editor`/`author`) — but NOT the admin role, to keep the site safe.
4. Optionally grant `create user accounts` (lets the role use `/admin/people/create`), and any of
   `approve user accounts`, `deactivate user accounts`, `delete user accounts`,
   `change user passwords` (restricted).
5. Edit the **People** view (`/admin/structure/views/view/user_admin_people`) and set its access to
   `view user information` so the delegated role can open the list; add the operations links or expose
   `/admin/people` in a menu they can reach.

## Grant permissions with Drush

```bash
ddev drush role:perm:add editor 'view user information'
ddev drush role:perm:add editor 'approve user accounts,create user accounts,deactivate user accounts,delete user accounts'
# Role Delegation permissions are named "assign <rid> role":
ddev drush role:perm:add editor 'assign editor role,assign author role'
```

## The create-user route swap

`RouteSubscriber::alterRoutes()` rewrites core `user.admin_create`: it removes the
`_entity_create_access` requirement (which needs `administer users`) and sets the route requirement to
`_permission: create user accounts`. So `/admin/people/create` becomes reachable by the `create user
accounts` holder. Which roles they can then assign on that form is governed by Role Delegation, not by
this module.

## What it does NOT provide

- No admin config page, no config entities, no config schema.
- No Drush commands of its own.
- No email/notification settings — deactivate/delete pass empty notify values to `user_cancel()`.
