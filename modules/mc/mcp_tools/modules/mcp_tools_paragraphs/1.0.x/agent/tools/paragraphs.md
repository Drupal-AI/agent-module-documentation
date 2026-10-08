<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Paragraphs — Paragraphs structure tools

Submodule `mcp_tools_paragraphs`. All plugins live in `src/Plugin/tool/Tool/` and extend `Drupal\mcp_tools\Tool\McpToolsToolBase`. Permission for every tool: `mcp_tools use paragraphs`. `operation` sets the required MCP scope (Read->read, Write->write, Trigger->admin); `destructive` tools require explicit client confirmation.

| Tool id | Class | Operation | Notes |
| --- | --- | --- | --- |
| `mcp_paragraphs_list_types` | ListParagraphTypes | Read | List paragraph types. -> ParagraphsService::listParagraphTypes(). |
| `mcp_paragraphs_get_type` | GetParagraphType | Read | Describe one paragraph type and its fields. -> ParagraphsService::getParagraphType(). |
| `mcp_paragraphs_create_type` | CreateParagraphType | Write | Create a paragraph type (bundle). -> ParagraphsService::createParagraphType(). |
| `mcp_paragraphs_delete_type` | DeleteParagraphType | Write (destructive) | Delete a paragraph type. -> ParagraphsService::deleteParagraphType(). |
| `mcp_paragraphs_add_field` | AddParagraphField | Write | Add a field to a paragraph type. -> ParagraphsService::addField(). |
| `mcp_paragraphs_delete_field` | DeleteParagraphField | Write (destructive) | Remove a field from a paragraph type. -> ParagraphsService::deleteField(). |

Scope mapping: Read tools are usable by a read-scoped connection; Write tools need a write scope and fail closed under global read-only / config-only mode; Trigger tools need an admin scope. Services re-verify the scope and audit-log each mutation.

