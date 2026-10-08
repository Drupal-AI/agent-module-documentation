<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit: Updates (audit_updates) — agent index

Submodule of the **Audit** framework. Ships one `audit_analyzer` plugin and no routes, services, permissions or Drush commands of its own — it plugs into the parent `audit` module's runner, settings form and report UI.

- **The analyzer, its checks, config and how it runs** → [plugins/updates.md](plugins/updates.md)

## What it actually is

- One plugin: **`UpdatesAnalyzer`** (id **`updates`**, output dir `updates`, default weight `5`), in
  `src/Plugin/AuditAnalyzer/UpdatesAnalyzer.php`, extending `Drupal\audit\AuditAnalyzerBase` and declared with the
  `#[AuditAnalyzer(...)]` attribute. Label *"Audit Updates"*.
- **Depends on**: `audit`, `update`. External tooling: Requires core Update Status (update) module.
- No `configure` route of its own.
- **Config** (`audit_updates.settings`, schema yes): `ignore_regular_updates`.

## Checks (`getAuditChecks()`)

  - `update_health` — Update System Health (scored)
  - `security` — Security Updates (scored)
  - `regular` — Regular Updates (scored)
  - `compatibility` — Next Version Compatibility (informational)

## How it runs

- Executed by the parent `audit.runner` service when an admin opens `/admin/reports/audit/updates`
  (permission **`view audit results`**), on cron via the `audit_processor` queue, or headless via
  `drush audit:run updates`. `analyze()` returns a `_files` + `score` structure; only the score is
  persisted (State API). Results render through the parent's escaped `audit_*` theme components.
- See [plugins/updates.md](plugins/updates.md) for the full check list, config keys and operation notes.
