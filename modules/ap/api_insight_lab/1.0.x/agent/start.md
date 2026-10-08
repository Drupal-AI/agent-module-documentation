<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Insight Lab (api_insight_lab) — agent index

React-based admin dashboard for load-testing, chaining, asserting on, and inspecting HTTP/REST APIs from inside Drupal. Core-only feature module (no config schema, no custom permissions).

## What it is
- One admin page `/admin/config/development/api-insight-lab` (`ApiTestController::build`) mounts a bundled React SPA (`api_insight_lab/react_app` library). All work happens via JSON endpoints the SPA calls.
- `info.yml`: `core_version_requirement: ^10 || ^11`; `package: Development`; `configure: api_insight_lab.dashboard`.
- **Dependency:** `drupal:rest` only. No composer requirements beyond core.

## Access model (important)
- Every real endpoint (dashboard + all `/api/perf-test/*`) requires the **core** permission `administer site configuration`. The module defines **no permissions of its own** (no `*.permissions.yml`).
- The `/api/test/*` endpoints are **public** (`_access: 'TRUE'`) — intentional dummy/mock targets returning static or random data (`TestApiController`).

## Entities (7 content entities, all `admin_permission = administer site configuration`)
| Entity id | Class | Purpose |
|---|---|---|
| `api_test_config` | `Entity/ApiTestConfig` | Saved presets (name, url, method, config_json, group_id) |
| `api_assertion` | `Entity/Assertion` | Assertions bound to a preset via `config_id` |
| `api_snapshot` | `Entity/ApiSnapshot` | Versioned response snapshots |
| `environment_profile` | `Entity/EnvironmentProfile` | Env profiles (base_url, variables, is_active) |
| `request_chain` | `Entity/RequestChain` | Multi-step chains (steps_json) |
| `api_perf_result` | `Entity/TestResult` | Persisted run summaries |
| `api_perf_setting` | `Entity/ApiSetting` | Legacy setting entity |

Entity schema installed via `hook_update_N` in `api_insight_lab.install`; all deleted on uninstall.

## Controllers / routes
- `ApiTestController` (`src/Controller/ApiTestController.php`, ~2500 lines) — the core: `runTest`, `runChain`, presets CRUD, snapshots CRUD/compare, assertions, discovery, settings (State API). Uses `http_client_factory` (injected).
- `ConfigExportController` — export/import presets+chains, environment-profile CRUD.
- `TestApiController` — public mock endpoints only.
- Unrouted / dead classes present in `src/`: `ReactAppController`, `DummyApiController`, `SampleApiController`, `ApiDiscoveryController` (no routing entries).

## Plugins & forms
- `Plugin/rest/resource/PerformanceTestResource` — `@RestResource` `api_insight_lab_test` at `/rest/perf-test/{id}`, returns mock data (must be enabled + permissioned via core REST).
- `Plugin/QueueWorker/TestRunnerQueue` — stub queue worker (mock result).
- `Form/GlobalSettingsForm` — `ConfigFormBase` writing `api_insight_lab.settings` (default auth). **No route registers this form** and there is **no config schema** for it.

## Solution docs
- [agent/api/endpoints.md](api/endpoints.md) — full route table, request/response shape of `runTest`/`runChain`, assertions, discovery, import/export.
- [agent/entities/entities.md](entities/entities.md) — entity fields and how presets/assertions/snapshots/chains/environments relate.
- [agent/config/settings.md](config/settings.md) — how settings are stored (State API + config), install/uninstall, and how to operate the tool.
