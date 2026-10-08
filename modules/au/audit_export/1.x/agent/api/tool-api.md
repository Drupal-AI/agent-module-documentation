<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — Tool API integration (`audit_export_tool` submodule)

`audit_export_tool` exposes audits and reports as **Tool API** plugins
(`Drupal\tool\Tool\ToolBase`, attribute `#[Tool(...)]`), so agents / MCP clients can list, run,
read, export and clear audits programmatically. It requires the `drupal/tool` contrib module
(`dependencies: tool:tool`, core `^10.3 || ^11`). Services use autowiring (`_defaults: autowire`).
Tool classes live in `src/Plugin/tool/Tool/`.

## Tools

| Tool id | Operation | Purpose | Permission (`checkAccess`) |
|---|---|---|---|
| `audit_export_list` | Explain | List audit plugins (optional `group` filter, `include_last_run`). | `view audit export reports` |
| `audit_export_definition` | Explain | Schema/metadata + status for one `audit_id`. | `view audit export reports` |
| `audit_export_report_get` | Read | Stored report rows for `audit_id`, paginated (`page`, `limit` 0–1000, `include_headers`). | `view audit export reports` |
| `audit_export_report_row` | Read | One row by index or by `identifier_value`. | `view audit export reports` |
| `audit_export_run` | Trigger (non-destructive) | Run an audit synchronously and return rows (`clear_existing`, `return_data`, `limit` 0–10000). Always clears before running. | `run audit export` |
| `audit_export_queue` | Trigger (non-destructive) | Queue an audit for cron/background processing. | `run audit export` |
| `audit_export_csv` | Read | Export a report to CSV (`save_to_file`, `filename`, `include_headers`, `delimiter`). | `export audit reports` |
| `audit_export_clear` | Trigger (**destructive**) | Clear stored data for one or all audits. | `administer audit export` |

Each tool implements `checkAccess(array $values, AccountInterface $account, …)` returning
`AccessResult::allowedIfHasPermission($account, <perm>)`, so access depends on the invoking
account's permissions (the Tool API framework is responsible for calling it). The four tool
permissions are declared in `audit_export_tool.permissions.yml` — see
[../permissions/permissions.md](../permissions/permissions.md).

Input validation: `audit_id` inputs are refined (`InputDefinitionRefinerInterface`) with a `Choice`
constraint limited to the registered audit ids; pagination/limit inputs carry `Range` constraints.

## Derived tools

`Deriver\AuditExportToolDeriver` generates one convenience tool per registered audit:
`audit_export_derived:{audit_id}` (dots/colons/dashes in the id → `_`), operation `Read`,
permission `view audit export reports`, params `page` / `limit`. `AuditExportDerived::doExecute()`
returns that audit's stored rows paginated. Toggle via `audit_export_tool.settings`
`enable_derived_tools`.

## MCP

When the `mcp` module is also present, these tools surface over the Model Context Protocol. Per the
submodule README, MCP tool names are namespaced and colons become triple underscores, e.g.
`audit-export-tool:tools_audit_export_run`,
`audit-export-tool:tools_audit_export_derived___content_type_audit`. This module integrates with
Tool API, not directly with MCP.

Note: on the reference site this submodule is not enabled (the `tool` dependency is absent), so the
above is from source, not runtime-verified.
