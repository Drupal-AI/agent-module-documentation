<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API: services & programmatic execution

## Plugin manager services
- `plugin.manager.graphql.schema` — `SchemaPluginManager`; `getInstanceFromServer($server)` builds
  the schema plugin for a given `graphql_server` entity.
- `plugin.manager.graphql.schema_extension` — `SchemaExtensionPluginManager`.
- `plugin.manager.graphql.data_producer` — `DataProducerPluginManager`; `createInstance($id)`.
- `plugin.manager.graphql.persisted_query` — `PersistedQueryPluginManager`.
- `graphql.executor` — `ExecutorFactory`, the query executor plugged into `webonyx/graphql-php`.
- `graphql.introspection` (`Utility\Introspection`), `graphql.validator` (`Validator`),
  `graphql.file_upload` (`Utility\FileUpload`), and entity buffers `graphql.buffer.entity[_revision|_uuid|_preview]`.

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

$server->executeBatch([$op1, $op2]);          // batched operations (sequential, shared Drupal context)
$config = $server->configuration();            // GraphQL\Server\ServerConfig (schema, resolvers, rules)
```

`executeOperation()` temporarily swaps in the module's executor factory, runs the webonyx
`Helper::executeOperation()`, and wraps the result as an `ExecutionResult`. Getters/setters for the
guard rails: `getDisableIntrospection()/setDisableIntrospection()`,
`getQueryDepth()/setQueryDepth()`, `getQueryComplexity()/setQueryComplexity()`. Persisted-query
instances: `getPersistedQueryInstances()`, `addPersistedQueryInstance()`,
`removePersistedQueryInstance()`.

## HTTP endpoint
Each server's endpoint is route `graphql.query.<id>` → `RequestController::handleRequest`. The
`QueryRouteEnhancer` parses request params (via webonyx `Helper::parseRequestParams`) and, for POST,
asserts CSRF-safe headers before handing off. It accepts POST (`application/json` with `query`,
`variables`, `operationName`, or a persisted `queryId`; also `application/graphql` and
`multipart/form-data` for file uploads) and GET; requires `_graphql_query_access` and
`_format: json`; enables all auth providers. Clients: `POST /graphql` with `{"query":"{ ... }"}`.
See [../permissions/access.md](../permissions/access.md) for the access + CSRF details.

## Resolver building blocks
- `Drupal\graphql\GraphQL\ResolverBuilder` — fluent resolver construction:
  `produce($dataProducerId)`, `fromValue()`, `fromArgument()`, `fromParent()`, `fromContext()`,
  `compose()`, `map()`, `tap()`, `callback()`, `defaultValue()`, `cond()`.
- `Drupal\graphql\GraphQL\ResolverRegistry` (`ResolverRegistryInterface`) — `addFieldResolver($type,
  $field, $resolver)`, `addTypeResolver()`; a schema's `registerResolvers()` populates it.
- `Drupal\graphql\GraphQL\Execution\FieldContext` — per-field cache metadata + context passed to
  every data producer's `resolve()`.

## Hooks & events
- `hook_graphql_term_autocomplete_query_alter(array $args, SelectInterface $query, ConditionInterface $group)`
  — alter the query built by the taxonomy term autocomplete data producer (see `graphql.api.php`).
- `OperationEvent`, `AlterSchemaDataEvent`, `AlterSchemaExtensionDataEvent` — dispatched during
  execution / composable-schema building for subscribers to react to or alter.
