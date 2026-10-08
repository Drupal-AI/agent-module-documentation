<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Insight Lab — install, configuration & operation

## Install / enable
- `composer require drupal/api_insight_lab` then `drush en api_insight_lab -y`.
- Requires core **REST** module (`dependencies: - drupal:rest`); no other contrib deps, no composer requirements beyond core `^10 || ^11`.
- Enabling installs the seven entity tables. If tables are missing after an upgrade, run `drush updatedb` (`api_insight_lab_update_8001/8002/9001` (re)install the entity schemas). `drush pm:uninstall api_insight_lab` empties all seven tables via `api_insight_lab_uninstall()`.
- No `*.permissions.yml` is shipped: access to everything real is the **core** permission `administer site configuration`. `info.yml` sets `configure: api_insight_lab.dashboard`, so the "Configure" link on the modules page opens the React dashboard.

## Where settings live (two independent stores)
1. **State API** — the operative one. `getSettings`/`saveSettings` (routes `/api/perf-test/settings`) read/write `\Drupal::state()->get('api_insight_lab.settings')`: `baseUrl`, `defaultAuthType`, `defaultUsername`, `defaultPassword`, `defaultToken`, `defaultApiKey`, `defaultTimeout` (30), `defaultConcurrency` (10). These are the defaults the SPA loads.
2. **Config object** — `api_insight_lab.settings` with a `default_auth.*` tree (type/basic_user/basic_pass/bearer_token/apikey_key/apikey_value). Written only by `Form/GlobalSettingsForm` (a `ConfigFormBase`) and by the unrouted `saveGlobalSettings` method. **There is no config schema** (`config/schema/` does not exist) and **no route** points at `GlobalSettingsForm`, so this store is effectively vestigial. `data.json`'s `provides_config_schema` is therefore false.

There is no `config/install/` — the module ships no default configuration.

## Running a test (operational summary)
1. Open `/admin/config/development/api-insight-lab`.
2. In the Load Tester: enter a target `url`, method, headers, optional body, VUs (`concurrency`, 1-100), iterations per VU (1-1000), timeout (1-120s), optional auth (basic/bearer/apikey), optional `loadPhaseConfig` for warmup/ramp-up/sustain/ramp-down.
3. The SPA POSTs to `/api/perf-test/run`; `ApiTestController::runTest` validates the URL, runs the Guzzle `Pool`, saves an `api_perf_result`, evaluates any assertions, and returns stats (RPS, p50-p99, stddev, bottleneck DNS/TCP/TLS/server/download, cache hits/misses, timeSeries).
4. Save the request as a preset (`api_test_config`), attach assertions, snapshot the response, or build a chain — all via the `/api/perf-test/*` endpoints (see `../api/endpoints.md`).

## Front-end assets
- Library `api_insight_lab/react_app` (`js/react-app/app.js` + `app.css`) — the compiled SPA. Source lives under `react-ui/` (Vite/React/TypeScript, shadcn-style UI components) and is not needed at runtime.
- Library `api_insight_lab/charts` — Chart.js 4.4.1 from jsDelivr CDN + `js/api-perf-charts.js` (declared but the SPA bundles its own charts).

## Notes for agents
- The `/api/test/*` endpoints are public practice targets returning mock/random data — do not treat their `token`/`api_key` output as real secrets.
- `ReactAppController`, `DummyApiController`, `SampleApiController`, `ApiDiscoveryController` exist in `src/` but have no routing entries (dead code); the live discovery logic is `ApiTestController::discovery`.
