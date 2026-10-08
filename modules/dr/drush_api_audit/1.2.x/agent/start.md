<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Audit Drush Command (drush_api_audit) — agent index

Two **Drush commands** that inventory a site's headless/decoupled **API routes** and audit them for
open access and access-control misconfigurations. Version **1.2.x**. Core `^11`. Package `drush`.
License GPL-2.0-or-later. Requires **Drush 12 or 13** (`require-dev` only; no runtime Composer or
module dependencies). No routes, forms, permissions, config, or plugins — CLI only.

- **Both commands (`api:route`, `api:audit:permission`), options, what is scanned and how severity is decided** →
  [commands/api-audit.md](commands/api-audit.md)

## What it actually is

- One Drush command class: `ApiCommands` (id **`drush_api_audit.commands`**, tag `drush.command`) in
  `src/Commands/ApiCommands.php`, extending `Drush\Commands\DrushCommands`. Registered via
  `drush.services.yml`, injected with `@router.route_provider` and `@entity_type.manager`.
- **`api:route`** (alias `apir`) — lists all API routes (`name => path`), or dumps one route's full
  definition given `--name` or `--path`; `--format` (default `yaml`).
- **`api:audit:permission`** (alias `api-perm`) — audits access on all API routes and returns a
  `RowsOfFields` table (name, path, methods, severity, reason); options `--severity`,
  `--exclude-jsonapi`, `--exclude-routes` (comma list, `*`/`?` wildcards), `--methods`, `--format`
  (default `table`).

## Mechanism (from source)

- `getAllApiRoutes()` selects a route as "API" if it has a non-HTML `_format` requirement, or its
  name starts with `jsonapi.` or `rest.`.
- `analyzeRoute()` flags: `_access: 'TRUE'`, a `_permission` in the anonymous role's granted
  permissions (`getAnonymousPermissions()`, `+` = OR), `_role: 'anonymous'`,
  `_user_is_logged_in: 'FALSE'`, `_custom_access` (review), and routes with none of the known access
  keys. Severity `info`/`warning`/`critical`, escalated when methods include POST/PUT/PATCH/DELETE
  (`hasWriteMethods()`), de-escalated for JSON:API **config-entity** routes.
- JSON:API resources disabled via **jsonapi_extras** (`jsonapi_resource_config`) are auto-excluded.

Read-only: reads route/entity/role definitions and prints to stdout. No web surface, no config
writes, no external HTTP.
