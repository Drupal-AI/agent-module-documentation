<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GraphQL Export (graphql_export) — agent index

Exports a **GraphQL server's schema** — as SDL or as JSON introspection — from an admin UI, a Drush
command, or automatically on `drush config:export`. It exports schema *metadata*, never entity/node
content. The work is one service (`GraphqlExportService::printSchema` / `printJson`) reached three
ways: three admin routes under `/admin/config/graphql/servers/manage/{graphql_server}/export`, the
`graphql-export:schema` Drush command, and a `@hook post-command config:export` that writes the
schema to files whenever config is exported (so the schema travels with config in version control).

Version **2.0.6**. Core `^10.2 || ^11`, **PHP 8.1**. Depends on `graphql:graphql`.

- Depends on: `graphql:graphql`. Package: `GraphQL`.
- **No settings page / `configure` route**, no exported config, **no config schema**. Non-UI
  behaviour is driven by `$settings['graphql_export']` in `settings.php`.
- **No permissions of its own** — routes reuse GraphQL's `_graphql_explorer_access` check.
- Provides Drush commands. No plugin types, no submodules.

## What you'd do → where

- **Understand the routes, controller, service methods and the access model** →
  [api/export.md](api/export.md)
- **Configure `settings.php` file paths / use the Drush command / auto-export on config:export** →
  [configure/settings.md](configure/settings.md)

## Key facts (real machine names)

- Routes (all `_admin_route`, requirement `_graphql_explorer_access: graphql_server:{graphql_server}`):
  `graphql_export.export` (`…/export`), `graphql_export.export_download_graphqls` (`…/export/graphqls`),
  `graphql_export.export_download_json` (`…/export/json`). Controller
  `Drupal\graphql_export\Controller\ExportController` (`viewExporter`, `downloadGraphqls`, `downloadJson`).
- Service: `graphql_export.service` (`Drupal\graphql_export\GraphqlExportService`) — methods
  `printSchema()` (SDL via `SchemaPrinter::doPrint`), `printJson()` (introspection JSON).
- Drush: service `graphql_export.commands`; command `graphql-export:schema [server_ids] [--type=json|graphqls]`;
  `@hook post-command config:export`. Default output when unset: `private://<id>.graphqls` / `private://<id>.json`.
- Settings (`settings.php`, keyed by server id): `$settings['graphql_export'][<id>]` keys `graphqls`,
  `json`, `skip_config_export`. Read via `Settings::get('graphql_export', [])`.
- Local task tab: `graphql_export.export` (base_route `entity.graphql_server.edit_form`).
- Library: `graphql_export/export` (`css/export.css`). Hook: `hook_help` (dumps README).
- Access check (from graphql): `Drupal\graphql\Access\ExplorerAccessCheck` — needs `bypass graphql access`
  or both `use <id> graphql explorer` + `execute <id> arbitrary graphql requests`.
