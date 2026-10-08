<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Fast Revision Purge (fast_revision_purge) — agent index

Database-maintenance module that **plans** (dry-run) and then **purges** old node, paragraph, and Layout
Builder revisions in resumable chunks to reclaim space. Package `Administration`. License GPL-2.0-or-later.
Version 1.0.4. Core `^10 || ^11`. Single hard dependency: core `node`. Paragraphs and Layout Builder support
is optional (activated only when those modules are enabled).

## Flow (two steps)

1. **Plan (dry run)** — `Planner::plan()` fills working tables `fastrev_node_keep` / `fastrev_node_delete`,
   `fastrev_par_in_use` / `fastrev_par_delete`, and (if present) `fastrev_lb_keep` / `fastrev_lb_delete`, then
   estimates reclaimable bytes into `fastrev_stats`. No rows are deleted.
2. **Purge** — `Purger::purge($chunk, $sleepMs)` deletes staged revisions in chunks (field-revision tables
   before core tables; paragraphs before nodes) and records totals + estimated bytes freed.

## What it provides (from source)

- **Config**: config object `fast_revision_purge.settings` (schema in `config/schema`), settings form
  `Form\SettingsForm` at route `fast_revision_purge.settings` → `/admin/config/development/fast-revision-purge`,
  permission `administer site configuration`, menu link under `system.admin_config_development`.
  → [config/settings.md](config/settings.md)
- **Services** (`fast_revision_purge.services.yml`): `planner`, `purger`, `table_map` (RevisionTableMap),
  `index_manager` (IndexManager), `db_platform` (DbPlatform), `table_stats` (TableStats), `stats`
  (StatsStorage), `lb_truncator` (LayoutBuilderRevisionTruncator), `paragraph_truncator`
  (ParagraphRevisionTruncator), plus logger channel. → [api/services.md](api/services.md)
- **Batch classes**: `Batch\PlanBatch` (dry run) and `Batch\PurgeBatch` (chunked purge), wired by the form.
  → [config/settings.md](config/settings.md)
- **Drush commands** (`drush.services.yml`, `Commands\FastRevCommands`): `fastrev:report` (`fr:report`),
  `fastrev:purge` (`fr:purge`), `fastrev:reindex` (`fr:reindex`). → [drush/commands.md](drush/commands.md)
- **Schema/install** (`fast_revision_purge.install`): creates working tables + the singleton `fastrev_stats`
  row (id=1). → [api/services.md](api/services.md)

## What it does NOT provide

No entities, no plugin types, no permissions of its own (reuses core `administer site configuration`), no
routes other than the settings form, no controllers, no REST/webhooks, no external HTTP, no credentials.

## Install / operate

1. `composer require drupal/fast_revision_purge` then `drush en fast_revision_purge -y` (creates
   `fastrev_stats` + working tables).
2. Configure policy at `/admin/config/development/fast-revision-purge` (or pass Drush options).
3. Run **Plan (Dry run)** and review KEEP/DELETE counts. Take a DB backup.
4. Check the Danger-zone confirmation and run **Run purge now** (or `drush fastrev:purge`). Optionally run the
   post-purge `OPTIMIZE TABLE` SQL to reclaim disk space.
