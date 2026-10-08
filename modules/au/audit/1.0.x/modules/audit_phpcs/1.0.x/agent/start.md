<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit: PHP CodeSniffer (audit_phpcs) — agent index

Submodule of the **Audit** framework. Ships one `audit_analyzer` plugin and no routes, services, permissions or Drush commands of its own — it plugs into the parent `audit` module's runner, settings form and report UI. Marked **experimental / [DEV ONLY]** — not for production.

- **The analyzer, its checks, config and how it runs** → [plugins/phpcs.md](plugins/phpcs.md)

## What it actually is

- One plugin: **`PhpcsAnalyzer`** (id **`phpcs`**, output dir `phpcs`, default weight `2`), in
  `src/Plugin/AuditAnalyzer/PhpcsAnalyzer.php`, extending `Drupal\audit\AuditAnalyzerBase` and declared with the
  `#[AuditAnalyzer(...)]` attribute. Label *"PHP CodeSniffer [DEV ONLY]"*.
- **Depends on**: `audit`. External tooling: phpcs (drupal/coder: Drupal + DrupalPractice standards); phpcbf optional for auto-fix.
- No `configure` route of its own.
- **Config** (`audit_phpcs.settings`, schema yes): `extensions`, `min_severity`, `ignore_warnings`, `excluded_sniffs`, `parallel`, `use_cache`, `max_violations_display`, `report_width`, `show_sniff_codes`, `group_by_file`, `phpcs_binary_path`, `phpcbf_binary_path`.

## Checks (`getAuditChecks()`)

  - `coding_standards` — Coding Standards (scored)
  - `analysis_summary` — Analysis Summary (informational)
  - `project_config` — Project Configuration (informational)

## How it runs

- Executed by the parent `audit.runner` service when an admin opens `/admin/reports/audit/phpcs`
  (permission **`view audit results`**), on cron via the `audit_processor` queue, or headless via
  `drush audit:run phpcs`. `analyze()` returns a `_files` + `score` structure; only the score is
  persisted (State API). Results render through the parent's escaped `audit_*` theme components.
- See [plugins/phpcs.md](plugins/phpcs.md) for the full check list, config keys and operation notes.
