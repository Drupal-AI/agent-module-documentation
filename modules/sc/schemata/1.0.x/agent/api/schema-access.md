# Accessing schemas (HTTP + programmatic)

Schemata exposes each content entity type and bundle as a schema resource. Schemata itself
only builds an abstract `SchemaInterface` object; a **provider submodule** (e.g.
`schemata_json_schema`) supplies the serializer that turns it into a concrete format.

## HTTP routes

Routes are generated dynamically for every entity type and every bundle by
`Drupal\schemata\Routing\Routes` (`route_callbacks` in `schemata.routing.yml`). Pattern:

```
GET /schemata/{entity_type}/{bundle}?_format={schema_format}&_describes={described_format}
```

- Omit `/{bundle}` for entity types without bundles (e.g. `user`).
- `_format` — the schema type to produce, e.g. `schema_json` (registered by
  schemata_json_schema).
- `_describes` — the Drupal REST representation being described: `json`, `hal_json`, or
  `api_json` (JSON:API; requires the `jsonapi` module).
- Method is **GET only**; every route requires the `access schemata data models` permission.
- Route names: `schemata.{entity_type}` or `schemata.{entity_type}:{bundle}`.

Examples:

```
/schemata/node/article?_format=schema_json&_describes=hal_json
/schemata/user?_format=schema_json&_describes=api_json
```

The response `Content-Type` is derived from `_format` (schema_json →
`application/schema+json`, registered via `SchemataServiceProvider`). Responses are
cacheable and vary on the `_describes` query arg.

## Programmatic API — `schemata.schema_factory`

Service id `schemata.schema_factory` (class `Drupal\schemata\SchemaFactory`). Build a schema
object and hand it to the `serializer` service:

```php
$entity_type_id = 'node';
$bundle = 'article';                 // NULL for entity types without bundles
$schema_factory = \Drupal::service('schemata.schema_factory');
$serializer = \Drupal::service('serializer');

// Returns a Drupal\schemata\Schema\SchemaInterface (NodeSchema for node bundles,
// Schema otherwise), or NULL if the entity type is not a content entity or the
// bundle does not exist (a warning is logged to the 'schemata' channel).
$schema = $schema_factory->create($entity_type_id, $bundle);

// Serialize. Format string is "{_format}:{_describes}", e.g. "schema_json:hal_json".
$output = $serializer->serialize($schema, 'schema_json:hal_json', []);
```

`SchemaFactory::create()` only accepts content entities (checked via
`entityClassImplements(ContentEntityInterface::class)`); config entities return `NULL`.

### `SchemaInterface` (Drupal\schemata\Schema\SchemaInterface)

The object returned by `create()`:

- `getEntityTypeId(): string` — entity type id.
- `getBundleId(): string` — bundle id.
- `getProperties(): DataDefinitionInterface[]` — the entity's property data definitions.
- `addProperties(array $properties)` — append extra property definitions before serializing.
- `getMetadata(): string[]` — schema metadata values.

## Building schema URLs — `SchemaUrl`

Static helper `Drupal\schemata\SchemaUrl` returns a core `Url` object pointing at a schema
resource (adds `_format`/`_describes` query args, absolute):

```php
use Drupal\schemata\SchemaUrl;
$url = SchemaUrl::fromOptions('schema_json', 'hal_json', 'node', 'article');
// or from an existing schema object:
$url = SchemaUrl::fromSchema('schema_json', 'hal_json', $schema);
```

## Caveat (observed on Drupal 11)

The `schemata.schema_factory` build path and the dynamic routes work, but serializing to
`schema_json` currently throws a `TypeError` (`str_contains()` receiving an array in
`DataReferenceDefinitionNormalizer` → `EntityTypeManager::getDefinition()`) for entities
with reference fields under this Drupal 11 site. Treat JSON Schema output as provider-version
dependent and verify against your build.
