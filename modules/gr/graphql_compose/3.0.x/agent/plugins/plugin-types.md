# Plugin types

GraphQL Compose defines **three** custom plugin types, each with its own manager, PHP
attribute (legacy annotation also supported) and discovery directory. Plugins are discovered
from any enabled module (yours or a submodule). It also uses the base `graphql` module's
DataProducer and SchemaExtension plugin types.

## 1. EntityType — map a Drupal entity type to GraphQL

- Directory: `src/Plugin/GraphQLCompose/EntityType/`
- Attribute: `Drupal\graphql_compose\Attribute\EntityType`
- Interface / base: `GraphQLComposeEntityTypeInterface` / `GraphQLComposeEntityTypeBase`
- Manager service: `graphql_compose.entity_type_manager` (`GraphQLComposeEntityTypeManager`)
- Alter hook: `graphql_compose_entity_type` (`hook_..._alter`)
- Built-ins: `Node`, `Media`, `Paragraph`, `TaxonomyTerm`, `Group`, `ConfigurableLanguage`, `LibraryItem`.

Attribute params: `id` (entity type id, e.g. `node`), `interfaces[]`, `base_fields[]`,
`hidden` (hide from the UI), `type_sdl`, `prefix`, `deriver`, `third_party_settings`.

```php
#[EntityType(id: 'node', interfaces: ['Node'], base_fields: [...])]
class Node extends GraphQLComposeEntityTypeBase { /* … */ }
```

## 2. FieldType — map a Drupal field type to a GraphQL field

- Directory: `src/Plugin/GraphQLCompose/FieldType/`
- Attribute: `Drupal\graphql_compose\Attribute\FieldType`
- Interface / base: `GraphQLComposeFieldTypeInterface` / `GraphQLComposeFieldTypeBase`
- Manager service: `graphql_compose.field_type_manager` (`GraphQLComposeFieldTypeManager`)
- Alter hook: `graphql_compose_field_type`
- Built-ins: many (`StringItem`, `TextItem`, `ImageItem`, `LinkItem`, `EntityReferenceItem`,
  `BooleanItem`, `DateTimeItem`, `EmailItem`, …). The `id` is the Drupal field-type id (e.g. `string`).

Attribute params: `id` (field type id), `description`, `type_sdl` (the GraphQL type it returns),
`name_sdl`, `deriver`, `third_party_settings`.

```php
#[FieldType(id: 'string', type_sdl: 'String')]
class StringItem extends GraphQLComposeFieldTypeBase { /* … */ }
```

Fields can produce a union type via `FieldUnionInterface` / `FieldUnionTrait`.

## 3. SchemaType — declare a reusable GraphQL type/scalar/union

- Directory: `src/Plugin/GraphQLCompose/SchemaType/`
- Attribute: `Drupal\graphql_compose\Attribute\SchemaType`
- Interface / base: `GraphQLComposeSchemaTypeInterface` / `GraphQLComposeSchemaTypeBase`
- Manager service: `graphql_compose.schema_type_manager` (`GraphQLComposeSchemaTypeManager`)
- Alter hook: `graphql_compose_schema_type`
- Built-ins: `ImageType`, `LinkType`, `DateTimeType`, `AddressType`, `LanguageType`,
  `TextType`, `SchemaInformationType`, `SortDirectionType`, … Attribute params: `id`
  (the GraphQL type name), `deriver`, `third_party_settings`.

The schema-type manager collects `Type` objects and `extend`s the schema; it is invoked by the
`AlterSchemaSubscriber` event subscriber and the `hook_graphql_compose_print_types()` /
`_print_extensions()` hooks (see hooks doc).

## Resolution: DataProducer & SchemaExtension (base graphql plugin types)

- `src/Plugin/GraphQL/DataProducer/*` — the resolver building blocks (e.g. `Field`,
  `FieldResults`, `EntityLoadByUuidOrId`, `EntityUnpublishedFilter`, language producers).
- `src/Plugin/GraphQL/SchemaExtension/*` — `EntitySchemaExtension`, `LanguageSchemaExtension`,
  `InformationSchemaExtension` wire producers to the schema. Submodules add their own
  extensions (e.g. Edges → connections, Routes → route resolvers).
- `src/Plugin/GraphQL/Schema/GraphQLComposeSchema.php` — the schema plugin (`schema: graphql_compose`).

## How to add support for a new field/entity/type

1. Put a class in the matching `Plugin/GraphQLCompose/<EntityType|FieldType|SchemaType>/` dir
   of your module, annotated with the matching attribute and `id`.
2. If it needs new GraphQL types, add a SchemaType plugin (or use a hook).
3. Clear the `graphql_compose.definitions` cache (and graphql caches) — the module's
   `_graphql_compose_cache_flush()` does this.
