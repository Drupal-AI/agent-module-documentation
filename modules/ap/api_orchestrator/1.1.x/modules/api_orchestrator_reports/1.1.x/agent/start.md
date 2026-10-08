<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Orchestrator - Reports (api_orchestrator_reports) — agent index

Interactive HTML report generation from API Orchestrator data. Depends on `api_orchestrator`. All routes require `administer api orchestrator`.

## Provides
- `ReportController` routes: `api_orchestrator_reports.report` (configure page, `/admin/config/services/api-orchestrator/report`), `.report.generate` (download), `.report.stream` (large datasets), `.report.preview` (AJAX).
- Service pipeline: `api_orchestrator.report_data_collector` (`ReportDataCollector`, parameterized SQL over the request table), `.report_health_calculator`, `.report_chart_builder`, `.report_html_builder`, `.report_styles_provider`, `.report_scripts_provider` (Chart.js), `.report_document_builder`, `.report_generator` (`ReportGeneratorService` coordinator).
- SDC component `report_config`, `ApiOrchestratorReportsHooks` (theme).
- No entities, plugins, permissions or config schema of its own.

## Input handling
`ReportController` reads query params: `download` (`0`/`1`), `preset` (default `30`), `date_from`/`date_to`, `service_id`, `company_name`, `logo_url`. Report SQL groups by date/hour/service/endpoint/method/response-code with static aggregate expressions; branding values are report display text.
