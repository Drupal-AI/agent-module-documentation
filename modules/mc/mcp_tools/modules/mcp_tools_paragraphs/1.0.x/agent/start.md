<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Paragraphs (mcp_tools_paragraphs) — agent index

Submodule of **mcp_tools**. Paragraphs integration: manage paragraph types and their fields. Core `^10.3 || ^11 || ^12`. Package `MCP Tools`.
Depends on: `mcp_tools:mcp_tools`, `paragraphs:paragraphs`. Permission: `mcp_tools use paragraphs`.

It registers **6 Tool API plugins** in `src/Plugin/tool/Tool/` (all `MCP_CATEGORY` matching this domain), delegating to service(s) `mcp_tools_paragraphs.paragraphs (Drupal\mcp_tools_paragraphs\Service\ParagraphsService)`.

## Access model (inherited from mcp_tools)

Each tool extends `McpToolsToolBase`; dispatch calls `checkAccess()`, which requires the `mcp_tools use paragraphs` permission **and** an MCP scope matching the tool's `ToolOperation` (Read->read, Write->write, Trigger->admin) **and** passes the config-only / global read-only policy. Mutating services additionally re-check `AccessManager::canWrite()` (or `canAdmin()`) and audit-log via `mcp_tools.audit_logger`. See [[mcp_tools]] for the full model.

## Tools (6)

`ListParagraphTypes`, `GetParagraphType`, `CreateParagraphType`, `DeleteParagraphType`, `AddParagraphField`, `DeleteParagraphField`. Full list with ids, operations and target services -> [agent/tools/paragraphs.md](tools/paragraphs.md).

