# datalayer hooks

Declared in `datalayer.api.php`. Implement these in `MYMODULE.module` to extend or reshape
the dataLayer. Two families: **meta** hooks choose which entity *properties* are candidates
for output; **alter** hooks rewrite the assembled values.

## `hook_datalayer_alter(array &$data_layer)`

Alter the final payload just before it is encoded and pushed. Receives the whole array by
reference — the main extension point for adding/removing/transforming values.

```php
function mymodule_datalayer_alter(array &$data_layer) {
  $data_layer['siteName'] = strtolower($data_layer['siteName']);
  $data_layer['env'] = getenv('APP_ENV') ?: 'prod';
}
```

## `hook_datalayer_meta()` / `hook_datalayer_ENTITY_TYPE_meta()`

Return an array of entity **property names** to expose. The generic hook applies to all
entity types; the `ENTITY_TYPE` variant (e.g. `hook_datalayer_node_meta`) overrides it for
that type. There is also `hook_datalayer_current_user_meta()` for the exposed-user payload.

```php
function mymodule_datalayer_meta() {
  return ['status'];            // candidate property, output as entityStatus
}
function mymodule_datalayer_node_meta() {
  return ['created', 'changed'];
}
```

Actual output of a candidate is still gated by config (`entity_meta` / `current_user_meta`
selection); an empty selection outputs all candidates.

## `hook_datalayer_meta_alter(array $properties)` / `hook_datalayer_ENTITY_TYPE_meta_alter()`

Alter the list of candidate properties (e.g. drop one for anonymous authors).

```php
function mymodule_datalayer_meta_alter(array $properties) {
  if (($properties['uid'] ?? 1) === 0) { unset($properties['uid']); }
}
```

## `hook_datalayer_field_alter(array &$value, FieldItemInterface $field_item, string $field_type)`

Reshape a single exposed field's value before it lands in the payload.

```php
function mymodule_datalayer_field_alter(array &$value, $field_item, $field_type) {
  if ($field_type === 'text_with_summary') {
    unset($value['format']);   // strip the text format
  }
}
```

## Notes

- Legacy hook functions are bridged to `#[LegacyHook]` OOP methods in `src/Hook/`; you still
  implement the plain `hook_*` functions in your module.
- These are the module's own hooks — it does not define plugin types, permissions, or drush
  commands.
