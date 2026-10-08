<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit Export (audit_export) — agent index

Inventories and reports on a Drupal site's structure — content types, entity fields, blocks,
menus, taxonomy, views, enabled modules (with version + available-update status), and a users×roles
matrix — then stores each report and lets you view, CSV-export, schedule (cron), or push it to a
remote endpoint. Audits are **plugins** (`@AuditExport` annotation) discovered by the
`plugin.manager.audit_export_audit` manager; each report is processed via the Batch or Queue API
and its rows are persisted as JSON in the `audit_export_report` DB table. The real entry points are
the admin reports UI at **`/admin/reports/audit-export/reports`** (overview → run → view →
download), the settings form at **`/admin/config/system/audit-export`**, five `drush audit-export:*`
commands, and — with the optional `audit_export_tool` submodule — a set of Tool API tools for
AI/agent access.

- Depends on: `audit_export_core` (the parent `audit_export` module is a thin metapackage; the core
  submodule holds the plugin system, services, routes, permissions, drush, and config).
- Core: `^10 || ^11`. PHP `>=8.1`. Package: `Audit Export`.
- Settings page / configure route: **`audit_export_core.settings`** (`/admin/config/system/audit-export`).
- Permissions: 3 in core (`access audit export reports`, `process audit reports`,
  `administer audit export settings`, all `restrict access: TRUE`); 4 more in `audit_export_tool`.
- Drush: yes — `audit-export:list|run|export|queue|env`. Config schema: yes. Plugin type: yes
  (**`AuditExport`**). Cron: yes (optional queued processing; remote post on cron).
- Submodules: **`audit_export_core`** (required core), **`audit_export_post`** (POST reports to a
  configured remote URL), **`audit_export_tool`** (expose audits/reports as Tool API tools for
  MCP/agents; requires `drupal/tool`).

## What you'd do → where

- **Configure export storage, cron scheduling, and the remote-post endpoint** →
  [configure/settings.md](configure/settings.md)
- **Write a custom audit (plugin), or understand the bundled audits and their data types** →
  [plugins/audit-export.md](plugins/audit-export.md)
- **Call the report/plugin services from code; the report DB storage; the invoked hooks & events** →
  [api/services.md](api/services.md)
- **Expose audits to AI agents / MCP via Tool API (the `audit_export_tool` submodule)** →
  [api/tool-api.md](api/tool-api.md)
- **Run/export audits from the command line** → [drush/commands.md](drush/commands.md)
- **Who can view / run / export / administer audits (and how each route/tool is gated)** →
  [permissions/permissions.md](permissions/permissions.md)

## Key facts (real machine names)

- Routes (`audit_export_core`): `audit_export_core.audit_export_reports`
  (`/admin/reports/audit-export/reports`), `.view_group` (`…/reports/{group}`), `.view_report`
  (`…/reports/{group}/{id}`), `.process_audit` (`…/reports/{group}/{audit_name}/process`),
  `.audit_export_process_all` (`…/reports/process-all`), `.download_report`
  (`/admin/reports/audit-export/download/{group}/{id}`), `.settings`
  (`/admin/config/system/audit-export`). Controller
  `Drupal\audit_export_core\Controller\AuditExportCoreController`. Post route:
  `audit_export_post.post_audit` (`/admin/config/audit-export/post/{audit_name}`).
- Services: `plugin.manager.audit_export_audit` (`AuditExportPluginManager`),
  `audit_export_core.audit_report` (`AuditExportAuditReport` — DB read/write of reports),
  `audit_export_core.cron` (`AuditExportCron` — queues audits), `audit_export_core.audit_export_display`
  (`AuditExportDisplay`), `audit_export_core.audit_export_audit_data`,
  `audit_export_core.audit_export_audit_group`, `logger.channel.audit_export`. Post:
  `audit_export_post.remote_post` (`AuditExportRemotePost`), `audit_export_post.event_subscriber`.
- Plugin type: annotation `Drupal\audit_export_core\Annotation\AuditExport`, interface
  `AuditExportPluginInterface`, base `AuditExportPluginBase`, manager
  `plugin.manager.audit_export_audit`, dir `Plugin/AuditExport`, alter hook `audit_export_info`.
  Annotation keys: `id`, `label`, `description`, `group`, `data_type` (`flat`|`process`|`cross`),
  `identifier`, `dependencies`.
- Bundled audit plugin ids: `content_type_audit`, `entities`, `blocks_enabled`, `menus_audit`,
  `views_audit`, `site_report`, `active_users_roles_audit`, `taxonomy_vocabulary`, `enabled_modules`.
- Queue worker: `audit_export_processor` (`Plugin/QueueWorker/AuditExportProcessor`). DB table:
  `audit_export_report` (cols `audit`, `author`, `date`, `fid`, `data`). Library attached by the
  display service: `audit_export/audit_export.styles`.
- Config objects: `audit_export_core.settings` (filesystem save + cron keys),
  `audit_export_post.settings` (remote URL/auth/TLS), `audit_export_tool.settings` (pagination).
- Invoked hooks (module handler `invokeAll`/`alter`): `hook_audit_export_process_complete($audit_name, $data)`,
  `hook_audit_export_audit_finished($audit_name, $data, $success)`,
  `hook_audit_export_batch_complete($audits)`, and post-module alters
  `hook_audit_export_post_url_alter`, `…_site_info_alter`, `…_data_alter`, `…_request_options_alter`.
- Drush commands: `audit-export:list` (aexl), `audit-export:run` (aexp/audit-export:process),
  `audit-export:export` (aexe), `audit-export:queue` (aexq), `audit-export:env` (aexenv).
- Tool API tools (`audit_export_tool`): `audit_export_list`, `audit_export_definition`,
  `audit_export_run`, `audit_export_report_get`, `audit_export_report_row`, `audit_export_queue`,
  `audit_export_csv`, `audit_export_clear`, plus derived `audit_export_derived:{audit_id}`.
