<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Orchestrator - Export (api_orchestrator_export) — agent index

Data export (CSV/Excel/PDF/JSON) and scheduled emailed reports for API Orchestrator. Depends on `api_orchestrator`. All routes require `administer api orchestrator`.

## Provides
- Service `api_orchestrator.export` (`ExportService`) — render request data to CSV/Excel/PDF/JSON (uses temp files via `file_system`).
- Service `api_orchestrator.scheduled_report` (`ScheduledReportService`) — CRUD + cron dispatch of scheduled reports; stored in config object `api_orchestrator.scheduled_reports` (schema declared in the parent module's `config/schema/api_orchestrator.schema.yml`).
- `ApiOrchestratorExportHooks` (constructed with the scheduled-report service) — cron generation/emailing.
- SDC components `export_page`, `scheduled_reports`.

## Routes (`api_orchestrator_export.routing.yml`)
- `…/export` → `ExportController::exportPage`; `…/export/download` → `::exportDownload`.
- `…/reports` → `::scheduledReportsPage`; `…/reports/add` + `…/reports/{report_id}/edit` → `ScheduledReportForm`; `…/reports/{report_id}/delete` → `ScheduledReportDeleteForm`.
- `…/reports/{report_id}/toggle` → `ExportController::toggleReport` — **POST + `_csrf_token: 'TRUE'`**.

No entities, plugins or permissions of its own. `ScheduledReportService` uses `@current_user`, `@datetime.time`, `@email.validator`, `@plugin.manager.mail`.
