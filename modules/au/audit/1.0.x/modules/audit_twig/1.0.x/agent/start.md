<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit: Twig (audit_twig) — agent index

Submodule of the **Audit** framework. Ships one `audit_analyzer` plugin and no routes, services, permissions or Drush commands of its own — it plugs into the parent `audit` module's runner, settings form and report UI.

- **The analyzer, its checks, config and how it runs** → [plugins/twig.md](plugins/twig.md)

## What it actually is

- One plugin: **`TwigAnalyzer`** (id **`twig`**, output dir `twig`, default weight `2`), in
  `src/Plugin/AuditAnalyzer/TwigAnalyzer.php`, extending `Drupal\audit\AuditAnalyzerBase` and declared with the
  `#[AuditAnalyzer(...)]` attribute. Label *"Twig"*.
- **Depends on**: `audit`. External tooling: none.
- Uses the shared settings route **`audit.settings`** (`configure`).
- **Config** (`audit_twig.settings`, schema yes): `ignore_cache_analysis`, `ignore_anti_patterns`, `ignore_field_sync`, `ignore_theme_suggestions`, `ignore_preprocess_analysis`, `ignore_external_libraries`.

## Checks (`getAuditChecks()`)

  - `cache_bubbling` — Cache Bubbling (scored)
  - `anti_patterns` — Twig Anti-Patterns (scored)
  - `field_sync` — Field Rendering Optimization (scored)
  - `theme_suggestions` — Theme Suggestions (informational)
  - `preprocess_antipatterns` — Preprocess Anti-Patterns (informational)
  - `external_libraries` — External Libraries (scored)

## How it runs

- Executed by the parent `audit.runner` service when an admin opens `/admin/reports/audit/twig`
  (permission **`view audit results`**), on cron via the `audit_processor` queue, or headless via
  `drush audit:run twig`. `analyze()` returns a `_files` + `score` structure; only the score is
  persisted (State API). Results render through the parent's escaped `audit_*` theme components.
- See [plugins/twig.md](plugins/twig.md) for the full check list, config keys and operation notes.
