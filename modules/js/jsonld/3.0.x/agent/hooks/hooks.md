<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Customizing JSON-LD output (hooks)

Grounded in `jsonld.api.php`, `jsonld.module`, and
`src/Normalizer/ContentEntityNormalizer.php`.

## `hook_jsonld_alter_normalized_array(EntityInterface $entity, array &$normalized, array $context)`

Invoked once per **top-level** entity (`invokeAll`, only when `$context['depth'] == 0`), right
before the array is encoded. Mutate `$normalized` by reference to add/remove triples.
`$context['utils']` is a `JsonldNormalizerUtils` instance — call `->getEntityUri($entity)` to
build a matching `@id`.

```php
function mymodule_jsonld_alter_normalized_array(EntityInterface $entity, array &$normalized, array $context) {
  if ($entity->getEntityTypeId() !== 'node') {
    return;
  }
  if (isset($normalized['@graph'])) {
    if (!is_array($normalized['@graph'])) {
      $normalized['@graph'] = [$normalized['@graph']];
    }
    $normalized['@graph'][] = [
      '@id' => 'http://example.org/first/name',
      '@type' => 'schemaOrg:Person',
    ];
  }
}
```

Note `@graph` is a numeric-indexed array for the top-level entity (converted from associative
just before this hook fires), so append with `[] =`.

## `hook_jsonld_field_mappings(): string[][]`

Returns an associative map of **Drupal field type → JSON-LD datatype fragment** used when
normalizing field values. Implement it to add a datatype for a custom field type or override a
default. The module's own defaults (in `jsonld_jsonld_field_mappings()`) include:

```php
function mymodule_jsonld_field_mappings() {
  return [
    'my_geo_field' => ['@type' => 'xsd:string'],
    'datetime'     => ['@type' => 'xsd:dateTime'],   // overriding a default
    'entity_reference' => ['@type' => '@id'],         // references become @id links
    'list_string'  => ['@type' => 'xsd:string', '@container' => '@list'],
  ];
}
```

Only the resolved `->value()` of each field is mapped (complex fields like
`text_with_summary` collapse to their main value). All implementations are merged.

## `hook_rdf_namespaces()` (core RDF hook, implemented here from config)

The module implements `jsonld_rdf_namespaces()` to feed the prefixes entered in the settings
form (`jsonld.settings:rdf_namespaces`) into core RDF's namespace registry, so they appear in
the generated `@context`. To register namespaces from your own module, implement
`hook_rdf_namespaces()` returning `['prefix' => 'http://full/namespace#']`. (For site builders,
prefer the settings form — see [../configure/settings.md](../configure/settings.md).)

## Test module reference

The module's own `tests/json_alter_normalize_hooks.module` is a minimal, working example of
`hook_jsonld_alter_normalized_array` if you need a canonical pattern.
