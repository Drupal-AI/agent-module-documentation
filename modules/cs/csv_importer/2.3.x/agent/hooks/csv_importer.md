# Hooks

## `hook_csv_importer_pre_import(array &$data)`

Declared in `csv_importer.api.php`. Invoked (via `moduleHandler->invokeAll`) inside
`ImporterBase::data()` **after** the CSV has been parsed and normalized but **before** any
entity is created/updated. `$data` is the prepared structure — `$data['content'][<row>][<field>]`
— and is passed by reference so you can clean, add, or remove values.

```php
/**
 * Implements hook_csv_importer_pre_import().
 */
function mymodule_csv_importer_pre_import(array &$data) {
  foreach ($data['content'] as &$content) {
    foreach ($content as &$item) {
      if (isset($item['title'])) {
        $item['title'] = ltrim($item['title'], '/');
      }
    }
  }
}
```

## `importer_info` alter hook

`ImporterManager` registers `alterInfo('importer_info')`, so
`hook_importer_info_alter(array &$definitions)` lets you modify or remove the discovered
importer plugin definitions (e.g. the per-entity-type derivatives) before they are used.

There are no other hooks and no Drush commands.
