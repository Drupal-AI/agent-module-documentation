# Role Delegation — manual setup guide

**Role Delegation** (`role_delegation`) lets you hand out a small, carefully chosen slice of user-management power without giving anyone the keys to the whole site. Normally, the only way to let someone change other users' roles is to grant them *administer permissions* — but that permission effectively makes them a full administrator, able to rewrite the permission map for every role. Role Delegation closes that gap: it generates a fine‑grained *assign {role} role* permission for every role on your site, plus a blanket *assign all roles* permission, so you can say "this editor may grant the Contributor role, and nothing else."

Once a role is delegated to someone, the roles they are allowed to manage show up in two places: a new **Roles** tab on each user's profile (`/user/{user}/roles`), and as filtered checkboxes injected into the normal user add/edit form — always trimmed to just the roles that person is permitted to assign. The module also ships bulk **Action** plugins ("Add role to the selected users" / "Remove role from the selected users") and a Views bulk‑operations field, so delegated role assignment works from admin listings and Views too, with the same per‑role checks applied everywhere.

The module works the moment you enable it — there is no settings form to fill in. Instead, you "configure" it by granting the new permissions it creates on the standard **Permissions** page. It depends only on Drupal core's **User** module, ships no submodules, and requires no external libraries.

This guide is written for a **human** clicking through the admin UI. If you want terse, token‑cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable it.

## How to use it

Role Delegation has no settings page of its own. Everything happens through permissions and the per‑user Roles tab.

**1. Delegate roles via permissions.** Go to **People → Permissions** (`/admin/people/permissions`). After enabling the module you will find new checkboxes under its section:

- **Assign all roles** — lets the holder grant or revoke *any* role. This one is security‑sensitive (flagged *restrict access*); reserve it for trusted user‑managers who still should not have *administer permissions*.
- **Assign {role} role** — one permission is generated for every role on the site (except the locked *anonymous* and *authenticated* roles). Grant just these to delegate exactly the roles you intend, and nothing more.

Tick the appropriate boxes for the role you are delegating *to* (for example, give your "Editor" role the *Assign Contributor role* permission), then save.

**2. Assign roles as a delegated manager.** Anyone who holds at least one *assign …* permission can now:

- Visit a user's profile and open the **Roles** tab (`/user/{user}/roles`) to add or remove roles — but only the roles they are allowed to manage appear there.
- See the same filtered role checkboxes on the standard user create/edit form.
- Use the bulk **Add role to the selected users** / **Remove role from the selected users** actions on the People listing or in a View, again limited to their assignable roles.

**3. (Developers) Narrow the list further in code.** The assignable‑role list can be filtered programmatically with `hook_role_delegation_assignable_roles_alter()`, and the `delegatable_roles` service exposes the same list for custom forms and flows. See the [`agent/`](../agent/start.md) docs for details.
