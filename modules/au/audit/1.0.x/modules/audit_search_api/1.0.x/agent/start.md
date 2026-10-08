<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit: Search API (audit_search_api) — agent index

Submodule of the **Audit** framework. Ships one `audit_analyzer` plugin and no routes, services, permissions or Drush commands of its own — it plugs into the parent `audit` module's runner, settings form and report UI.

- **The analyzer, its checks, config and how it runs** → [plugins/search_api.md](plugins/search_api.md)

## What it actually is

- One plugin: **`SearchApiAnalyzer`** (id **`search_api`**, output dir `search_api`, default weight `3`), in
  `src/Plugin/AuditAnalyzer/SearchApiAnalyzer.php`, extending `Drupal\audit\AuditAnalyzerBase` and declared with the
  `#[AuditAnalyzer(...)]` attribute. Label *"Search API"*.
- **Depends on**: `audit`, `search_api`. External tooling: Requires the contrib search_api module (hard dependency).
- No `configure` route of its own.
- **Config**: none (no `config/install`; schema no).

## Checks (`getAuditChecks()`)

  - `servers` — Search API Servers (scored)
  - `indexes` — Search API Indexes (scored)

## How it runs

- Executed by the parent `audit.runner` service when an admin opens `/admin/reports/audit/search_api`
  (permission **`view audit results`**), on cron via the `audit_processor` queue, or headless via
  `drush audit:run search_api`. `analyze()` returns a `_files` + `score` structure; only the score is
  persisted (State API). Results render through the parent's escaped `audit_*` theme components.
- See [plugins/search_api.md](plugins/search_api.md) for the full check list, config keys and operation notes.
