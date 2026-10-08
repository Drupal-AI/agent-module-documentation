<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Batch (mcp_tools_batch) — agent index

Submodule of **mcp_tools**. Adds Tool API plugins for **bulk** operations — mass-create,
update, publish/unpublish, and delete nodes, create taxonomy terms, and assign a role to many
users — from an MCP/AI connection. Package *MCP Tools*. Core `^10.3 || ^11 || ^12`.
Depends on **mcp_tools** only. No routes, forms, or config of its own.

- **The six tools, inputs/outputs, limits and enforcement** →
  [tools/batch-tools.md](tools/batch-tools.md)

## What it provides

- Six `tool` plugins in `src/Plugin/tool/Tool/`, all extending `McpToolsToolBase` (operation
  **Write**) with `MCP_CATEGORY = 'batch'`: `CreateMultipleContent`
  (`mcp_batch_create_content`), `UpdateMultipleContent` (`mcp_batch_update_content`),
  `PublishMultiple` (`mcp_batch_publish`), `DeleteMultipleContent` (`mcp_batch_delete_content`),
  `CreateMultipleTerms` (`mcp_batch_create_terms`), `AssignRoleToUsers`
  (`mcp_batch_assign_role`).
- One service `mcp_tools_batch.batch` (`Service/BatchService.php`) over
  `@entity_type.manager`, `@entity_field.manager`, `@current_user`, `@module_handler`,
  `@mcp_tools.access_manager`, `@mcp_tools.audit_logger`, `@datetime.time`. `BATCH_LIMIT = 50`
  items per call.
- One permission: **`mcp_tools use batch`** (`restrict access: true`).

## Access model (inherited)

Gated by `McpToolsToolBase::checkAccess()` — `mcp_tools use batch` + **write** scope +
write-kind (`batch` → **content**) + read-only switch. Every `BatchService` method also starts
with `if (!$this->accessManager->canWrite())`. See [tools/batch-tools.md](tools/batch-tools.md).

## Operate

```bash
drush en mcp_tools_batch -y
```

Grant `mcp_tools use batch` to the executor role. Each tool processes at most 50 items.
