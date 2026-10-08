<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Content — Content CRUD tools

Submodule `mcp_tools_content`. All plugins live in `src/Plugin/tool/Tool/` and extend `Drupal\mcp_tools\Tool\McpToolsToolBase`. Permission for every tool: `mcp_tools use content`. `operation` sets the required MCP scope (Read->read, Write->write, Trigger->admin); `destructive` tools require explicit client confirmation.

| Tool id | Class | Operation | Notes |
| --- | --- | --- | --- |
| `mcp_create_content` | CreateContent | Write | Create a node of a given `type` with `title`, optional `fields` map (text `{value,format}`, entity refs `{target_id}`, image `{target_id}`) and `status`. Returns `nid`/`uuid`. Author defaults to the execution user. -> ContentService::createContent(). |
| `mcp_update_content` | UpdateContent | Write | Update an existing node by `nid` with an `updates` map (only listed fields change; `title` supported). Saves a new revision. -> ContentService::updateContent(). |
| `mcp_publish_content` | PublishContent | Write | Set publish status of a node by `nid` (`publish` bool). Returns whether the status actually changed. -> ContentService::setPublishStatus(). |
| `mcp_delete_content` | DeleteContent | Write (destructive) | Permanently delete a node by `nid`. Flagged `destructive: TRUE`, so the client confirms first. -> ContentService::deleteContent(). |

Scope mapping: Read tools are usable by a read-scoped connection; Write tools need a write scope and fail closed under global read-only / config-only mode; Trigger tools need an admin scope. Services re-verify the scope and audit-log each mutation.

