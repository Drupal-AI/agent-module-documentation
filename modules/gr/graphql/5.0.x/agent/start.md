<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# graphql — agent start

**Framework for building GraphQL servers on Drupal.** Depends on `typed_data`; bundles
`webonyx/graphql-php` as the executor. Configure route: `entity.graphql_server.collection`
(`/admin/config/graphql`). A bare install has the plugin types + the server config entity but
**no servers and no usable schema** — you write a schema, or enable the `graphql_composable`
submodule (schema id `composable_example`) for a working endpoint.

Central object = the **`graphql_server` config entity** (config prefix `graphql_servers`):
it names a Schema plugin, holds `schema_configuration`, and declares an `endpoint` path. On save,
`RouteProvider` mints the JSON route `graphql.query.<server_id>` at that path.

- The `graphql_server` config entity, its keys, the endpoint route, drush/admin UI → [configure/servers.md](configure/servers.md)
- The four plugin types (Schema, SchemaExtension, DataProducer, PersistedQuery) → [plugins/plugin-types.md](plugins/plugin-types.md)
- Write a schema / extension / data producer (SDL + resolvers) → [extend/build-a-schema.md](extend/build-a-schema.md)
- Services, entity API, executing operations programmatically → [api/services.md](api/services.md)

Key names: config entity `graphql_server` (id key = `name`; config keys `schema`, `endpoint`,
`schema_configuration`, `caching`, `batching`, `disable_introspection`, `query_depth`,
`query_complexity`, `persisted_queries_settings`). Endpoint route `graphql.query.<id>`,
controller `Drupal\graphql\Controller\RequestController::handleRequest`, access check
`_graphql_query_access`. Plugin managers: `plugin.manager.graphql.schema`,
`.schema_extension`, `.data_producer`, `.persisted_query`. Base classes `SdlSchemaPluginBase`,
`ComposableSchema`, `SdlSchemaExtensionPluginBase`, `DataProducerPluginBase`. Permissions
`administer graphql configuration`, `bypass graphql access`.
