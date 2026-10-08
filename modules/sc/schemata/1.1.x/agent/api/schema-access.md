<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Accessing schemas (HTTP + programmatic)

Schemata exposes each content entity type and bundle as a schema resource. Schemata itself
only builds an abstract `SchemaInterface` object; a **provider submodule** (e.g.
`schemata_json_schema`) supplies the serializer that turns it into a concrete format.

## HTTP routes

Routes are generated dynamically for every entity type and every bundle by
`Drupal\schemata\Routing\Routes::routes()` (`route_callbacks` in `schemata.routing.yml`). It
iterates `entity_type.manager` definitions and `entity_type.bundle.info`, adding one route per
entity type plus one per bundle. Pattern:

```
GET /schemata/{entity_type}/{bundle}?_format={schema_format}&_describes={described_format}
```

- Omit `/{bundle}` for entity types without bundles (e.g. `user`).
- `_format` — the schema type to produce, e.g. `schema_json` (registered by
  schemata_json_schema; the format/MIME `application/schema+json` is registered in
  `Drupal\schemata\SchemataServiceProvider`).
- `_describes` — the Drupal REST representation being described: `json`, `hal_json`, or
  `api_json` (JSON:API; requires the `jsonapi` module).
- Method is **GET only**; every route sets `_permission` = `access schemata data models`
  (see `Routes::createRoute()`).
- Route names: `schemata.{entity_type}` or `schemata.{entity_type}:{bundle}`.

Examples:

```
/schemata/node/article?_format=schema_json&_describes=hal_json
/schemata/user?_format=schema_json&_describes=api_json
```

The controller (`Drupal\schemata\Controller\Controller::serialize()`) builds the serializer
format string as `{_format}:{_describes}`, sets the response `Content-Type` from `_format`
(schema_json → `application/schema+json`), and returns a `CacheableResponse` that varies on
the `url.query_args:_describes` cache context (cache tags `entity_bundles`,
`entity_field_info`, `entity_types` come from the schema object).

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

`SchemaFactory::create()` only accepts content entities (checked in `getSourceEntityPlugin()`
via `entityClassImplements(ContentEntityInterface::class)`); config entities return `NULL`.
Internally it builds an `EntityDataDefinition` from `typed_data_manager` keyed
`entity:{type}[:{bundle}]` and constructs `NodeSchema` for `node` + bundle, otherwise `Schema`.

### `SchemaInterface` (`Drupal\schemata\Schema\SchemaInterface`)

The object returned by `create()`:

- `getEntityTypeId(): string` — entity type id.
- `getBundleId(): string` — bundle id.
- `getProperties(): DataDefinitionInterface[]` — the entity's property data definitions.
- `addProperties(array $properties)` — append extra property definitions before serializing.
- `getMetadata(): string[]` — schema metadata (`title`, `description`). `NodeSchema`
  overrides `createDescription()` to use the node type's description (tag-stripped,
  slash-escaped) when present.

## Building schema URLs — `SchemaUrl`

Static helper `Drupal\schemata\SchemaUrl` returns a core `Url` object pointing at a schema
resource (adds `_format`/`_describes` query args, absolute):

```php
use Drupal\schemata\SchemaUrl;
$url = SchemaUrl::fromOptions('schema_json', 'hal_json', 'node', 'article');
// or from an existing schema object:
$url = SchemaUrl::fromSchema('schema_json', 'hal_json', $schema);
```

## Changed in 8.x-1.1 (vs 1.0.x)

- **JSON Schema output on Drupal 11.4 now works.** The 1.0.x caveat (a `TypeError` /
  `str_contains()`-on-array while normalizing reference fields) is resolved: since Drupal 11.4
  the `EntityType` constraint value is an associative array (`['type' => $id]`), and
  `schemata_json_schema`'s `DataReferenceDefinitionNormalizer::getTargetEntityTypeId()` now
  handles both that shape and the legacy plain-string form. Verified: `schema_json:json`
  serializes cleanly for `node`, `user`, and `taxonomy_term:tags` on this D11.4 site.
- The type-mapper plugin manager is now injected into the JSON Schema normalizers via the
  constructor (a container fallback with an `E_USER_DEPRECATED` notice remains for
  subclasses that were built before 1.1 and do not pass it).
