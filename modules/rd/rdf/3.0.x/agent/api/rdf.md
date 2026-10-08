# RDF — programmatic API

## Get / edit a bundle mapping
`rdf_get_mapping($entity_type, $bundle)` returns the `RdfMapping` config entity for a
bundle, or a ready-to-use empty one if none is saved yet. Chainable setters mirror the
old core API:

```php
rdf_get_mapping('node', 'article')
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
- `getPreparedBundleMapping()` — always returns an array (empty `types` if unset).
- `getFieldMapping($field)` / `setFieldMapping($field, array)` — per-field mapping.
- `getPreparedFieldMapping($field)` — normalized field mapping.
Load/create directly with `RdfMapping::load('node.article')` /
`RdfMapping::create([...])`.

## Namespaces
- `rdf_get_namespaces()` — collects all prefix→URI pairs from every
  `hook_rdf_namespaces()` implementation (throws on conflicting duplicates).
- Built-ins (`rdf_rdf_namespaces()`): content, dc, foaf, og, rdfs, schema, sioc, sioct,
  skos, xsd.

## Build RDFa attributes
`rdf_rdfa_attributes($mapping, $data = NULL)` turns a mapping array (`properties`,
optional `datatype`, `datatype_callback`, `type`) into an attributes array for
`Drupal\Core\Template\Attribute`. Datatype callbacks:
`Drupal\rdf\CommonDataConverter` and `Drupal\rdf\SchemaOrgDataConverter`
(e.g. `dateIso8601Value`, `interactionCount`).
