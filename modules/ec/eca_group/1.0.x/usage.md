<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ECA Group adds two Group-module building blocks to ECA: an action that compares the members of two membership lists, and a condition that checks whether the current user has a given group permission.

---

ECA Group integrates the ECA (Events-Conditions-Actions) no-code automation framework with the Group module. In this 1.0.x release it contributes exactly two ECA plugins and nothing else — no events, no membership-changing actions, no services, no routes and no permissions. The action `List: compare members in memberships` (id `eca_group_list_compare_memberships`) extends ECA Base's list-compare action and returns the diff or intersection of two lists of group memberships, matching on the underlying member user. The condition `Group: current user has permission` (id `eca_group_current_user_has_group_permission`) takes a Group entity from an ECA token/context and evaluates whether the current user holds a chosen group permission in that group. Both are used inside ECA models built in the ECA UI; you supply the group and membership lists from other events/actions in the model. Because it only compares data and reads a permission, ECA Group is a lightweight complement to broader Group automation rather than a full membership-management toolkit.

---

- Compare two lists of group memberships and get the members present in one but not the other (diff).
- Compare two lists of group memberships and get the members present in both (intersect).
- Detect members who left a group between two points by diffing an old and a new membership list.
- Detect members newly added to a group by diffing the new list against the old list.
- Find the overlap of members between two different groups' membership lists.
- Feed the compared membership result into another ECA action (e.g. send a message to each member).
- Branch an ECA model based on whether the current user has a specific group permission.
- Gate a group-related automation step so it only runs for users with, say, "administer members" in a group.
- Verify a user's group permission before allowing an ECA-driven content operation in that group's context.
- Build role/permission-aware notifications: only notify current users who hold a given group permission.
- Use the current-user group-permission condition to short-circuit an ECA model early when access is missing.
- Combine the condition with ECA's negation to act only when the current user LACKS a group permission.
- Pass a group loaded by another ECA plugin into the condition via the entity context.
- Reference a group by ID (scalar token) and still evaluate the current user's permission on it.
- Drive membership-audit workflows: diff scheduled membership snapshots and log the changes.
- React to group-content or membership tokens produced elsewhere in an ECA model and compare them.
- Automate onboarding checks by confirming a permission before continuing an ECA sequence.
- Build no-code group logic that mixes standard ECA events/actions with a group-permission gate.
- Select the group permission to check from a UI dropdown listing all defined group permissions.
- Keep group automation declarative in configuration rather than in custom PHP.
