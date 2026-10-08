<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Group Bulk Operations adds three Group-entity actions to a core Views bulk form — assign a group role, remove a member, and change the group owner — so an administrator can apply the same membership change across many groups in one batch instead of editing each group by hand.

---

The Group module models teams, departments, courses and organisations as entities that each own their membership and their own role set, and once a site has more than a handful of them the same three-click membership edit gets repeated dozens of times. This module answers that with the standard Drupal shape: a Views bulk form. It registers a Views field handler, `group_bulk_form` (a subclass of core's `BulkForm`), on the `groups` base table, so you add it to any view that lists groups and get a checkbox column plus an action dropdown. It then supplies three core Action plugins of type `group` — `group_assign_role` (Assign role), `remove_group_user` (Remove Group User) and `update_group_owner` (Update Group Owner). These actions do not mutate anything themselves; each one records the selected group IDs into the current user's private tempstore and, through its `confirm_form_route_name`, redirects to a configuration form. Those forms live at `/admin/group/assign_group_role`, `/admin/group/remove_group_role` and `/admin/group/update_group_owner`, and every one of them is gated by the global **`administer group`** permission — the correct gate, since bulk membership and ownership changes across a whole site's groups are exactly what that permission is for and there is no lesser one that fits. On the form the operator names the target user(s) via an entity-autocomplete (role assignment also offers the union of roles across the selected groups' group types), and submitting runs a Batch API process: assignment adds the user with the chosen roles (removing an existing membership first so roles are replaced, not merged); removal drops the membership where it exists; ownership sets `setOwnerId()` and saves each group. Two consequences follow from what the module does rather than how it is built. Bulk role and membership changes are **hard to review and harder to undo** — there is no per-group record of why forty memberships changed at once, so a mistaken selection surfaces later and is repaired by hand; run the view, check the count, then act. And because group roles typically drive **content access**, a bulk removal can silently revoke access people depend on and a bulk grant can expose material they should not see. Note it targets core Views bulk forms, not the contrib Views Bulk Operations module, and that assigning a role replaces the member's whole role set on each affected group.

---

- Add a moderator role to a user across many groups at once.
- Grant an instructor role to a user across every course group in a cohort.
- Remove a departing employee from all of their groups in one pass.
- Offboard a leaver: strip their membership from a filtered list of groups.
- Reassign group ownership to a new manager across a department's groups.
- Onboard a new team lead by giving them an admin role in every team group.
- Fix a mis-assigned role by re-running assignment (roles are replaced, not merged) on the affected groups.
- Bulk-transfer ownership of orphaned groups to a service account.
- Apply a term-start membership change across an academic year's group estate.
- Add a support account as a member of every organisation group for auditing.
- Promote a member to a manager role across all groups of one group type.
- Clean up membership after a reorganisation by removing users from retired groups.
- Give a compliance officer a read role across a large set of groups quickly.
- Standardise ownership so one team owns a whole class of groups.
- Run the action from a filtered/exposed-filter view to scope which groups are affected.
- Bulk-remove a compromised account from every group it belongs to.
- Replace a user's mixed roles with a single role consistently across groups.
- Reduce repetitive per-group membership administration on a large multi-group site.
- Batch-assign roles so long-running changes complete without timing out.
- Hand over a set of groups to a new owner before deactivating the old owner.
