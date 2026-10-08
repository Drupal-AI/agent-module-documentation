<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Webform (mcp_tools_webform) — agent index

Submodule of **mcp_tools**. Adds seven Tool API plugins for managing webforms and their submissions,
callable by an AI assistant through the parent's MCP server. Version **1.0.0-beta8** (dir `1.0.x`).
Core `^10.3 || ^11 || ^12`. Depends on: `mcp_tools:mcp_tools`, `webform:webform`.
Permission: **`mcp_tools use webform`** (`restrict access: true`). No routes, config, or UI.

- **The seven tools, ids, ops, and inputs** → [tools/webform-tools.md](tools/webform-tools.md)

## What it provides

- Seven `#[Tool]` plugins in `src/Plugin/tool/Tool/`, all extending `McpToolsToolBase`
  (`MCP_CATEGORY = 'webform'`). Reads: `ListWebforms` (`mcp_list_webforms`), `GetWebform`
  (`mcp_get_webform`), `GetSubmissions` (`mcp_get_webform_submissions`). Writes: `CreateWebform`
  (`mcp_create_webform`), `UpdateWebform` (`mcp_update_webform`), `DeleteWebform`
  (`mcp_delete_webform`), `DeleteSubmission` (`mcp_delete_webform_submission`).
- Service `WebformService` (`mcp_tools_webform.webform_service`,
  `src/Service/WebformService.php`) holding all logic.
- No permissions beyond the one above, no Drush, no config schema, no hooks.

## Submission data note

Webform submissions may contain personal data. `WebformService::getSubmissions()` loads submissions
through an entity query with `->accessCheck(TRUE)`, so results honor webform-submission entity access
for the configured execution user; it returns per-submission `sid`, `uuid`, timestamps, owner `uid`,
`remote_addr`, and the element data. Gate the domain with `mcp_tools use webform` and run tools as a
least-privilege execution user.

## Access model

`McpToolsToolBase::checkAccess()` = `mcp_tools use webform` permission + connection scope (read for
the three read tools; `write` for create/update/delete) + write-kind policy (category `webform` →
**content**). The write service methods also re-check `AccessManager::canWrite()`, so global
read-only mode and `write` scope are enforced at the service layer. Every mutation is audit-logged.
See [[mcp_tools]] for the model.
