<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Role Hierarchy — agent index

Blocks lower-privileged users from editing/deleting users or granting/revoking roles above
their own rank. The hierarchy is the **role weight order at `/admin/people/roles`** (lower in
the list = less powerful, by default). No `configure` route: settings live on the People >
Roles form. Depends on core `user`.

- **Settings (`invert`, `strict`, `non_hierarchical_roles`) and how ordering defines rank** →
  [configure/hierarchy.md](configure/hierarchy.md)
- **Access logic: the `role_hierarchy.helper` service, weight comparison, user_access hook,
  and the overridden Add/Remove-role actions** → [api/access-logic.md](api/access-logic.md)
- **Permissions `bypass role hierarchy` and `edit user roles`** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts: config object `role_hierarchy.settings` (keys `invert`, `strict`,
`non_hierarchical_roles`) is created when you save the People > Roles form; it does not exist
until then. Enforcement points: `role_hierarchy_user_access()` (update/delete),
`role_hierarchy_form_user_form_alter` / `_register_form_alter` (role checkboxes),
`role_hierarchy_action_info_alter()` (bulk add/remove-role actions). User 1 is always
protected; `bypass role hierarchy` exempts an account from every check.
