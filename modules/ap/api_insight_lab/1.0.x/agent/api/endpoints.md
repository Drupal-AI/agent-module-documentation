<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Insight Lab — endpoints & controllers

All routes are in `api_insight_lab.routing.yml`. Two access tiers:
- **Admin JSON API** (`_permission: 'administer site configuration'`) — everything under `/api/perf-test/*`, `/api/discovery`, and the dashboard.
- **Public mock endpoints** (`_access: 'TRUE'`) — everything under `/api/test/*`.

There is no `_csrf_token` requirement on any route; the admin endpoints rely solely on the permission plus their `application/json` bodies. `ApiTestController::build()` attaches a `csrf_token` (`\Drupal::csrfToken()->get('rest')`) into `drupalSettings` for the SPA's use against core REST, not for these custom routes.

## Dashboard
- `api_insight_lab.dashboard` — GET `/admin/config/development/api-insight-lab` → `ApiTestController::build` renders `<div id="api-insight-lab-app">` + attaches library `api_insight_lab/react_app`.

## Core test execution (`ApiTestController`)
- `run_test` — POST `/api/perf-test/run` → `runTest`. Body: `{url, method, headers, body, concurrency(1-100), iterations(1-1000), timeout(1-120), bypassCache, auth{type,...}, loadPhaseConfig{...}, assertions[], config_id}`. Validates `url` with `FILTER_VALIDATE_URL`; caps total requests (`concurrency*iterations`) at 100,000. Dispatches `runLoadTest` or `runPhasedLoadTest` (Guzzle `Pool`, k6-style VUs×iterations). Persists a `api_perf_result` entity, evaluates assertions, returns full stats/percentiles/bottleneck/timeSeries JSON (`buildResults`).
- `chains_run` — POST `/api/perf-test/chains/run` → `runChain`. Executes `steps[]` sequentially: `replaceVariables()` substitutes `{{var}}` in url/headers/body, per-step auth, `extractJsonPathFromString()` pulls values from responses into `variables` for later steps.

`auth` handling (both runTest and runChain): `basic` → `Authorization: Basic base64(user:pass)`, `bearer` → `Authorization: Bearer <token>`, `apikey` → arbitrary `headers[keyName]=keyValue`.

## Presets, groups, assertions
- `save_preset` POST / `get_presets` GET / `update_preset` PUT `/api/perf-test/preset/{id}` / `delete_preset` DELETE `/api/perf-test/presets/{id}` — CRUD over `api_test_config`. `detectGroupFromUrl()` auto-groups by first `rest`/`api` path segment.
- `get_groups` GET `/api/perf-test/groups`.
- `save_assertions` POST `/api/perf-test/assertions` — replaces all `api_assertion` rows for a `config_id`. Types: `status_code`, `response_time`, `json_path`, `header` (see `evaluateAssertions`/`evaluateOperator`); operators equals/contains/gt/lt/gte/lte/neq/exists/not_exists.

## Snapshots
- `snapshots_save` POST / `snapshots_list` GET `/api/perf-test/snapshots`; `snapshots_detail` GET, `snapshots_delete` DELETE `/api/perf-test/snapshots/{id}`; `snapshots_bulk_action` POST `/api/perf-test/snapshots/bulk` (only `delete` implemented); `snapshots_compare` GET `/api/perf-test/snapshots/compare/{id1}/{id2}` (`calculateDiff` returns added/removed/changed keys). Version number auto-increments per `config_id`.

## Settings (State API)
- `get_settings` GET / `save_settings` POST `/api/perf-test/settings` → `getSettings`/`saveSettings`, stored via `\Drupal::state()` under key `api_insight_lab.settings` (baseUrl, defaultAuthType, defaultUsername/Password/Token/ApiKey, defaultTimeout, defaultConcurrency). NB: `getGlobalSettings`/`saveGlobalSettings` (config-based) also exist in the class but are **not routed**.

## Discovery
- `discovery` GET `/api/discovery` → `discovery`. Enumerates enabled `rest_resource_config` routes and (if `jsonapi` enabled) `jsonapi.*` routes, returns them with absolute URLs built from `\Drupal::request()->getSchemeAndHttpHost()`.

## Import / export (`ConfigExportController`)
- `export_configs` POST `/api/perf-test/export` — serialises selected presets+chains; strips auth fields unless `includeAuth` true.
- `import_configs` POST `/api/perf-test/import`, `import_batch` POST `/api/perf-test/import/batch` (uses core Batch API when ≥50 items). `applyUrlMappings()` does from→to `str_replace` on URLs.
- Environment profiles: `get_environments` GET, `save_environment` POST, `delete_environment` DELETE `/{id}`, `set_active_environment` POST `/api/perf-test/environments/active`.

## Public mock endpoints (`TestApiController`, `_access: TRUE`)
`/api/test/health`, `/echo` (GET/POST/PUT/DELETE, reflects body+headers), `/delay?ms=` (sleeps, capped 5000ms), `/status/{code}`, `/users`, `/users/{id}`, `/users/{id}/posts`, `/login` (POST, returns fake token), `/protected` (checks Bearer, returns randomised fake `sk_live_...` data), `/orders` (POST), `/random`. All return static or `rand()`-generated mock data only.

## REST resource plugin
- `PerformanceTestResource` (`@RestResource id=api_insight_lab_test`) at `/rest/perf-test`, `/rest/perf-test/{id}` — GET/POST/PATCH/DELETE returning mock data. Inert until enabled + permissioned through core REST config.
