<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API: services & programmatic execution

## Plugin manager services
- `plugin.manager.graphql.schema` — `SchemaPluginManager`; `getInstanceFromServer($server)` builds
  the schema plugin for a given `graphql_server` entity.
- `plugin.manager.graphql.schema_extension` — `SchemaExtensionPluginManager`.
- `plugin.manager.graphql.data_producer` — `DataProducerPluginManager`; `createInstance($id)`.
- `plugin.manager.graphql.persisted_query` — `PersistedQueryPluginManager`.
- `graphql.executor` — the query executor factory plugged into `webonyx/graphql-php`.

## The server entity as entry point
`Drupal\graphql\Entity\Server` (config entity `graphql_server`) is the runtime entry point:

```php
$server = \Drupal::entityTypeManager()->getStorage('graphql_server')->load('main');

// Execute a single operation programmatically:
use GraphQL\Server\OperationParams;
$result = $server->executeOperation(OperationParams::create([
  'query' => '{ article(id: 1) { title } }',
]));
// $result is Drupal\graphql\GraphQL\Execution\ExecutionResult (->data, ->errors, cache metadata).

$server->executeBatch([$op1, $op2]);          // batched operations
$config = $server->configuration();            // GraphQL\Server\ServerConfig (schema, resolvers, rules)
```

Getters/setters for the guard rails: `getDisableIntrospection()/setDisableIntrospection()`,
`getQueryDepth()/setQueryDepth()`, `getQueryComplexity()/setQueryComplexity()`.

## HTTP endpoint
Each server's endpoint is route `graphql.query.<id>` → `RequestController::handleRequest`. It
accepts POST (`application/json` with `query`, `variables`, `operationName`, or a persisted
`queryId`) and GET; enforces `_graphql_query_access` and `_format: json`; enables all auth
providers. Clients: `POST /graphql` with `{"query":"{ ... }"}`.

## Resolver building blocks
- `Drupal\graphql\GraphQL\ResolverBuilder` — fluent resolver construction:
  `produce($dataProducerId)`, `fromValue()`, `fromArgument()`, `fromParent()`, `fromContext()`,
  `compose()`, `map()`, `tap()`, `callback()`.
- `Drupal\graphql\GraphQL\ResolverRegistry` (`ResolverRegistryInterface`) — `addFieldResolver($type,
  $field, $resolver)`, `addTypeResolver()`; a schema's `registerResolvers()` populates it.
- `Drupal\graphql\GraphQL\Execution\FieldContext` — per-field cache metadata + context passed to
  every data producer's `resolve()`.

## Hooks
`hook_graphql_persisted_queries_alter(&$plugins)` — alter available persisted-query plugins
(see `graphql.api.php`).
