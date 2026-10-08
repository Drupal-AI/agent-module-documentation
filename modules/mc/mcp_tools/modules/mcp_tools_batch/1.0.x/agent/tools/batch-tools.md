<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Batch (bulk) tools

Plugins in `src/Plugin/tool/Tool/`, delegating to `mcp_tools_batch.batch` (`BatchService`).
Operation **Write**, `MCP_CATEGORY = 'batch'` → permission **`mcp_tools use batch`**,
write-kind **content**. Hard cap `BATCH_LIMIT = 50` items per call.

| Tool id | Class | Inputs | Does |
|---|---|---|---|
| `mcp_batch_create_content` | `CreateMultipleContent` | `content_type` (string, required), `items` (list, required) | Creates up to 50 nodes of one type from an array of field maps. |
| `mcp_batch_update_content` | `UpdateMultipleContent` | `updates` (list, required) | Updates up to 50 nodes; each entry carries an id plus field values. |
| `mcp_batch_publish` | `PublishMultiple` | `ids` (list, required), `publish` (bool) | Publishes (or, `publish=false`, unpublishes) up to 50 nodes. |
| `mcp_batch_delete_content` | `DeleteMultipleContent` | `ids` (list, required), `force` (bool) | Deletes up to 50 nodes; published nodes are skipped unless `force=true`. |
| `mcp_batch_create_terms` | `CreateMultipleTerms` | `vocabulary` (string, required), `terms` (list, required) | Creates up to 50 taxonomy terms in one vocabulary. |
| `mcp_batch_assign_role` | `AssignRoleToUsers` | `role` (string, required), `user_ids` (list, required) | Assigns one role to up to 50 users. |

Each returns per-item `created`/`updated`/`deleted`/`skipped`/`errors` lists plus a summary
message.

## Access enforcement

`McpToolsToolBase::checkAccess()` applies `mcp_tools use batch` + the **write** scope +
`content` write-kind policy + read-only switch. Every `BatchService` method independently
guards with `if (!$this->accessManager->canWrite()) return getWriteAccessDenied();`, enforces
`BATCH_LIMIT`, and audit-logs successes. `deleteMultipleContent` additionally refuses to delete
a **published** node unless `force=true`.

## Notes

- Authorization is the MCP connection's scope and the `mcp_tools use batch` permission; the
  service acts as the configured executor account.
- Content-only mode (write-kind `content`) must be permitted by policy for these to run.
