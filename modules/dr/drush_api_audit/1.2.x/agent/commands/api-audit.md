<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands: api:route and api:audit:permission

All from `src/Commands/ApiCommands.php` (`Drupal\drush_api_audit\Commands\ApiCommands`, extends
`Drush\Commands\DrushCommands`). Registered in `drush.services.yml` as `drush_api_audit.commands`
(tag `drush.command`), constructor-injected with `@router.route_provider`
(`RouteProviderInterface`) and `@entity_type.manager` (`EntityTypeManagerInterface`).

## Install / enable

`composer require drupal/drush_api_audit` then `drush en drush_api_audit -y`. Needs **Drush 12 or
13**. No configuration, permissions, or web UI. Verify with `drush api:route --help`.

## What counts as an "API route"

`getAllApiRoutes()` iterates `routeProvider->getAllRoutes()` and keeps a route when:
- it has a `_format` requirement other than `html` (e.g. `json`), OR
- its route name starts with `jsonapi.`, OR
- its route name starts with `rest.`.

## `api:route` (alias `apir`) — method `route()`

Lists or inspects API routes.

- `--name=NAME` — a route name to look up.
- `--path=PATH` — an internal path or full URL. A URL is reduced with `parse_url(...PHP_URL_PATH)`
  and the base path is stripped, then resolved via `Url::fromUserInput($path)->getRouteName()`.
- `--format=FORMAT` — default `yaml`.

Behavior: with `--name`/`--path` it resolves the route and, **only if** that route has a `_format`
requirement that is set and not `html`, returns `name, path, defaults, requirements, options,
methods` (dropping `options.compiler_class` and `options.utf8`). With no name/path it returns a map
of every API route name to its path. (Note: a resolved route without a non-HTML `_format` yields no
output.)

## `api:audit:permission` (alias `api-perm`) — method `auditPermission()`

Audits access control on every API route and returns a
`Consolidation\OutputFormatters\StructuredData\RowsOfFields`. Default fields:
`name,path,methods,severity,reason` (also available: `requirements`, a YAML dump). Prints
`No open access API route found.` when nothing is flagged. Rows are sorted critical → warning → info.

Options:
- `--severity=LEVEL` — minimum severity to show: `info` | `warning` | `critical`
  (`meetsSeverityThreshold()`).
- `--exclude-jsonapi` — drop `jsonapi.*` routes.
- `--exclude-routes=LIST` — comma-separated names; `*` and `?` wildcards (`isRouteExcluded()` builds
  a regex, e.g. `system.*`).
- `--methods=LIST` — keep only routes whose methods intersect the list (comma-separated, e.g.
  `POST,DELETE`); routes with `ANY` always pass.
- `--format=FORMAT` — default `table`; use `json` for scripting/CI.

### How a route is flagged (`analyzeRoute()`)

Each route's `requirements` are checked; findings accumulate a `reasons[]` list and a `severity`.
`hasWriteMethods()` is true when methods include POST/PUT/PATCH/DELETE.

- `_access: 'TRUE'` — unconditional. Non-JSON:API: warning, or **critical** if write. JSON:API
  content entity: warning. JSON:API **config** entity: info (relies on entity access).
- `_permission: X` where X is in the anonymous role's granted permissions
  (`getAnonymousPermissions()` loads the `anonymous` `user_role`; `+` in the requirement = OR) —
  warning, or **critical** if write.
- `_role: 'anonymous'` — warning, or **critical** if write.
- `_user_is_logged_in: 'FALSE'` — warning, or **critical** if write.
- `_custom_access` — added as "needs review" (does not raise severity).
- None of the known access keys present (`_access`, `_permission`, `_role`, `_user_is_logged_in`,
  `_custom_access`, `_entity_access`, `_entity_create_access`, `_entity_create_any_access`,
  `_jsonapi_relationship_route_access`) — "No access requirement defined": warning, or **critical**
  if write.
- Finally, a write route still at `info` is bumped to `warning`.

### Route context (`getRouteContext()`)

Detects `is_jsonapi` / `is_rest` by name prefix; for JSON:API it parses the entity type from
`jsonapi.{entity_type}--{bundle}` and marks `is_config_entity` when the type is a
`ConfigEntityTypeInterface`. `isJsonApiResourceDisabled()` checks the `jsonapi_resource_config`
entity (from **jsonapi_extras**, only if that entity type exists) and such disabled resources are
skipped entirely before analysis.

## Operational notes

- Read-only: uses only the route provider and entity type manager; prints to stdout via Drush
  formatters. No config is written, no files are created, no external requests are made.
- Anonymous-permission cross-referencing is site-specific — results reflect the **current** site's
  `anonymous` role, so run it against the environment you care about.
- Combine `--methods=POST,PATCH,DELETE --severity=critical --format=json` for a CI gate on
  unauthenticated write endpoints.
