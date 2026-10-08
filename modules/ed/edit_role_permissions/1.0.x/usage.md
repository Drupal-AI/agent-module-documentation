<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Edit Permissions by Default makes "Edit permissions" the default operation link on the roles admin list instead of "Edit".

---

Edit Permissions by Default is a tiny admin-UX module that reweights the **"Edit permissions"** operation on user role
entities so it sorts ahead of the standard **"Edit"** operation on the People > Roles list (`/admin/people/roles`). The
primary/default action for each role therefore jumps straight to that role's permissions page rather than the role edit
form (which only renames a role). It depends on core **User**, ships in the **Other** package, and works on Drupal 8, 9,
10 and 11. It is **access-neutral**: it only changes the display weight of an operation link via
`hook_entity_operation_alter()` — the permissions page it links to stays governed by core's own `administer permissions`
access, so the module grants no new capability and has no permissions, routes, services, or configuration of its own.

---

- Make "Edit permissions" the default action on the roles admin list.
- Reduce clicks when repeatedly editing role permissions during site building.
- Sort the "Edit permissions" operation ahead of "Edit" for every role.
- Jump straight from `/admin/people/roles` to a role's permissions form.
- Speed up permission tuning while configuring a new site.
- Streamline permission edits for content-heavy sites with many roles.
- Avoid accidentally opening the role rename form when you meant to edit permissions.
- Keep the standard "Edit" operation available (only its ordering changes).
- Install alongside core User with no extra dependencies.
- Enable the module and get the behavior immediately — no configuration step.
- Leave role permission access entirely to core (`administer permissions`).
- Use on Drupal 8, 9, 10 or 11 sites without code changes.
- Add zero configuration, routes, or permissions to your site.
- Help site builders who manage roles far more than they rename them.
- Improve the admin experience for agencies handing off sites to editors.
- Support workflows where roles are created once but permissions change often.
- Provide a consistent primary action across all role rows.
- Reorder role operations without altering their labels or targets.
- Remove the module to instantly restore core's default operation order.
- Combine with other admin-UX modules for a faster People/Roles workflow.
