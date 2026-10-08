<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group Bulk Operations (group_bulk_operations) — agent index

Adds **core Views bulk-form actions for the Group module**: assign a group role, remove a member,
or change the group owner across many groups in one Batch API run. Requires `group` (Group 2.x/3.x).
Version **3.1.2**, core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Works with **core Views**
bulk forms — NOT the contrib Views Bulk Operations module.

## Mechanism (verified from source)
1. **Views field handler** `group_bulk_form` (`src/Plugin/views/field/GroupBulkForm.php`, extends
   core `Drupal\views\Plugin\views\field\BulkForm`) is exposed on the `groups` Views base table via
   `group_bulk_operations_views_data()` in `group_bulk_operations.views.inc`. Add it to a groups
   view to get a checkbox column + action select.
2. **Three Action plugins**, `type = "group"` (`src/Plugin/Action/`): `group_assign_role`,
   `remove_group_user`, `update_group_owner`. Each `executeMultiple()` only records the selected
   group IDs (keyed by langcode) into the current user's **private tempstore**; the actual work is
   deferred. Their `access()` returns the group's `'update'` access. Default config entities that
   register the actions ship in `config/install/system.action.*.yml`.
3. Each action's `confirm_form_route_name` redirects to a **configuration form** where the operator
   picks the target user(s) and runs the batch:
   - `/admin/group/assign_group_role` → `Form\AssignGroupRoleMultiple` — adds the user as a member
     with the chosen group roles; if already a member it **removes then re-adds** (role set is
     replaced, not merged).
   - `/admin/group/remove_group_role` → `Form\RemoveGroupUserMultiple` — removes the membership
     where it exists.
   - `/admin/group/update_group_owner` → `Form\UpdateGroupOwnerMultiple` — `setOwnerId()` + save.
   All three routes require the global **`administer group`** permission (`.routing.yml`).

## Key facts
- **Permissions provided:** none. **Drush commands:** none. **Config schema:** none (ships default
  `system.action.*` config only). **Submodules:** none.
- **Gate:** everything that mutates is behind `administer group`, the Group module's site-wide
  super-permission that already bypasses per-group access. The per-group `'update'` check in the
  actions' `access()` is a no-op relative to that gate (see below).
- **Owner form quirk:** `#tags => TRUE` autocomplete but only the first user is used (`reset()`).
- **Assignment quirk:** re-adding replaces the member's entire role set on each affected group.

## Two operational consequences (of what it does, not how it is built)
1. **Bulk changes are hard to review and undo.** No per-group record of why N memberships changed
   at once. Run the view, **check the count**, then act.
2. **Membership drives content access.** A bulk removal can silently revoke access people rely on;
   a bulk grant can expose material they should not see.

## Sub-docs
- `agent/plugins/actions.md` — the action plugins, the views field, and the batch forms in detail.
