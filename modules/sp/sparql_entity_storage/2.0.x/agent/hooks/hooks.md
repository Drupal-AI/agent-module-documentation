<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks

## `hook_sparql_apply_default_fields_alter(FieldStorageConfig $storage, array &$values)`
(`sparql_entity_storage.api.php`) Alter the default field values/config applied to fields of SPARQL-stored
entities. `$values` is an associative array of field values including formatter-added data.

```php
function my_module_sparql_apply_default_fields_alter(FieldStorageConfig $storage, array &$values) {
  if ($storage->getType() === 'text_long') {
    foreach ($values as &$value) {
      $value['format'] = 'my_custom_persistent_filter';
    }
  }
}
```

## `hook_sparql_entity_id_info_alter(array &$info)`
Alter the discovered `sparql_entity_id` generator plugin definitions (registered via the manager's
`alterInfo('sparql_entity_id_info')`). See [../plugins/id-generator.md](../plugins/id-generator.md).

## Events (not hooks, but the main extension surface)
Dispatched via `SparqlEntityStorageEvents`; subscribe with an event subscriber service:
- Inbound/outbound value conversion — `InboundValueEvent` / `OutboundValueEvent` (the module ships datetime and
  translatable-literal subscribers as examples).
- `ActiveGraphEvent` — influence which graph is active for an operation.
- `DefaultGraphsEvent` — alter the default set/order of graphs.

These events are how you customize RDF value serialization and graph resolution beyond the field mappings.
