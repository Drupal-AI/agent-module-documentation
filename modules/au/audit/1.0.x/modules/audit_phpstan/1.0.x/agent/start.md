<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit: PHPStan (audit_phpstan) — agent index

Submodule of the **Audit** framework. Ships one `audit_analyzer` plugin and no routes, services, permissions or Drush commands of its own — it plugs into the parent `audit` module's runner, settings form and report UI. Marked **experimental / [DEV ONLY]** — not for production.

- **The analyzer, its checks, config and how it runs** → [plugins/phpstan.md](plugins/phpstan.md)

## What it actually is

- One plugin: **`PhpstanAnalyzer`** (id **`phpstan`**, output dir `phpstan`, default weight `2`), in
  `src/Plugin/AuditAnalyzer/PhpstanAnalyzer.php`, extending `Drupal\audit\AuditAnalyzerBase` and declared with the
  `#[AuditAnalyzer(...)]` attribute. Label *"PHPStan [DEV ONLY]"*.
- **Depends on**: `audit`. External tooling: phpstan binary (mglaman/phpstan-drupal recommended for Drupal-aware analysis).
- Uses the shared settings route **`audit.settings`** (`configure`).
- **Config** (`audit_phpstan.settings`, schema yes): `level`, `memory_limit`, `max_errors_display`, `skip_deprecations`, `skip_phpdoc_types`, `skip_entity_mapping`, `custom_entity_mapping`, `report_unmatched_ignored_errors`, `ignore_errors`, `active_types`.

## Checks (`getAuditChecks()`)

  - `type_errors` — Type Errors (scored)
  - `deprecation_issues` — Deprecation Warnings (scored)
  - `undefined_issues` — Undefined References (scored)
  - `environment_status` — PHPStan Environment (informational)
  - `project_config` — Project Configuration (informational)

## How it runs

- Executed by the parent `audit.runner` service when an admin opens `/admin/reports/audit/phpstan`
  (permission **`view audit results`**), on cron via the `audit_processor` queue, or headless via
  `drush audit:run phpstan`. `analyze()` returns a `_files` + `score` structure; only the score is
  persisted (State API). Results render through the parent's escaped `audit_*` theme components.
- See [plugins/phpstan.md](plugins/phpstan.md) for the full check list, config keys and operation notes.
