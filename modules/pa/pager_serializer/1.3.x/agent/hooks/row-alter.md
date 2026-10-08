# hook_pager_serializer_row_alter()

Declared in `pager_serializer.api.php`. Lets you modify each serialized row before it is added
to the output, from a REST export view using the `pager_serializer` style.

```php
/**
 * Implements hook_pager_serializer_row_alter().
 *
 * @param array $row
 *   The rendered row output (by reference).
 * @param \Drupal\views\ResultRow $result
 *   The raw Views result row.
 * @param \Drupal\views\ViewExecutable $view
 *   The view being rendered.
 */
function mymodule_pager_serializer_row_alter(&$row, \Drupal\views\ResultRow $result, \Drupal\views\ViewExecutable $view) {
  if ($view->id() === 'my_view') {
    // Add a computed field to every row.
    $row['custom_field'] = my_function($result->nid);
  }
}
```

## When it fires

Inside `PagerSerializer::render()`, once per result row:
`$this->moduleHandler->alter('pager_serializer_row', $output, $row, $this->view);`
— where `$output` is the row plugin's rendered output (the `&$row` you receive).

## Notes

- `$row` is passed by reference; mutate it in place.
- Gate on `$view->id()` (and/or the display) so you only touch the intended view.
- `$result` is the `ResultRow` (access entity/fields via its properties, e.g. `$result->_entity`).
- Runs before rows are wrapped with the pager, so it only affects row content, not pager keys.
