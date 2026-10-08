<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dashboard: routes, controller, UI

Source: `code_benchmarker.routing.yml`, `src/Controller/DashboardController.php`,
`templates/*.html.twig`, `code_benchmarker.links.menu.yml`, `code_benchmarker.libraries.yml`,
`css/code-benchmarker.css`.

## Routes

Both routes live under `/admin/config/development/code-benchmarker`, require the core permission
`administer site configuration`, and set `no_cache: TRUE`.

| Route | Path | Controller method | Runs work? |
|---|---|---|---|
| `code_benchmarker.dashboard` | `/admin/config/development/code-benchmarker` | `listScenarios` | No — lists scenarios only |
| `code_benchmarker.scenario` | `/admin/config/development/code-benchmarker/{scenario_id}` | `runScenario` | Yes — times one scenario |

`{scenario_id}` is constrained by the route requirement `[a-z0-9_.]+`. The controller looks the id
up among the tagged scenarios (`findScenario()`); no match throws `NotFoundHttpException` (clean
404). A menu link (`code_benchmarker.dashboard` in `.links.menu.yml`) places the index under
Configuration » Development. `configure:` in `.info.yml` points at the dashboard route.

## Controller (`DashboardController`)

- A `final` class registered as a service (`services.yml`) with two constructor args: the
  `BenchmarkRunner` and `!tagged_iterator code_benchmarker.scenario` (an iterable of every scenario
  service). No `create()` factory — the class resolver returns the wired instance.
- `collectScenarios()` materializes the tagged iterator into a list, **deduplicates by `id()`**
  (last one wins) and `ksort()`s so the index renders alphabetically regardless of discovery order;
  memoized on `$collectedScenarios`.
- `resolveIters(Request)` — reads `?iter=`, `(int)` casts, clamps to `[MIN_ITERATIONS=10,
  MAX_ITERATIONS=1000]`, default `DEFAULT_ITERATIONS=10`. This is the **only** request-derived value
  the controller consumes. `QUICK_ITERATIONS = [10, 100, 500, 1000]` drives the quick-pick links.
- `listScenarios()` builds a `#theme => 'code_benchmarker_list'` render array of scenario summaries
  (id, label, description, run_url, quick-iter links). `#cache => ['max-age' => 0]`. Runs nothing.
- `runScenario()`:
  - Best-effort lifts request limits: `set_time_limit(0)` (if the function exists) and
    `ini_set('memory_limit', '512M')` — because a scenario run does real work N times and can exceed
    PHP's default 30s / memory cap. Failures are deliberately not silenced.
  - Calls `$this->runner->run($scenario, $iters)`. If the result is `skipped`, renders the skip
    reason. Otherwise maps each `BenchmarkResult` to a template row via `buildResultRow()` (first
    row tagged `--baseline`, rest `--comparison` by position, not by label text).
  - Emits a speedup summary **only when exactly two implementations ran**: `speedup_avg =
    baseline.avgMs / other.avgMs`, `speedup_total = baseline.totalMs / other.totalMs` (guarded
    against divide-by-zero), and `same_result = baseline.lastResult === other.lastResult` (strict).
  - `#theme => 'code_benchmarker_scenario_run'`, `#cache => ['max-age' => 0]`.

## Templates & library

- `code_benchmarker_list` → `code-benchmarker-list.html.twig`: `<ul>` of scenarios; each shows
  label (link to run), machine id, `description|nl2br`, and quick-iter links. Empty-state message
  when no scenarios are registered.
- `code_benchmarker_scenario_run` → `code-benchmarker-scenario-run.html.twig`: a back link, the
  scenario header, re-run quick-iter links, then either a "SKIPPED: reason" line or the results
  table (Impl / Iters / Avg / Median / Min / Max / Std-dev / Total, each formatted with
  `number_format`) plus the optional speedup line with a colour-coded "Same return value? YES/NO".
- Both attach the `code_benchmarker/dashboard` CSS library. Descriptions/labels come from scenario
  classes (developer-authored), rendered through Twig autoescaping.
