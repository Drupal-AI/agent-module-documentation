# Hooks

Declared in `views_data_export.api.php`.

## `hook_views_data_export_row_alter(&$row, \Drupal\views\ResultRow $result, \Drupal\views\ViewExecutable $view)`
Alter each row just before it is serialized into the export file. `$row` is the associative
array of output columns; `$result` is the raw Views result row; `$view` is the executing View.

```php
function mymodule_views_data_export_row_alter(&$row, $result, $view) {
  if ($view->id() == 'my_view') {
    // Add or transform a column in the exported file.
    $row['custom_field'] = my_function($result->nid);
  }
}
```

Related core integration points the module also uses: `hook_views_query_alter()` (for Facets on
`data_export` displays) and `hook_file_access()` (restricts downloading a generated export to the
user who created it).
