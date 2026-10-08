<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Better permissions page replaces Drupal's core permissions form at `/admin/people/permissions` with a faster one that only renders the permissions of a single provider module at a time, chosen from a select list.

---

The module solves the well-known problem where a site with 500+ (or 1000+) permissions makes the core `/admin/people/permissions` page slow or produces a white-screen-of-death timeout, because core renders every permission of every module in one giant table. It does this with a single route subscriber (`BetterPermissionsPageRouteSubscriber`) that swaps the `_form` of the existing `user.admin_permissions` route to its own `BetterPermissionsForm`, a subclass of core's `UserPermissionsForm`. The replacement form adds a "Permission provider" select whose options are the modules that declare permissions (derived from `permissionsByProvider()`); choosing one AJAX-loads only that module's permission rows into the roles table, so you never render the full list. Saving calls the same core API (`user_role_change_permissions()`) so grants are written exactly as core would write them, and the page redirects back to `user.admin_permissions` with a `#module-<provider>` fragment. It has no configuration page, no settings, no permissions of its own, no Drush commands, and no plugins; its only footprint is the route alteration plus a small JS/CSS library. Admin (superuser) roles keep their checkboxes disabled-and-checked exactly as in core.

---

- Fix a slow or timing-out `/admin/people/permissions` page on a site with hundreds or thousands of permissions.
- Prevent the WSOD/timeout that core's full permissions table causes on large sites.
- Manage permissions one module at a time by picking that module from the "Permission provider" select.
- Edit only Node module permissions without rendering every other module's permissions.
- Quickly grant a single contrib module's permissions to a role on a large multi-module site.
- Reduce page weight and memory when reviewing permissions during a security audit.
- Give site builders a usable permissions UI on enterprise sites with very long permission lists.
- Assign permissions for a newly enabled module by selecting just that provider.
- Avoid scrolling through an enormous table to find one module's permissions.
- Speed up permission administration on sites with many custom modules each defining permissions.
- Keep the exact core save behavior (`user_role_change_permissions`) while improving the UI.
- Preserve core's handling of admin roles (checkboxes disabled and checked) while filtering by provider.
- Land back on the relevant module's section (via the `#module-<provider>` fragment) after saving.
- Drop-in replacement: enabling the module immediately upgrades the existing permissions route with no config.
- Use on Drupal 9.5, 10, or 11 without any per-site setup.
- Let editors with `administer permissions` manage roles without the browser hanging on load.
- Reduce support tickets caused by the permissions page appearing to "hang" on big sites.
- Work around PHP `max_execution_time` limits hit when building the full permissions form.
- Filter to a single provider to compare a permission across all roles side by side.
- Roll out permission changes module-by-module as part of a staged access-control review.
- Keep using the standard permissions URL (`/admin/people/permissions`) so bookmarks and links still work.
- Serve as a lightweight alternative to more complex permission-management UIs.
- Provide a cleaner, less overwhelming permissions screen for non-expert administrators.
- Subclass or further alter `BetterPermissionsForm` to customize permission administration behavior.
