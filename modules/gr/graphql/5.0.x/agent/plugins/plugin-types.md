<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin types

GraphQL defines four plugin types. Each has an annotation (`@Name`) and an equivalent PHP
attribute (`#[Name]`) under `Drupal\graphql\Annotation` / `Drupal\graphql\Attribute`, a manager
service, and a discovery subdirectory under a module's `src/Plugin/GraphQL/`.

| Plugin type | Subdir | Manager service | Annotation/Attribute | Base class |
|---|---|---|---|---|
| **Schema** | `Plugin/GraphQL/Schema` | `plugin.manager.graphql.schema` | `@Schema` / `#[Schema]` | `SdlSchemaPluginBase`, `ComposableSchema` |
| **SchemaExtension** | `Plugin/GraphQL/SchemaExtension` | `plugin.manager.graphql.schema_extension` | `@SchemaExtension` | `SdlSchemaExtensionPluginBase` |
| **DataProducer** | `Plugin/GraphQL/DataProducer` | `plugin.manager.graphql.data_producer` | `@DataProducer` | `DataProducerPluginBase` |
| **PersistedQuery** | `Plugin/GraphQL/PersistedQuery` | `plugin.manager.graphql.persisted_query` | `@PersistedQuery` | `PersistedQueryPluginBase` |

## Schema (`@Schema`)
Defines a complete GraphQL schema. Props: `id`, `name`, `description`. A `graphql_server` entity's
`schema` key holds one Schema plugin id. Two common bases:
- **`SdlSchemaPluginBase`** — you provide a `.graphqls` SDL file (colocated `*.graphqls`) and
  implement `registerResolvers(ResolverRegistryInterface $registry)` to bind resolvers to fields.
- **`ComposableSchema`** (id `composable`) — carries no types of its own; it aggregates the SDL +
  resolvers of the `@SchemaExtension` plugins selected in the server's
  `schema_configuration.composable.extensions`. `AlterableComposableSchema` additionally lets other
  modules alter the composed schema.

## SchemaExtension (`@SchemaExtension`)
Adds SDL fragments and resolvers to a composable schema. Props include `id`, `name`, `description`,
`schema` (the target composable schema id it plugs into). Extend
`SdlSchemaExtensionPluginBase`, ship a `<id>.base.graphqls` and/or `<id>.extension.graphqls`, and
implement `registerResolvers()`. This is how independent modules each contribute part of one schema.

## DataProducer (`@DataProducer`)
A single, reusable, cacheable field-resolution step — "load entity", "get property", "create
article", etc. Props: `id`, `name`, `description`, `produces` (a `ContextDefinition` for the output),
and `consumes` (a map of input `ContextDefinition`s). Extend `DataProducerPluginBase` and implement
`resolve(...$args, FieldContext $context)`. Resolvers chain data producers with the
`ResolverBuilder`: `$builder->produce('entity_load')->map('type', ...)->map('id', ...)`.

## PersistedQuery (`@PersistedQuery`)
Lets clients send a stored query id instead of the full query text. Props: `id`, `name`,
`description`. Enabled/configured per server under `persisted_queries_settings`; loaders are tried
in weight order. Alter the set with `hook_graphql_persisted_queries_alter()`.

See [../extend/build-a-schema.md](../extend/build-a-schema.md) for full skeletons.
