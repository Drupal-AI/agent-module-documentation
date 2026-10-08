<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Structure (mcp_tools_structure) — agent index

Submodule of **mcp_tools**. Structure operations: content types, fields, taxonomy, and roles. Core `^10.3 || ^11 || ^12`. Package `MCP Tools`.
Depends on: `mcp_tools:mcp_tools`, `drupal:field`, `drupal:node`, `drupal:taxonomy`, `drupal:user`. Permission: `mcp_tools use structure`.

It registers **20 Tool API plugins** in `src/Plugin/tool/Tool/` (all `MCP_CATEGORY` matching this domain), delegating to service(s) `mcp_tools_structure.content_type / .field / .taxonomy / .role`.

## Access model (inherited from mcp_tools)

Each tool extends `McpToolsToolBase`; dispatch calls `checkAccess()`, which requires the `mcp_tools use structure` permission **and** an MCP scope matching the tool's `ToolOperation` (Read->read, Write->write, Trigger->admin) **and** passes the config-only / global read-only policy. Mutating services additionally re-check `AccessManager::canWrite()` (or `canAdmin()`) and audit-log via `mcp_tools.audit_logger`. See [[mcp_tools]] for the full model.

## Tools (20)

`ListContentTypes`, `GetContentType`, `CreateContentType`, `DeleteContentType`, `ScaffoldContentType`, `ListFieldTypes`, `AddField`, `DeleteField`, `ListVocabularies`, `GetVocabulary`, `CreateVocabulary`, `CreateTerm`, `CreateTerms`, `SetupTaxonomy`, `ListRoles`, `GetRolePermissions`, `CreateRole`, `DeleteRole`, `GrantPermissions`, `RevokePermissions`. Full list with ids, operations and target services -> [agent/tools/structure.md](tools/structure.md).

