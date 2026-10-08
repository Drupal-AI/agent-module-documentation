Duplicate Role adds a "Duplicate" operation to the user-roles list that creates a new role with a new name/machine name and copies all of an existing role's permissions into it.

---

The module is a single form plus an entity operation. On the *People → Roles* collection it adds a "Duplicate" operation link (and a "Duplicate role" local action) for each role, both gated by the `administer duplicate role` permission (which is `restrict access: TRUE`). The form (`DuplicateRoleForm` at `/admin/people/roles/duplicate/{role}`) asks for the base role to copy (pre-selected from the route when present), a new human label, and a new machine name (validated for uniqueness against existing roles). On submit it creates the new `user_role` config entity and calls `user_role_grant_permissions()` with the base role's full permission list, then redirects back to the roles collection. It does not copy anything beyond permissions (no field/display config), provides no config schema or Drush command, and has no dependencies beyond core `user`. It is a convenience tool for site builders who need a starting-point role similar to an existing one.

---

- Create a new role that starts with the same permissions as an existing role.
- Duplicate an "Editor" role to build a "Senior editor" variant, then tweak permissions.
- Bootstrap a new role from a well-configured baseline instead of ticking every permission.
- Clone a complex role's permission set to avoid manual re-selection mistakes.
- Add a "Duplicate" operation to each row on the *People → Roles* admin list.
- Use the "Duplicate role" local action on the roles collection page.
- Pre-select the base role by launching duplication from a specific role's operations.
- Give the duplicated role a distinct machine name (uniqueness enforced).
- Quickly stand up near-identical roles for multiple departments or sites.
- Speed up building a role hierarchy where each tier extends the previous one's permissions.
- Copy a template role's permissions when onboarding a new team with similar access.
- Restrict who can duplicate roles via the `administer duplicate role` permission (restrict access).
- Reduce configuration drift by starting new roles from an approved baseline role.
- Prototype permission sets by cloning and adjusting rather than editing the original.
- Recreate an accidentally-modified role by duplicating a known-good similar role.
- Provide a simple, dependency-free role-cloning tool on Drupal 8–11.
