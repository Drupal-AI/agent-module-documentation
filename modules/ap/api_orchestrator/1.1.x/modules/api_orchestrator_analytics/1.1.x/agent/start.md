<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Orchestrator - Analytics (api_orchestrator_analytics) — agent index

Charts dashboard over API Orchestrator request logs. Depends on `api_orchestrator`. All routes require `administer api orchestrator`.

## Provides
- `AnalyticsDashboardController` with page `api_orchestrator.analytics` (`/admin/config/services/api-orchestrator/analytics`) and cache-disabled AJAX JSON endpoints (`api_orchestrator.analytics.api.*`): `apiStats`, `apiTimeline`, `apiEndpoints`, `apiDistribution`, `apiRequests`.
- SDC component `analytics_dashboard` (Chart.js in `js/analytics-dashboard.js`), `ApiOrchestratorAnalyticsHooks` (theme).
- No entities, plugins, permissions or config schema of its own.

## Query handling
All aggregates use `Database::select('api_orchestrator_request')` with parameterized `addExpression` (`SUM(CASE WHEN status = :status …)`, `DATE_FORMAT(FROM_UNIXTIME(created), :date_fmt)`). User inputs are constrained: `granularity` maps via `match` to a whitelisted date-format pattern; `sort_by` is checked against an allowlist (`created,duration_ms,response_size,response_code,status`); `sort_order` normalized to ASC/DESC; filters bound as `condition()` values. `getFiltersFromRequest()` reads service_id/endpoint_id/status/method/date_from/date_to/min_duration/max_duration/response_code from the query string.
