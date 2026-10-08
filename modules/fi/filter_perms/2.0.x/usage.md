<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Filter Permissions adds "Roles to display" and "Modules to display" filters to Drupal's user permissions page, so you can narrow the huge permissions grid to just the roles and modules you care about.

---

The module replaces the form on core's permissions routes with its own `PermissionsForm` (a subclass of core's `UserPermissionsForm`) via a `RouteSubscriber` that rewrites `user.admin_permissions` and `entity.user_role.edit_permissions_form`. The enhanced form adds a "Permission Filters" fieldset with two multi-select boxes — roles and permission-providing modules — plus a "Filter Permissions" button; only the selected roles (columns) and modules (permission groups) are then rendered in the permissions table. Selections are remembered per user in an expirable key/value store (collection `filter_perms_list`, keyed by user ID, expiring after one hour), so the grid stays filtered as you work. A special value `-1` (the `ALL_OPTIONS` constant) means "all roles" / "all modules". Until you pick at least one role and one module the table is empty with a helpful prompt. The module also counts form inputs against PHP's `max_input_vars` and disables saving (with an error) when the unfiltered grid would exceed it, which is the main practical reason to filter on sites with many permissions. It has no settings page of its own, defines no permissions (it reuses core's "administer permissions"), and requires only the core User module.

---

- Shrink an enormous permissions grid to just the roles you're currently editing.
- Show permissions for a single module (e.g. only "node" or "commerce") while assigning access.
- Avoid hitting PHP `max_input_vars` when saving permissions on a site with hundreds of permissions.
- Compare two specific roles side by side by selecting only those columns.
- Focus on one role's permissions by filtering to that role only.
- Speed up the permissions page render by limiting how many checkboxes are built.
- Let admins audit which modules a role can act on without scrolling the whole page.
- Reduce mistakes by hiding unrelated permission rows while granting access.
- Filter to a newly installed module's permissions to configure them quickly.
- Keep the permissions grid filtered per admin user for an hour of editing.
- Use the per-role permissions tab (edit_permissions_form) with the same filtering applied.
- Select "all roles" or "all modules" via the ALL_OPTIONS (-1) choice when needed.
- Prevent the "too many permissions to save safely" error by filtering before saving.
- Give large multisite installs a usable permissions UI.
- Narrow to security-sensitive modules to review "restrict access" permissions.
- Work through permissions module-by-module during a site build.
- Onboard a new admin by showing only the roles/modules they manage.
- Reduce browser strain from rendering thousands of permission checkboxes at once.
- Re-filter and re-save iteratively without losing your role/module selection.
- Audit a single custom module's permissions across all roles at once.
