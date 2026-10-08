<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# mcp_tools_moderation — tools reference

Plugins in `src/Plugin/tool/Tool/` extend `McpToolsToolBase` (`MCP_CATEGORY = 'moderation'`) and call
`ModerationService` (`mcp_tools_moderation.moderation`). Base `checkAccess()`:
`mcp_tools use moderation` + scope + read-only off. The Write tool also calls `canWrite()`.

## Tool table

| Tool id | Class | Operation → scope | Inputs | Returns |
|---------|-------|-------------------|--------|---------|
| `mcp_moderation_get_workflows` | `GetWorkflows` | Read → read | — | `count`, `workflows` (id/label/states/transitions) |
| `mcp_moderation_get_workflow` | `GetWorkflow` | Read → read | `id` (req) | workflow `states`, `transitions`, `entity_types` bound to it |
| `mcp_moderation_get_state` | `GetModerationState` | Read → read | `entity_type` (default `node`), `entity_id` (req) | `current_state` (id/label/published), `available_transitions` |
| `mcp_moderation_get_history` | `GetModerationHistory` | Read → read | `entity_type` (default `node`), `entity_id` (req), `limit` (default 50) | `workflow`, `revision_count`, `revisions` (id/state/author/message/timestamp) |
| `mcp_moderation_get_content_by_state` | `GetContentByState` | Read → read | `workflow_id` (req), `state` (req), `limit` (default 50) | `count`, `content` (id/type/bundle/label/changed) |
| `mcp_moderation_set_state` | `SetModerationState` | Write → write | `entity_type` (default `node`), `entity_id` (req), `state` (req), `revision_message` | `previous_state`, `new_state`, `changed` (bool) |

## Behaviour notes (from `ModerationService`)

- **Read tools** load workflows/entities through the entity type manager and
  `content_moderation.moderation_information`; `getContentByState()` runs an entity query with
  `range(0, $limit)`; `getModerationHistory()` walks revisions with a `range` limit. No mutation.
- **`mcp_moderation_set_state`** checks `accessManager->canWrite()` first, loads the entity, then
  validates the requested transition against the workflow (via
  `content_moderation.state_transition_validation`) — an unpermitted `current → target` transition is
  rejected with the list of available targets. On success it does
  `$entity->set('moderation_state', $state)->save()`, creating a new revision, and audit-logs.
  If the entity is already in the target state, `changed` is false and no revision is written.

## Operating it

1. `drush en mcp_tools_moderation -y` (needs `content_moderation` + `workflows`; parent `mcp_tools`).
2. Grant `mcp_tools use moderation` to the execution user; state changes need the **write** scope and
   read-only mode off.
3. Find the workflow/state (`mcp_moderation_get_workflows` / `_get_content_by_state`), inspect an
   entity (`mcp_moderation_get_state`), then transition it (`mcp_moderation_set_state`).
