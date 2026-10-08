<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WBM actions (workbench_moderation_actions) — agent index

Replaces core's Publish/Unpublish bulk actions with **one bulk action per Workbench Moderation
state**, so editors can set the moderation state of many nodes at once. Requires **Workbench
Moderation** (contrib), not core Content Moderation. No settings, no config UI (`configure:
null`), no permissions of its own.

- **The `state_change` Action plugin + its deriver (how per-state actions are derived/created)** →
  [plugins/state-change-action.md](plugins/state-change-action.md)
- **Install/uninstall config changes, execution logic, operation links & route** →
  [api/mechanism.md](api/mechanism.md)

Key facts: Action plugin id `state_change` with `StateChangeDeriver` → derivatives keyed
`<entity_type>__<state_id>` (e.g. `node__published`). `hook_install` deletes
`node_publish_action`/`node_unpublish_action` and creates an `action` config entity per
derivative (id like `state_change__node__published`, plugin `state_change:node__published`).
Actions show in the **Action** dropdown on `/admin/content`. Per-action access uses
`workbench_moderation.state_transition_validation`.
