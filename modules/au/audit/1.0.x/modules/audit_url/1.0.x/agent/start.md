<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit: URL (audit_url) — agent index

Submodule of the **Audit** framework. Ships one `audit_analyzer` plugin and no routes, services, permissions or Drush commands of its own — it plugs into the parent `audit` module's runner, settings form and report UI.

- **The analyzer, its checks, config and how it runs** → [plugins/url.md](plugins/url.md)

## What it actually is

- One plugin: **`UrlAnalyzer`** (id **`url`**, output dir `url`, default weight `3`), in
  `src/Plugin/AuditAnalyzer/UrlAnalyzer.php`, extending `Drupal\audit\AuditAnalyzerBase` and declared with the
  `#[AuditAnalyzer(...)]` attribute. Label *"URL"*.
- **Depends on**: `audit`. External tooling: Uses path_alias and/or redirect when present (at least one recommended).
- No `configure` route of its own.
- **Config**: none (no `config/install`; schema no).

## Checks (`getAuditChecks()`)

  - `overview` — Overview (informational)

## How it runs

- Executed by the parent `audit.runner` service when an admin opens `/admin/reports/audit/url`
  (permission **`view audit results`**), on cron via the `audit_processor` queue, or headless via
  `drush audit:run url`. `analyze()` returns a `_files` + `score` structure; only the score is
  persisted (State API). Results render through the parent's escaped `audit_*` theme components.
- See [plugins/url.md](plugins/url.md) for the full check list, config keys and operation notes.
