# Simple User Management — manual setup guide

**Simple User Management** (`simple_user_management`) gives non‑administrator roles
— for example a client's "editor" — a lightweight interface to approve, create,
deactivate, delete, and change the passwords of other users, all **without** granting
the powerful *Administer users* permission. It leans on the
[Role Delegation](https://www.drupal.org/project/role_delegation) module to bound
which users and roles a delegated manager is allowed to touch, so you can hand
day‑to‑day people management to a non‑technical site owner while keeping full site
administration to yourself.

Each account‑lifecycle action is its own permission, so you can mix and match what a
role can do: **approve user accounts**, **create user accounts**, **deactivate user
accounts**, **delete user accounts**, and **change user passwords** (the last is a
restricted permission, since setting a password means the operator learns it). The
approve/deactivate/delete actions appear as operation links on the core People list,
and the module also swaps the access check on core's "Add user" form so a holder of
*Create user accounts* can reach `/admin/people/create` without *Administer users*.

The safety model comes from Role Delegation: for the deactivate, delete, and
change‑password actions, a manager may only act on a target user whose every
(non‑authenticated) role is one the manager is allowed to delegate. So an editor who
can only delegate the "editor" and "author" roles cannot block, delete, or repassword
an administrator. Managers also can't deactivate or delete themselves.

This module has **no settings page**. Setting it up is entirely a matter of granting
the right permissions and adjusting the People view so a non‑admin role can reach the
operations. It depends on the **Role Delegation** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (with Role Delegation)
   with Composer and enable it.

## Where it lives in the admin menu

There is no admin configuration page. The management actions are confirm forms at
`/admin/manage-users/{approve|deactivate|delete|change-password}/{user}`, normally
reached as operation links from the **People** list (`/admin/people`). The "Add
user" form is core's at `/admin/people/create`. You grant the permissions at
**People → Permissions** (`/admin/people/permissions`).

## How to use it

Setup is done through permissions and a small tweak to the People view:

1. Enable the module — this pulls in **Role Delegation**.
2. Grant your delegating role (for example `editor`) the core **View user
   information** permission so it can see the People list.
3. Grant that role the relevant **Role Delegation** "Assign *X* role" permissions —
   for example *assign editor role* and *assign author role* — but **not** the
   administrator role, which is what keeps the site safe.
4. Grant the Simple User Management permissions the role should have, chosen from:
   **Create user accounts**, **Approve user accounts**, **Deactivate user
   accounts**, **Delete user accounts**, and **Change user passwords** (restricted).
5. Edit the **People** view
   (`/admin/structure/views/view/user_admin_people`) and set its access to **View
   user information** so the delegated role can open the list, then make sure they
   have a menu link or path to reach `/admin/people`.

You can do the permission grants with Drush, for example:

```bash
drush role:perm:add editor 'view user information'
drush role:perm:add editor 'approve user accounts,create user accounts,deactivate user accounts,delete user accounts'
drush role:perm:add editor 'assign editor role,assign author role'
```

(Prefix with `ddev` when running from your host.)

### What the actions do

- **Approve** — activates an inactive account.
- **Deactivate** — blocks the user (core "cancel: block"), keeping their content;
  self‑deactivation and re‑blocking an already blocked user are refused.
- **Delete** — cancels the account, offering either to reassign their content to
  Anonymous or remove it; self‑deletion is refused.
- **Change password** — sets a new password directly (restricted permission).

All of these (except approve) refuse to act on a user whose roles the current
manager cannot delegate. Successful actions redirect back to `/admin/people`.

### For developers

A single alter hook,
`hook_simple_user_management_delete_role_delegation_check_alter()`, lets code bypass
the delegation guard for **deletion** — for example when cleaning up users that hold
externally‑synced roles.
