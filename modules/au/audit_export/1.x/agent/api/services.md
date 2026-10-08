<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — services, report storage, hooks & events

All services are defined in `audit_export_core.services.yml` (+ `audit_export_post.services.yml`).

## Services

- **`plugin.manager.audit_export_audit`** — `AuditExportPluginManager` (extends `DefaultPluginManager`).
  Discovers `Plugin/AuditExport` classes, annotation `@AuditExport`, alter hook `audit_export_info`,
  cache bin `cache.default` key `audit_export_plugins`. Use `getDefinitions()`, `hasDefinition($id)`,
  `getDefinition($id)`, `createInstance($id)`. See [../plugins/audit-export.md](../plugins/audit-export.md).
- **`audit_export_core.audit_report`** — `Service\AuditExportAuditReport`. The report data store
  (details below). Tagged `audit_report`.
- **`audit_export_core.cron`** — `Cron\AuditExportCron`. `queueAudits($timeout): int` clears the
  `audit_export_processor` queue, then for each plugin chunks `prepareData()` into batches
  (`max(10, min(200, …))` items) and enqueues them.
- **`audit_export_core.audit_export_display`** — `Service\AuditExportDisplay`. `renderDisplay()`
  returns a `#theme => table` build attaching library `audit_export/audit_export.styles`; static
  `tokenDisplayCleanup()` / `getReplacementMap()` (escapes `<front>`).
- **`audit_export_core.audit_export_audit_data`** (`AuditExportAuditData`),
  **`audit_export_core.audit_export_audit_group`** (`AuditExportAuditGroup`) — helper services.
- **`logger.channel.audit_export`** — logger channel (`audit_export`).
- Post submodule: **`audit_export_post.remote_post`** (`Service\AuditExportRemotePost`),
  **`audit_export_post.event_subscriber`**, `logger.channel.audit_export_post`.

## Report storage — `AuditExportAuditReport`

Backs the `audit_export_report` table (schema in `.install`: `audit` varchar PK, `author` int,
`date` int, `fid` int [unused, always 0], `data` big blob). Data is stored as **JSON** (pretty-
printed) via `flattenDataForStorage()` (objects with `__toString` → string, `stdClass` → array,
else `[Object: Class]`). Key methods:

- `getReportData($audit_name): array` — JSON-decodes the row; falls back to
  `unserialize(..., ['allowed_classes' => FALSE])` for legacy serialized rows (never instantiates
  classes).
- `saveReport($audit_name, array $newRecord)` — insert/update; invokes
  `hook_audit_export_process_complete($audit_name, [$sanitizedRecord])`.
- `appendReportData($audit_name, array $newRecord)` — append one processed row.
- `clearReportData($audit_name)` — reset a report's `data` to `[]` and bump `date`.
- `updateReportDate($audit_name)` — bump `date`; also invokes `hook_audit_export_process_complete`.
- `getLastProcessedDate($audit_name)`, `getAllReports()`, `getReportMetadata($audit_name)`.

## Processing pipeline

`AuditExportCoreController` drives report generation with the Batch API:
- `processAudit($group, $audit_name)` — clears the report, then for `data_type = cross` runs
  `prepareCrossTabScripts()` + `processDataPreProcess()`, then batches `prepareData()` rows through
  `processData(['row_data' => …])`, appending each result.
- `processAll()` — batches every audit.
- Static batch ops (`processSingleAudit`, `processBatchOperation`, `processCrossTabScript`,
  `processPreProcessOperation`, `batchFinishedCallback`) re-fetch services from the container.
Drush and the `audit_export_run` tool run the same `prepareData → processData → appendReportData →
updateReportDate` loop without the Batch API.

## Hooks this module invokes (implement these to react)

- `hook_audit_export_process_complete($audit_name, $data)` — after a report is saved/updated
  (`audit_export_post` implements this to POST the report).
- `hook_audit_export_audit_finished($audit_name, $data, $success)` — after a single audit batch.
- `hook_audit_export_batch_complete($audits)` — after a "process all" batch.
- `audit_export_info` (alter) — alter discovered audit plugin definitions.

## Events

Event classes exist but are thin: `AuditExportQueueCompleteEvent`
(`const EVENT_NAME = 'audit_export_core.queue_complete'`) and, in the post submodule,
`AuditExportProcessCompleteEvent` (`'audit_export_core.process_complete'`). The primary extension
points in practice are the invoked hooks above and the post-module alter hooks
(`hook_audit_export_post_url_alter`, `…_site_info_alter`, `…_data_alter`,
`…_request_options_alter`; see `audit_export_post.api.php`).
