<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DB Performance (db_performance) — agent index

Passive **slow-query monitor + index advisor** for Drupal 10/11. A kernel `TERMINATE`
subscriber logs each request's SELECT queries via the core DB logger, keeps the slow ones,
normalizes them into SHA-256 fingerprints, and aggregates per-fingerprint stats into the
`db_performance_query` table. An admin report ranks the slowest queries, runs `EXPLAIN` to
detect table scans, and suggests / exports / creates `CREATE INDEX` statements. Package
`Performance`. **No dependencies** beyond core; no external libraries. Works on MySQL/MariaDB
and PostgreSQL. Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.0-alpha2.

## Solution docs

- **Collection pipeline, the five services, the schema table, programmatic use** →
  [api/services.md](api/services.md)
- **Report route, EXPLAIN/index suggestion, export, create-index confirm form, permissions** →
  [reports/slow-query-report.md](reports/slow-query-report.md)
- **Settings config object, the settings form, config keys/schema** →
  [config/settings.md](config/settings.md)

## What it actually is (from source)

- **No entities, no plugins, no Drush.** Provides one DB table (`hook_schema` in
  `db_performance.install`), one theme hook (`db_performance_report`, template
  `templates/db-performance-report.html.twig`), config schema, 2 permissions, 2 menu links.
- **Services** (`db_performance.services.yml`):
  - `db_performance.query_collector` — `EventSubscriber\QueryCollectorSubscriber`
    (`@db_performance.query_normalizer`, `@database`, `@config.factory`; tagged `event_subscriber`).
  - `db_performance.query_normalizer` — `Service\QueryNormalizer` (fingerprinting; no deps).
  - `db_performance.query_analyzer` — `Service\QueryAnalyzer` (`@database`; driver-aware EXPLAIN).
  - `db_performance.index_suggestion` — `Service\IndexSuggestionService`
    (`@db_performance.query_analyzer`, `@db_performance.query_normalizer`).
  - `db_performance.index_manager` — `Service\IndexManager` (`@database`; DDL exec + export).
- **Routes** (`db_performance.routing.yml`):
  - `db_performance.report` — `GET /admin/reports/db-performance`
    → `Controller\ReportController::report`; perm **access db performance reports**.
  - `db_performance.settings` — `/admin/config/development/db-performance`
    → `Form\SettingsForm`; perm **administer site configuration**.
  - `db_performance.create_index` — `/admin/reports/db-performance/create/{id}` (`id: \d+`)
    → `Form\CreateIndexForm`; perm **manage db performance indexes**.
  - `db_performance.export` — `/admin/reports/db-performance/export`
    → `ReportController::export`; perm **manage db performance indexes**.
- **Permissions** (`db_performance.permissions.yml`): `access db performance reports`,
  `manage db performance indexes` (both `restrict access: FALSE`).
- **Config**: object `db_performance.settings` (`config/install` + `config/schema`) — keys
  `slow_query_threshold`, `max_stored_queries`, `enable_index_suggestions`,
  `allow_index_creation`, `ignore_tables`.

## Operate it

1. `drush en db_performance` (installs the `db_performance_query` table).
2. Generate real traffic — collection is passive and only stores queries at/over the threshold.
3. Review `/admin/reports/db-performance`; tune at `/admin/config/development/db-performance`.
4. Export `indexes.sql`, or (only if *allow index creation from UI* is on) create indexes via
   the confirm form. Always review suggested DDL before applying.
