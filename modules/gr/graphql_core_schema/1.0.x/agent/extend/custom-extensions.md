# Writing your own extension / altering the schema

## Custom schema extension plugin

Extend the generated `core_composable` schema with your own types/fields and resolvers.

- Create a `@SchemaExtension` plugin with `schema = "core_composable"`, extending
  `SdlSchemaExtensionPluginBase` and implementing
  `Drupal\graphql_core_schema\CoreSchemaExtensionInterface`.
- Provide `graphql/<id>.base.graphqls` and/or `graphql/<id>.extension.graphqls` in your module for the
  SDL, then `registerResolvers(ResolverRegistryInterface $registry)` to wire resolvers with the GraphQL
  `ResolverBuilder`.
- Declare dependencies so the schema builder enables prerequisites:
  - `getEntityTypeDependencies(): string[]` — entity types your extension needs.
  - `getExtensionDependencies(): string[]` — other extension ids (e.g. `['routing']`).

Minimal shape (mirrors `BreadcrumbExtension`):

```php
/**
 * @SchemaExtension(
 *   id = "my_thing",
 *   name = "My Thing",
 *   description = "…",
 *   schema = "core_composable"
 * )
 */
class MyThingExtension extends SdlSchemaExtensionPluginBase implements CoreSchemaExtensionInterface {
  public function getEntityTypeDependencies() { return []; }
  public function getExtensionDependencies() { return ['routing']; }
  public function registerResolvers(ResolverRegistryInterface $registry): void {
    $builder = new ResolverBuilder();
    $registry->addFieldResolver('SomeType', 'someField',
      $builder->produce('my_producer')->map('x', $builder->fromParent()));
  }
}
```

**Access reminder:** a custom field resolver **bypasses** `CoreComposableResolver::resolveFieldDefault`,
so it also bypasses that resolver's automatic `->access('view')` filtering. Perform access checks inside
your resolver / data producer when returning entities or field values. See
[../api/access-and-resolvers.md](../api/access-and-resolvers.md).

## Altering the generated entity-field schema

Subscribe to the event to change how a field is generated (its GraphQL name, schema type, description,
or to skip it):

```php
// EventSubscriber, listening on:
\Drupal\graphql_core_schema\Event\AlterEntityFieldEvent::EVENT_NAME
// = 'graphql_core_schema.alter_entity_field'
```

The `AlterEntityFieldEvent` exposes/lets you set: `gqlFieldMachineName`, `gqlFieldSchemaType`,
`gqlFieldName`, `gqlFieldDescription`, plus read access to the `EntityTypeInterface`, the schema
configuration, the `DataDefinitionInterface`, and the raw field definition. See
`EventSubscriber/AlterEntityFieldSchemaSubscriber` (registered in `graphql_core_schema.services.yml`) for
a working example.

## Notes

- The schema/extension SDL is only parsed/generated when GraphQL development mode is on; in production it
  is cached — clear caches after changing SDL or resolvers.
- `graphql_core_schema.module` forces the server `debug_flag` to FALSE on save
  (`graphql_core_schema_form_graphql_server_validate`).
