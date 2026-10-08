<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit: Watchdog (audit_watchdog) — agent index

Submodule of the **Audit** framework. Ships one `audit_analyzer` plugin and no routes, services, permissions or Drush commands of its own — it plugs into the parent `audit` module's runner, settings form and report UI.

- **The analyzer, its checks, config and how it runs** → [plugins/watchdog.md](plugins/watchdog.md)

## What it actually is

- One plugin: **`WatchdogAnalyzer`** (id **`watchdog`**, output dir `watchdog`, default weight `2`), in
  `src/Plugin/AuditAnalyzer/WatchdogAnalyzer.php`, extending `Drupal\audit\AuditAnalyzerBase` and declared with the
  `#[AuditAnalyzer(...)]` attribute. Label *"Watchdog"*.
- **Depends on**: `audit`, `dblog`. External tooling: Requires core Database Logging (dblog) module.
- No `configure` route of its own.
- **Config**: none (no `config/install`; schema no).

## Checks (`getAuditChecks()`)

  - `bucket_24h` — Last 24 hours (scored)
  - `bucket_7d` — Last week (scored)
  - `bucket_older` — Older entries (scored)
  - `overview` — Overview (informational)

## How it runs

- Executed by the parent `audit.runner` service when an admin opens `/admin/reports/audit/watchdog`
  (permission **`view audit results`**), on cron via the `audit_processor` queue, or headless via
  `drush audit:run watchdog`. `analyze()` returns a `_files` + `score` structure; only the score is
  persisted (State API). Results render through the parent's escaped `audit_*` theme components.
- See [plugins/watchdog.md](plugins/watchdog.md) for the full check list, config keys and operation notes.
