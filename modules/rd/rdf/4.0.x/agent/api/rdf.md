# RDF — programmatic API

In 4.x the procedural helpers (`rdf_get_mapping()`, `rdf_get_namespaces()`,
`rdf_rdfa_attributes()`) are **removed**. Use the `RdfMappingHelper` service and the
`RdfMapping` config entity directly.

## Get / edit a bundle mapping
Load and edit via the `RdfMapping` config entity (`Drupal\rdf\Entity\RdfMapping`).
`RdfMappingHelper::getMapping($entity_type, $bundle)` returns the saved entity, or a
ready-to-use empty one if none exists yet. Chainable setters:

```php
$helper = \Drupal::service('Drupal\rdf\RdfMappingHelper');
$helper->getMapping('node', 'article')
  ->setBundleMapping(['types' => ['schema:Article', 'sioc:Post']])
  ->setFieldMapping('title', ['properties' => ['schema:name']])
  ->setFieldMapping('created', [
    'properties' => ['schema:dateCreated'],
    'datatype' => 'xsd:dateTime',
    'datatype_callback' => ['callable' => 'Drupal\rdf\CommonDataConverter::dateIso8601Value'],
  ])
  ->save();
```

## `RdfMapping` config entity (`Drupal\rdf\Entity\RdfMapping`)
Implements `RdfMappingInterface`:
- `getBundleMapping()` / `setBundleMapping(array)` — the bundle's `types`.
- `getPreparedBundleMapping()` — always returns `['types' => ...]` (empty array if unset).
- `getFieldMapping($field)` / `setFieldMapping($field, array)` — per-field mapping.
- `getPreparedFieldMapping($field)` — normalized field mapping (keys `properties`,
  `datatype`, `datatype_callback`, `mapping_type`); returns `[]` if no `properties`.
Load/create directly with `RdfMapping::load('node.article')` /
`RdfMapping::create([...])`. The config entity id is `<targetEntityType>.<bundle>`.

## `RdfMappingHelper` service (`Drupal\rdf\RdfMappingHelper`)
Autowired service (defined in `rdf.services.yml`, id = the FQCN):
- `getMapping(string $entity_type, string $bundle): RdfMapping` — see above.
- `getNamespaces(): array` — collects all prefix→URI pairs from every
  `hook_rdf_namespaces()` implementation via `moduleHandler()->invokeAllWith()`; throws
  `\Exception` on a conflicting duplicate (same prefix, different URI).
- `rdfaAttributes(array $mapping, mixed $data = NULL): array` — turns a prepared field
  mapping (`properties`, optional `datatype`, `datatype_callback`, `mapping_type`) into an
  attributes array. `mapping_type` of `rel`/`rev` emits that attribute; default `property`
  emits `property` (+ `content` from the datatype callback and `datatype` when set).
- `setFieldRelAttribute(array &$variables): void` — swaps a `property` attribute for `rel`
  (used for link-only fields like the node uid field).

## Built-in namespace prefixes
`RdfHooks::rdfNamespaces()` defines: content, dc, foaf, og, rdfs, schema, sioc, sioct,
skos, xsd.

## Datatype callbacks
- `Drupal\rdf\CommonDataConverter` — `rawValue($data)`, `dateIso8601Value($data)`.
- `Drupal\rdf\SchemaOrgDataConverter` — `interactionCount(int $count, array $arguments)`.
