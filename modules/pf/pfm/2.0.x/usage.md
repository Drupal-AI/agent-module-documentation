<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Permissions filtered by modules (pfm) adds a separate permissions administration page with AJAX filters for modules and roles, making the permissions grid manageable on sites that have many modules and/or roles.

---

The module provides its own form, `\Drupal\pfm\Form\PfmUserPermissionsForm`, which extends
Drupal core's `UserPermissionsForm`, at `/admin/people/pfm-permissions` (route
`pfm.admin_permissions`, gated by the core `administer permissions` permission). It does **not**
override the core `/admin/people/permissions` page or the core permissions form — it is an
additional, filtered view. At the top of the page it renders a "Permissions Filters" fieldset with
two multi-select AJAX controls: **Select Modules** and **Select Role**. The permissions table is
built only for the modules you select (it returns early with an empty table until at least one
module is chosen), and only columns for the selected roles (or "All Roles") are shown. This keeps
the rendered grid small instead of listing every permission for every role. As it extends the core
form, saving uses core's own submit handler (`user_role_change_permissions`), so it respects core
behaviour: admin (`isAdmin()`) roles show all boxes checked and disabled, and `restrict access`
permissions still display the standard security warning. It reuses the core
`user/drupal.user.permissions` JS library, mirrors core's trick of listing `access content` under
the Node module, and optionally attaches the `permissions_dragcheck` module's libraries when that
module is present. No config, no schema, no Drush, no new permissions of its own.

---

- Manage user permissions on a large site without scrolling the full core permissions grid.
- Filter the permissions table to a single module (e.g. only *Node* permissions).
- Filter to several modules at once to compare related permissions.
- Filter the visible role columns to just the roles you're editing.
- Reduce page weight/render time on sites with dozens of modules and roles.
- Edit permissions for one custom role in isolation by selecting only that role.
- Grant a batch of permissions for a newly installed module by selecting just that module.
- Audit which roles hold a specific module's permissions via the filtered view.
- Keep the core `/admin/people/permissions` page intact while offering an easier alternative.
- Provide site builders a focused permissions screen under People → PFM Permissions.
- Use AJAX filtering so changing module/role selection refreshes the grid without a full reload.
- See the standard "security implications" warning on restricted permissions while filtering.
- Confirm admin roles retain all permissions (shown checked+disabled, as in core).
- Combine with the Permissions Dragcheck module for drag-to-check bulk toggling on the filtered grid.
- Speed up permission reviews during audits by narrowing to relevant modules.
- Onboard editors faster by showing only the handful of permissions that matter to them.
- Avoid accidental edits to unrelated permissions by hiding them from the grid.
- Manage permissions role-by-role on multi-role sites (memberships, editorial workflows).
