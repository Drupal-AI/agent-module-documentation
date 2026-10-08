# Hooks & the uniqueness check function

Declared in `unique_field_ajax.api.php`. Both fire inside `unique_field_ajax_is_unique()`.

## `hook_query_unique_field_ajax_alter(AlterableInterface $query)`

Alter the entity query used to look for a duplicate **before** it runs. The query carries this
metadata (read via `$query->getMetaData('<key>')`): `entity_type`, `lang_code`, `field_name`,
`field_value`, `bundle`, `is_unique_per_lang`, `entity`. The query is also tagged
`unique_field_ajax` (so `hook_query_TAG_alter` works too). Use it to add extra conditions —
e.g. only enforce uniqueness among published entities.

```php
function mymodule_query_unique_field_ajax_alter(AlterableInterface $query) {
  if ($query->getMetaData('field_name') === 'field_code') {
    $query->condition('status', 1);
  }
}
```

## `hook_unique_field_ajax_unique_results_alter(array &$result, array $metadata)`

Adjust the **result set** after the query runs, before the module decides pass/fail. `$result`
is the array of matching entity ids (empty = value is unique). `$metadata` has the same keys as
above plus `is_case_sensitive`. Emptying `$result` forces "unique"; adding an id forces a clash.

```php
function mymodule_unique_field_ajax_unique_results_alter(array &$result, array $metadata) {
  // Example from the API docs: force it to always fail uniqueness.
  // $result[0] = 0;
}
```

## The check function

`unique_field_ajax_is_unique(string $entity_type, string $lang_code, string $field_name,
?string $field_value, string $bundle, ?bool $is_unique_per_lang, ?bool $is_case_sensitive,
EntityBase $entity)` — returns `TRUE` when the value is unique, otherwise the id of the first
conflicting entity. It excludes the current entity (unless new), scopes by bundle, adds a
`langcode` condition when per-language is on, uses `LIKE BINARY` when case-sensitive, disables
access checks, then invokes the two hooks above. You can call it directly for programmatic checks.
