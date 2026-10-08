<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, cron, queues, Drush

All services declared in `audit.services.yml` (`src/Service/`).

## audit.runner — `AuditRunner`

`runAnalyzer(string $id, bool $save_score = TRUE): ?array` — resolves the plugin, calls
`checkRequirements()` (returns a `requirements_not_met` result if a tool is missing), runs
`analyze()`, and normalizes output into an AI-optimized structure: `audit_id`, `audit_name`,
`status`, `score` (`total`/`max`/`grade`/`factors`, weighted average), `summary`
(errors/warnings/notices/total_issues), `findings[]` (severity, category, code, message,
recommendation, file, line, check, module), `metadata` (drupal_version, timing, memory). Catches
`\Exception` → NULL on failure. `runAll()` runs every definition. Category is validated against
`security/performance/compatibility/best_practice` or inferred by keyword.

## audit.score_storage — `AuditScoreStorage`

State-API persistence. `saveScore($id, $score, $summary)` writes `audit.score.<id>` and updates the
`audit.scores.index`. `calculateAndSaveProjectScore()` computes the weighted `audit.project_score`
from all stored scores using `audit.settings:multipliers.<id>` (fallback = definition `weight`,
default 3; multiplier 0 skips) and stamps `audit.last_calculated_at`.
`getDataForExternalApi()` returns `site_uuid` + all analyzer scores for DruScan.

## audit.druscan_client — `DruscanClient` (+ `DruscanClientInterface`)

Optional portal sync. `sendAuditData()` / `testConnection()` build a payload
(`buildPayload()`: per-analyzer scores + factors, module inventory from the `updates` analyzer,
system status from the `status` analyzer, project score) and POST it to `<api_url>/report` with
headers `X-Project-Api-Key` / `X-Environment-Api-Key`. Default endpoint
`https://app.druscan.com/api/v1` (`DEFAULT_API_URL`), overridable only via `settings.php`. Handles
200/401/429 and stores rate-limit state (`audit.druscan_next_allowed`, `…_retry_after`,
`…_plan_interval`, `…_last_synced_at`). Sync is a no-op unless `isConfigured()` (enabled + both keys).

## audit.cron_scheduler — `AuditCronScheduler`

Called from `hook_cron` (`audit.module`). If DruScan is disabled it purges both queues and returns.
Otherwise it enqueues at most one item per queue: a recalculation into `audit_recalculate` (once per
24h, `RECALCULATE_INTERVAL`) and a sync into `audit_druscan_sync` (once per 24h **and** only when
`audit.last_calculated_at > audit.druscan_last_synced_at`). Heavy work runs in the workers.

## Queue workers (`src/Plugin/QueueWorker/`)

- `AuditRecalculate` (`audit_recalculate`) — recomputes the Project Score.
- `AuditDruscanSync` (`audit_druscan_sync`, 30s budget) — calls `DruscanClient::sendAuditData()`,
  isolated so network failures never block score calculation.

## Controller — `AuditResultsController`

`list()` builds the analyzer table + Project Score + a DruScan promo banner (when sync is off).
`detail($analyzer_id)` runs the analyzer **live** (`#cache max-age 0`), recalculates the project
score, and renders `buildDetailedResults()`. `runAll()` sets a Drupal batch (static
`runAnalyzerBatch` / `batchFinished` trusted callbacks) then recalculates once. 404s an unknown
`analyzer_id`.

## Drush — `AuditCommands` (`src/Drush/Commands/`)

- `drush audit:list` (alias `audit`) — table or `--format=json` of analyzers with score + last run.
- `drush audit:run <id|id,id|all>` — runs analyzers; `--format=json` (default), `--filter` (fields:
  severity, category, code, module, check, file — file is substring; AND across fields, OR within),
  `--fail-on=never|error|warning|any` for CI exit codes. JSON uses
  `JSON_INVALID_UTF8_SUBSTITUTE` (analyzers ingest arbitrary file contents).
- `drush audit:filters <id>` — runs an analyzer and lists the filter dimensions/values it produced.

## Render — `AuditComponentBuilder` (`audit.component_builder`)

Builds all render arrays: `score()` (Lighthouse circle), `section()`, `table()`/`header()`/`row()`/
`cell()`, `message()`, `buildIssueListFromResults()` (faceted), `calculateCounters()`,
`counterBadges()`. Markup goes through `Markup::create(Xss::filterAdmin(...))`. Theme hooks +
templates (`audit_section`, `audit_table`, `audit_code`, `audit_score`, `audit_factor`, `audit_item`,
`audit_message`, `audit_issue`, `audit_issue_list`, `audit_druscan_banner`) in `audit.module` /
`templates/`; JS faceting in `js/audit-filters.js` (library `audit/admin`).
