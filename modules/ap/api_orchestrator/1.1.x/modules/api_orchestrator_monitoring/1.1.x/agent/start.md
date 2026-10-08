<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Orchestrator - Monitoring (api_orchestrator_monitoring) — agent index

Real-time dashboard over API Orchestrator request logs. Depends on `api_orchestrator`. All routes require `administer api orchestrator`.

## Provides
- `MonitoringController` with page `api_orchestrator.monitoring` (`/admin/config/services/api-orchestrator/monitoring`) and cache-disabled AJAX JSON endpoints: `…monitoring.api.realtime` (`apiRealtime`), `…api.heatmap` (`apiHeatmap`), `…api.recent` (`apiRecent`).
- SDC component `monitoring_dashboard` with polling JS (`js/monitoring-dashboard.js`), `ApiOrchestratorMonitoringHooks` (theme).
- No entities, plugins, permissions or config schema of its own.

## Query handling
Aggregates use `Database::select('api_orchestrator_request')` with static/parameterized `addExpression` (`COUNT(*)`, `AVG(CASE WHEN duration_ms>0 …)`, `DAYOFWEEK/HOUR(FROM_UNIXTIME(created))`) and `groupBy('day_of_week'|'hour')`. User inputs: heatmap `type` (`requests`/duration) selects which static expression to add, `days` cast to int, live feed `limit` (min-capped by `MAX_LIST_LIMIT`) and `after_id` cast to int and used as a bound `condition('r.id', $afterId, '>')`.
