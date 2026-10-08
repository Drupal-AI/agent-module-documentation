<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA Group (eca_group) — agent index

Integrates **ECA** (Events-Conditions-Actions, the no-code automation framework) with the
**Group** module. In this **1.0.x** release (installed 1.0.1) it provides exactly **two ECA
plugins** and nothing more — no events, no membership-mutating actions, no services, no routes,
no permissions, no Drush, no submodules.

- **Package:** ECA. **License:** GPL-2.0-or-later. **PHP:** `>=8.1`.
- **Core:** `^10.4 || ^11`.
- **Dependencies (`eca_group.info.yml`):** `eca:eca (^2||^3)`, `group:group (^3||^4)`.
- **Provides config schema:** yes (`config/schema/eca_group.schema.yml`, two plugin config maps).

## What it actually ships

Two plugin classes under `src/` — that is the entire codebase (plus `composer.json`,
`eca_group.info.yml`, the schema file, and CI/lint configs):

- **Action** `eca_group_list_compare_memberships` — "List: compare members in memberships".
  Subclass of ECA Base's `ListCompare`; diffs/intersects two lists of `GroupMembership`
  entities by member user id. →
  [plugins/action-compare-memberships.md](plugins/action-compare-memberships.md)
- **Condition** `eca_group_current_user_has_group_permission` — "Group: current user has
  permission". Checks `Group::hasPermission($permission, currentUser)` for a group taken from an
  ECA context. Read-only. →
  [plugins/condition-group-permission.md](plugins/condition-group-permission.md)

## Not present in this version

No ECA events, no add/remove-member or group-content actions, no `*.module`, no
`*.services.yml`, no `*.routing.yml`, no `*.permissions.yml`, no `config/install/`. Both plugins
are consumed inside ECA models built through the ECA UI; you feed them the group and the
membership lists from other plugins in the model.
