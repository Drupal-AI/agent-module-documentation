<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions & access gating

Two access models coexist: the UI/route model (`_permission` in routing.yml) and the Tool API
model (`checkAccess()` inside each tool plugin). All are permission-based; there are no
`_access: TRUE` or `access content` gated routes.

## Core permissions (`audit_export_core.permissions.yml`) — all `restrict access: TRUE`

| Permission | Grants |
|---|---|
| `access audit export reports` | View the reports overview, group, report, and **download CSV** routes. |
| `process audit reports` | Run a single audit or "process all" (`.process_audit`, `.audit_export_process_all`). |
| `administer audit export settings` | The settings form, and the post submodule's `audit_export_post.post_audit` route. |

## Route → permission map (`audit_export_core.routing.yml`, all `_admin_route: TRUE`)

| Route | Path | Permission |
|---|---|---|
| `audit_export_core.audit_export_reports` | `/admin/reports/audit-export/reports` | `access audit export reports` |
| `audit_export_core.view_group` | `…/reports/{group}` | `access audit export reports` |
| `audit_export_core.view_report` | `…/reports/{group}/{id}` | `access audit export reports` |
| `audit_export_core.download_report` | `/admin/reports/audit-export/download/{group}/{id}` | `access audit export reports` |
| `audit_export_core.process_audit` | `…/reports/{group}/{audit_name}/process` | `process audit reports` |
| `audit_export_core.audit_export_process_all` | `…/reports/process-all` | `process audit reports` |
| `audit_export_core.settings` | `/admin/config/system/audit-export` | `administer audit export settings` |
| `audit_export_post.post_audit` | `/admin/config/audit-export/post/{audit_name}` | `administer audit export settings` |

## Tool API permissions (`audit_export_tool.permissions.yml`)

Enforced by each tool's `checkAccess()` (`AccessResult::allowedIfHasPermission`):

| Permission | `restrict access` | Used by tools |
|---|---|---|
| `view audit export reports` | false | `audit_export_list`, `audit_export_definition`, `audit_export_report_get`, `audit_export_report_row`, `audit_export_derived:*` |
| `run audit export` | true | `audit_export_run`, `audit_export_queue` |
| `export audit reports` | false | `audit_export_csv` |
| `administer audit export` | true | `audit_export_clear` |

These four are distinct from the core three. `restrict access: false` is only a UI hint (no
warning shown when granting) — it does **not** grant the permission to any role automatically; a
role must still be assigned it. Because audit reports concentrate site-internal data, grant the
view/run/export/administer tool permissions deliberately, especially to non-admin roles or agent
service accounts.
