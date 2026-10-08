<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, controller and export service (API)

The module exports the **schema of a GraphQL server** (its SDL type definitions and its introspection
JSON) — it never exports node/entity **content**. All work goes through one service and three routes.

## Service — `graphql_export.service`

`Drupal\graphql_export\GraphqlExportService` (args: `@messenger`, `@graphql.introspection`,
`@plugin.manager.graphql.schema`). Two public methods, both take a
`\Drupal\graphql\Entity\ServerInterface`:

```php
$svc = \Drupal::service('graphql_export.service');
$sdl  = $svc->printSchema($server);  // string — SDL, via GraphQL\Utils\SchemaPrinter::doPrint()
$json = $svc->printJson($server);    // ?string — pretty introspection JSON
```

- `printSchema($server)` — resolves the server's schema plugin (`$server->get('schema')` →
  `plugin.manager.graphql.schema->createInstance()`, applying `schema_configuration` if the plugin is
  `ConfigurableInterface`), builds the schema with its resolver registry, and returns the printed SDL.
  (`GraphqlExportService.php:70`)
- `printJson($server)` — if the server is a `Drupal\graphql\Entity\Server`, it **temporarily** (in
  memory, no `->save()`) sets `setQueryDepth(0)`, `setQueryComplexity(0)` and
  `setDisableIntrospection(FALSE)`, then calls `@graphql.introspection->introspect($server)` and
  `json_encode(... JSON_PRETTY_PRINT | JSON_HEX_TAG | JSON_HEX_APOS | JSON_HEX_AMP | JSON_HEX_QUOT)`.
  The server config on disk is unchanged. (`GraphqlExportService.php:88`)

No value from the request is passed into the schema plugin or introspection — the only input is the
`{graphql_server}` config entity resolved by the route param converter, so there is no query/param
injection surface here.

## Routes (all in `graphql_export.routing.yml`)

Controller: `Drupal\graphql_export\Controller\ExportController` (args: `@messenger`,
`@graphql_export.service`). Every route is `_admin_route: TRUE` and takes the server via a
`{graphql_server}` slug with `with_config_overrides: TRUE`.

| Route name | Path (under `/admin/config/graphql/servers/manage/{graphql_server}`) | Method | Returns |
|---|---|---|---|
| `graphql_export.export` | `/export` | `viewExporter()` | render array: read-only `<textarea>` of the SDL + two download links + an info message if the server is in `$settings['graphql_export']` |
| `graphql_export.export_download_graphqls` | `/export/graphqls` | `downloadGraphqls()` | `Response` — `application/octet-stream`, `attachment; filename="schema.graphqls"` (SDL) |
| `graphql_export.export_download_json` | `/export/json` | `downloadJson()` | `Response` — `application/octet-stream`, `attachment; filename="schema.json"` (introspection JSON) |

A local task tab (`graphql_export.links.task.yml`) adds an **Export** tab on the server edit form
(`base_route: entity.graphql_server.edit_form`). The view route attaches the `graphql_export/export`
CSS library.

## Access model (inherited, not redefined)

Every route requirement is `_graphql_explorer_access: graphql_server:{graphql_server}` — the check
provided by the **graphql** module (`Drupal\graphql\Access\ExplorerAccessCheck`). It grants access
only when the account has `bypass graphql access`, **or** holds **both** `use <id> graphql explorer`
**and** `execute <id> arbitrary graphql requests` for that server id. These are administrative
graphql permissions; the export routes are therefore not reachable anonymously and expose no data
that the same account could not already obtain from the GraphQL explorer for that server. This module
declares **no permissions of its own** (no `*.permissions.yml`).
