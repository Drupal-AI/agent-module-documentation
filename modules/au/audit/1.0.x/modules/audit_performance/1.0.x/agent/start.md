<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit: Performance (audit_performance) — agent index

Submodule of the **Audit** framework. Ships one `audit_analyzer` plugin and no routes, services, permissions or Drush commands of its own — it plugs into the parent `audit` module's runner, settings form and report UI.

- **The analyzer, its checks, config and how it runs** → [plugins/performance.md](plugins/performance.md)

## What it actually is

- One plugin: **`PerformanceAnalyzer`** (id **`performance`**, output dir `performance`, default weight `4`), in
  `src/Plugin/AuditAnalyzer/PerformanceAnalyzer.php`, extending `Drupal\audit\AuditAnalyzerBase` and declared with the
  `#[AuditAnalyzer(...)]` attribute. Label *"Performance"*.
- **Depends on**: `audit`, `audit_modules`. External tooling: none.
- Uses the shared settings route **`audit.settings`** (`configure`).
- **Config** (`audit_performance.settings`, schema yes): `recommended_cache_max_age`, `ignore_bigpipe_sessionless`.

## Checks (`getAuditChecks()`)

  - `production_issues` — Production Settings Issues (scored)
  - `configuration_issues` — System Configuration Issues (scored)
  - `cache_modules_issues` — Cache Modules Issues (scored)
  - `code_issues` — Code Analysis Issues (scored)
  - `performance_patterns` — Performance Anti-Patterns (scored)
  - `production_status` — Production Settings Status (informational)
  - `configuration_status` — System Configuration Status (informational)
  - `cache_modules_status` — Cache Modules Status (informational)

## How it runs

- Executed by the parent `audit.runner` service when an admin opens `/admin/reports/audit/performance`
  (permission **`view audit results`**), on cron via the `audit_processor` queue, or headless via
  `drush audit:run performance`. `analyze()` returns a `_files` + `score` structure; only the score is
  persisted (State API). Results render through the parent's escaped `audit_*` theme components.
- See [plugins/performance.md](plugins/performance.md) for the full check list, config keys and operation notes.
