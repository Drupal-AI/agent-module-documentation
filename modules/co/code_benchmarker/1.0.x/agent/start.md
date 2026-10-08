<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Code benchmarker (code_benchmarker) — agent index

A **dev-only admin dashboard** that times two-or-more competing implementations of the same
operation (legacy vs optimized, before/after a refactor) and shows a per-implementation timing
table plus a speedup summary. Other modules contribute **scenarios** by registering a service
tagged `code_benchmarker.scenario`; the dashboard discovers, runs, and times them all. There is
**no user-supplied code path** — scenarios are PHP classes wired as services, not snippets typed
into a form. Package `Development`. Core `^10.3 || ^11`. License GPL-2.0-or-later. Installed **1.0.0**
(version dir `1.0.x`).

> Not for production: the run route executes the scenario's work hundreds of times against the live
> database and lifts PHP's time/memory limits for the request.

## Dependencies

- Drupal core modules only: **`help`**, **`user`** (`.info.yml`). No contrib, no external PHP libs
  (`composer.json` declares no `require`).

## What it provides (from source)

- **Two routes** (`.routing.yml`, both gated by core permission `administer site configuration`,
  both `no_cache: TRUE`):
  - `code_benchmarker.dashboard` → `/admin/config/development/code-benchmarker`
    (`DashboardController::listScenarios`) — index page, lists scenarios, runs **nothing**.
  - `code_benchmarker.scenario` → `/admin/config/development/code-benchmarker/{scenario_id}`
    (`DashboardController::runScenario`) — runs one scenario. `{scenario_id}` constrained to
    `[a-z0-9_.]+`; unknown id → 404.
- **Only request input is `?iter=N`** — cast to int and clamped to `[10, 1000]` (default 10) in
  `resolveIters()`; propagated to scenario links and quick-pick `iter=10/100/500/1000` buttons.
- **Extension API**: `Benchmark\BenchmarkScenarioInterface` (`id`, `label`, `description`,
  `prepare`, `reset`, `implementations`); scenarios registered as tagged services and injected into
  the controller via `!tagged_iterator code_benchmarker.scenario`.
- **Runner** `Benchmark\BenchmarkRunner` — warm-up + pre-iter-1 reset + timed loop using
  `hrtime(TRUE)`; returns immutable DTOs `BenchmarkResult` (per-impl stats) wrapped in
  `BenchmarkRunResult` (`::ran()` / `::skipped()`). `BenchmarkSkipException` thrown from a
  scenario's `prepare()` skips it with a reason.
- **Two theme hooks / Twig templates**: `code_benchmarker_list`, `code_benchmarker_scenario_run`
  (`templates/`), plus `hook_help` (`help.page.code_benchmarker`). Hooks are OOP `#[Hook]` methods
  on `Hook\CodeBenchmarkerHooks` with `#[LegacyHook]` procedural shims in `.module` for D10.
- **Bundled example** `Benchmark\Examples\UserRoleFilterExampleBenchmark` — counts users in a role
  two ways (PHP `loadMultiple()` + filter vs SQL `COUNT`); auto-selects a populated non-built-in
  role or skips. Depends only on `@entity_type.manager`.
- **CSS library** `code_benchmarker/dashboard` (`css/code-benchmarker.css`). No JS. No permissions
  file, no config schema, no install/update hooks, no Drush commands.

## Solution docs

- **Routes, controller, dashboard UI, `?iter` handling, templates** → [dashboard.md](dashboard.md)
- **Writing a scenario: the interface, tagged service, runner methodology, DTOs, bundled example** →
  [extending.md](extending.md)
