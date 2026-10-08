<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit: PHPUnit (audit_phpunit) — agent index

Submodule of the **Audit** framework. Ships one `audit_analyzer` plugin and no routes, services, permissions or Drush commands of its own — it plugs into the parent `audit` module's runner, settings form and report UI. Marked **experimental / [DEV ONLY]** — not for production.

- **The analyzer, its checks, config and how it runs** → [plugins/phpunit.md](plugins/phpunit.md)

## What it actually is

- One plugin: **`PhpunitAnalyzer`** (id **`phpunit`**, output dir `phpunit`, default weight `2`), in
  `src/Plugin/AuditAnalyzer/PhpunitAnalyzer.php`, extending `Drupal\audit\AuditAnalyzerBase` and declared with the
  `#[AuditAnalyzer(...)]` attribute. Label *"PHPUnit [DEV ONLY]"*.
- **Depends on**: `audit`. External tooling: phpunit binary; PCOV or Xdebug for coverage (optional).
- Uses the shared settings route **`audit.settings`** (`configure`).
- **Config** (`audit_phpunit.settings`, schema yes): `phpunit_config`, `enable_coverage`, `timeout`, `coverage_warning_threshold`, `coverage_error_threshold`, `max_failures_display`, `exclude_modules`.

## Checks (`getAuditChecks()`)

  - `test_health` — Test Coverage (scored)
  - `test_structure` — Test Structure (informational)

## How it runs

- Executed by the parent `audit.runner` service when an admin opens `/admin/reports/audit/phpunit`
  (permission **`view audit results`**), on cron via the `audit_processor` queue, or headless via
  `drush audit:run phpunit`. `analyze()` returns a `_files` + `score` structure; only the score is
  persisted (State API). Results render through the parent's escaped `audit_*` theme components.
- See [plugins/phpunit.md](plugins/phpunit.md) for the full check list, config keys and operation notes.
