<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The filtered permissions page

Route `pfm.admin_permissions` → `/admin/people/pfm-permissions`, requirement
`_permission: 'administer permissions'`. Form: `\Drupal\pfm\Form\PfmUserPermissionsForm`
(extends core `Drupal\user\Form\UserPermissionsForm`). Reached via People → *PFM Permissions*.

There is **nothing to configure** — the module ships no settings. The page itself is the feature.

## How it works

- A **Permissions Filters** fieldset renders two multi-select controls, both with AJAX
  (`ajaxRefresh`, wrapper `pfm-user-admin-permissions-wrapper`):
  - **Select Modules** (`modules`) — options are the modules that actually provide permissions
    (`permissionHandler->getPermissions()` grouped by provider), sorted with `natcasesort`.
  - **Select Role** (`roles`) — `All Roles` plus every role.
- The `permissions` table renders **only** rows for the selected modules and **only** columns for
  the selected roles. Until at least one module is selected the form returns early and the table
  shows "Please choose at least one module."
- Because it subclasses the core form:
  - Save uses core's submit → `user_role_change_permissions()` (this module adds no custom save).
  - Roles where `isAdmin()` is true render every checkbox checked and `#disabled`.
  - Each permission's warning/description comes from core; `restrict access: TRUE` permissions get
    the standard "Give to trusted roles only; this permission has security implications." warning.
  - `access content` is displayed under the **Node** module group (mirroring core's UI trick),
    though it is provided by System.
- Attached libraries: `user/drupal.user.permissions`, plus
  `permissions_dragcheck/drag-check-js` and `permissions_dragcheck/permissions-drag-check`
  **only when** the `permissions_dragcheck` module is enabled.

## Notes for agents

- To grant/revoke permissions programmatically, use core APIs
  (`$role->grantPermission()/revokePermission()->save()` or `user_role_change_permissions()`);
  pfm changes only the admin UI, not the storage or access model.
- Access to this page is core `administer permissions` (a `restrict access: true`, trusted-admin
  permission) — the same gate as core's own permissions page.
