<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit: SEO (audit_seo) — agent index

Submodule of the **Audit** framework. Ships one `audit_analyzer` plugin and no routes, services, permissions or Drush commands of its own — it plugs into the parent `audit` module's runner, settings form and report UI.

- **The analyzer, its checks, config and how it runs** → [plugins/seo.md](plugins/seo.md)

## What it actually is

- One plugin: **`SeoAnalyzer`** (id **`seo`**, output dir `seo`, default weight `3`), in
  `src/Plugin/AuditAnalyzer/SeoAnalyzer.php`, extending `Drupal\audit\AuditAnalyzerBase` and declared with the
  `#[AuditAnalyzer(...)]` attribute. Label *"SEO"*.
- **Depends on**: `audit`. External tooling: none.
- No `configure` route of its own.
- **Config** (`audit_seo.settings`, schema yes): `ignore_simple_sitemap`, `ignore_robots_sitemap`, `ignore_metatag`, `ignore_pathauto`, `ignore_pathauto_node`, `ignore_pathauto_taxonomy_term`, `ignore_pathauto_user`, `ignore_pathauto_media`.

## Checks (`getAuditChecks()`)

  - `essential_modules_issues` — Essential SEO Modules (scored)
  - `url_structure_issues` — URL Pattern Issues (scored)
  - `media_seo_issues` — Image Field Issues (scored)
  - `robots_txt_issues` — Robots.txt Issues (scored)
  - `modules_status` — SEO Modules Status (informational)
  - `url_structure_status` — URL Patterns Overview (informational)
  - `media_seo_status` — Image Fields Overview (informational)
  - `robots_txt_status` — Robots.txt Analysis (informational)

## How it runs

- Executed by the parent `audit.runner` service when an admin opens `/admin/reports/audit/seo`
  (permission **`view audit results`**), on cron via the `audit_processor` queue, or headless via
  `drush audit:run seo`. `analyze()` returns a `_files` + `score` structure; only the score is
  persisted (State API). Results render through the parent's escaped `audit_*` theme components.
- See [plugins/seo.md](plugins/seo.md) for the full check list, config keys and operation notes.
