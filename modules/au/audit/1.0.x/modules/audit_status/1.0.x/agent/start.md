<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit: Status (audit_status) — agent index

Submodule of the **Audit** framework. Ships one `audit_analyzer` plugin and no routes, services, permissions or Drush commands of its own — it plugs into the parent `audit` module's runner, settings form and report UI.

- **The analyzer, its checks, config and how it runs** → [plugins/status.md](plugins/status.md)

## What it actually is

- One plugin: **`StatusAnalyzer`** (id **`status`**, output dir `status`, default weight `4`), in
  `src/Plugin/AuditAnalyzer/StatusAnalyzer.php`, extending `Drupal\audit\AuditAnalyzerBase` and declared with the
  `#[AuditAnalyzer(...)]` attribute. Label *"Status"*.
- **Depends on**: `audit`. External tooling: none.
- No `configure` route of its own.
- **Config**: none (no `config/install`; schema no).

## Checks (`getAuditChecks()`)

  - `system_info` — System Information (informational)
  - `php_version` — PHP Version (scored)
  - `php_config` — PHP Configuration (scored)
  - `database_version` — Database Version (scored)
  - `database_config` — Database Configuration (scored)
  - `requirements` — System Requirements (scored)

## How it runs

- Executed by the parent `audit.runner` service when an admin opens `/admin/reports/audit/status`
  (permission **`view audit results`**), on cron via the `audit_processor` queue, or headless via
  `drush audit:run status`. `analyze()` returns a `_files` + `score` structure; only the score is
  persisted (State API). Results render through the parent's escaped `audit_*` theme components.
- See [plugins/status.md](plugins/status.md) for the full check list, config keys and operation notes.
