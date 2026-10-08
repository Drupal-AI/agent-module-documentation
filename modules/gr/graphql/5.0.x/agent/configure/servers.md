<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure: the `graphql_server` config entity + endpoints

Everything you run is a **`graphql_server`** config entity (class
`Drupal\graphql\Entity\Server`, `config_prefix: graphql_servers`, id key = `name`). One entity =
one schema bound to one HTTP endpoint.

## Config keys (all exported)

| Key | Type | Meaning |
|---|---|---|
| `name` | string | machine id (the entity id) |
| `label` | string | human label |
| `schema` | string | **Schema plugin id** this server runs (e.g. `composable_example`) |
| `schema_configuration` | mapping | per-schema config; typed as `graphql.schema.[%parent.schema]` (e.g. composable schemas store `composable.extensions` here) |
| `endpoint` | string | URL path, e.g. `/graphql` — the route is built from this |
| `caching` | bool | cache responses (default TRUE) |
| `batching` | bool | allow query batching (default TRUE) |
| `disable_introspection` | bool | turn off schema introspection (default FALSE) |
| `query_depth` | int | max query depth, 0 = unlimited |
| `query_complexity` | int | max query complexity, 0 = unlimited |
| `debug_flag` | int | `GraphQL\Error\DebugFlag` bitmask |
| `persisted_queries_settings` | sequence | per-plugin persisted-query config |

## The endpoint route

`Drupal\graphql\RouteProvider::routes()` loads every server and registers a route
**`graphql.query.<name>`** at the entity's `endpoint`, with controller
`Drupal\graphql\Controller\RequestController::handleRequest`, access check
`_graphql_query_access: graphql_server:{graphql_server}`, and `_format: json`. Saving or deleting
a server calls `router.builder`→`setRebuildNeeded()`, so **run `drush cr`** (or rebuild routes)
for the endpoint to appear. Introspection Explorer/Voyager/Validate live under
`/admin/config/graphql/servers/manage/<name>/{explorer,voyager,validate}`.

## Create a server with drush (php:eval)

```php
$s = \Drupal\graphql\Entity\Server::create([
  'name' => 'main',
  'label' => 'Main',
  'schema' => 'composable_example',      // any @Schema plugin id
  'endpoint' => '/graphql',
  'caching' => TRUE,
  'batching' => TRUE,
  'disable_introspection' => FALSE,
  'query_depth' => 0,
  'query_complexity' => 0,
]);
$s->save();
```

Then `drush cr`. The endpoint is now live at `/graphql` (route `graphql.query.main`).

## As exportable YAML config

File `graphql.graphql_servers.main.yml`:

```yaml
name: main
label: Main
schema: composable_example
schema_configuration:
  composable:
    extensions:
      composable_extension: composable_extension
endpoint: /graphql
caching: true
batching: true
disable_introspection: false
query_depth: 0
query_complexity: 0
```

Import with `drush config:import` (or `drush config:set`). Admin UI: **Administer configuration**
permission, collection route `entity.graphql_server.collection` at `/admin/config/graphql`.

## Permissions
- `administer graphql configuration` — create/edit/delete servers (also admin_permission of the entity).
- `bypass graphql access` — use any server regardless of per-server access restrictions.
