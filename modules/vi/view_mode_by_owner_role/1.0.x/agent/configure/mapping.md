<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring owner-role view-mode mapping

All three forms require the `administer site configuration` permission and live under
`/admin/config/system/view_mode_by_owner_role/`.

## Step 1 — Choose roles
Path: `.../view-mode-settings-choose-role`
Select the roles that will participate as mapping keys. Stored as `choosed_roles`.
After this, users may be assigned at most **one** of these roles — the module's
`ViewModeByOwnerRoleUserRoleNumber` constraint fails validation on the user add/edit
form if two chosen roles are selected together.

## Step 2 — Choose replaceable view modes
Path: `.../view-mode-settings`
Indicate, per node bundle, which existing view modes are eligible to be replaced.

## Step 3 — Map role → replacement view mode
Path: `.../settings-map-role-view-mode`
For each bundle + original view mode, pick the replacement view mode to use when the
node owner has a given role. Stored as nested config `map_role_view_mode`
(`bundle → original_view_mode → role → replacement_view_mode`).

## Runtime behaviour
When a node is rendered, `ChangeNodeViewMode` loads the node's owner, intersects the
owner's roles with the mapped roles, and if the current bundle + view mode is mapped
for that role, substitutes the replacement view mode. Non-node entities and unmapped
bundle/view-mode combinations are untouched.

## Scope / safety
This only selects a display; it never changes access. Ensure the replacement view
modes are enabled for the bundle, or rendering falls back to the requested mode.
