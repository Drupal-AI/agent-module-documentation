# Synonyms hooks

Two extension points.

## `hook_synonyms_field_type_to_synonym_alter(array &$map)`

Declared in `synonyms.api.php`. Controls which "simple" field types the shipped `field` / `base-field`
providers treat as synonym sources, and which field **column/property** holds the synonym value.

- `$map` keys are field-type ids; values are the property name to read (e.g. `value`).
- The built-in map is assembled in `FieldTypeToSynonyms::getSimpleFieldTypeToPropertyMap()` and covers
  text, entity_reference, integer/number, float, decimal, email, telephone.

```php
function my_module_synonyms_field_type_to_synonym_alter(array &$map) {
  // Make my custom field type eligible; synonyms live in its 'value' column.
  $map['my_custom_field_type'] = 'value';
}
```

## `synonyms_provider_info` (plugin-info alter)

Standard `DefaultPluginManager` alter hook (`$manager->alterInfo('synonyms_provider_info')`). Implement
`hook_synonyms_provider_info_alter(array &$definitions)` to add, remove, or tweak `synonyms_provider`
plugin definitions after discovery.

> Note: enabling submodule **behaviors** is done through tagged services + the *Manage behaviors* form
> (see [../api/services.md](../api/services.md)), not through a hook.
