<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How grants become node access

Workflow Access implements the core node-access hooks (via the `WorkflowAccessHooks` service,
`#[Hook]`-based, with `#[LegacyHook]` wrappers in `.module`):

- **`hook_node_access_records($node)`** — for the node's **current** workflow state, reads
  `workflow_access.role[$sid]` and emits one grant record per role that has any grant, using:
  - realm **`workflow_access`** for normal roles,
  - realm **`workflow_access_owner`** for the author (`WorkflowRole::AUTHOR_RID`) when the node has
    an owner — so the content author can be granted access distinct from their role.
  Each record sets `grant_view` / `grant_update` / `grant_delete` from the config, at priority
  `workflow_access_priority` (`WorkflowAccessSettingsForm::getSetting('workflow_access_priority')`).
- **`hook_node_grants($account, $op)`** — returns the realms/grant-ids the current user holds, so
  core can match them against the stored records.
- `hook_node_access_explain($row)` — Devel Node Access integration describing a
  `workflow_access` / `workflow_access_owner` row.
- `hook_ENTITY_TYPE_insert/update('user_role')` — reacts to role changes.

Because it plugs into `node_access`, only **node** entities are affected. Any change to grants (or
saving the Access form) calls `node_access_needs_rebuild(TRUE)`; run the rebuild (cron or
`drush php:eval 'node_access_rebuild();'`) for changes to take full effect.

Uninstalling the module forces a node-access rebuild (`hook_uninstall`).
