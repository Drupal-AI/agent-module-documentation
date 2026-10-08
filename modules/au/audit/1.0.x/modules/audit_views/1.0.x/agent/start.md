<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit: Views (audit_views) — agent index

Submodule of the **Audit** framework. Ships one `audit_analyzer` plugin and no routes, services, permissions or Drush commands of its own — it plugs into the parent `audit` module's runner, settings form and report UI.

- **The analyzer, its checks, config and how it runs** → [plugins/views.md](plugins/views.md)

## What it actually is

- One plugin: **`ViewsAnalyzer`** (id **`views`**, output dir `views`, default weight `3`), in
  `src/Plugin/AuditAnalyzer/ViewsAnalyzer.php`, extending `Drupal\audit\AuditAnalyzerBase` and declared with the
  `#[AuditAnalyzer(...)]` attribute. Label *"Views"*.
- **Depends on**: `audit`, `views`. External tooling: Requires core Views module.
- Uses the shared settings route **`audit.settings`** (`configure`).
- **Config** (`audit_views.settings`, schema yes): `relationships_threshold`, `detect_searchapi_mysql`, `cache_excluded_views`, `exclude_disabled_views`.

## Checks (`getAuditChecks()`)

  - `cache_issues` — Cache Issues (scored)
  - `relationship_issues` — Relationship Issues (scored)
  - `cache_tag_issues` — Generic Cache Tags (scored)
  - `anonymous_access_issues` — Anonymous Access (scored)
  - `displays_status` — View Displays Overview (informational)
  - `searchapi_issues` — Search API Rendering Issues (scored)
  - `searchapi_cache_issues` — Search API Cache Issues (scored)
  - `searchapi_cache_status` — Search API Cache Overview (informational)

## How it runs

- Executed by the parent `audit.runner` service when an admin opens `/admin/reports/audit/views`
  (permission **`view audit results`**), on cron via the `audit_processor` queue, or headless via
  `drush audit:run views`. `analyze()` returns a `_files` + `score` structure; only the score is
  persisted (State API). Results render through the parent's escaped `audit_*` theme components.
- See [plugins/views.md](plugins/views.md) for the full check list, config keys and operation notes.
