# API: writing aggregation functions & plugin helpers

All symbols are procedural functions in `views_aggregator_functions.inc` plus public methods
on the style plugin `Drupal\views_aggregator\Plugin\views\style\Table`.

## Discovery helper (module file)

```php
// All function definitions (keyed by function name), or one by name.
views_aggregator_get_aggregation_functions_info(?string $name = NULL): array
```
Invokes `hook_views_aggregation_functions_info` on all modules, `ksort`s, then runs the
`_alter`. Statically cached.

## Callback signatures a custom function must match

A regular group/column function receives the pre-built groups and returns a values array —
one entry per group id, plus a `'column'` entry for the whole-column (totals) result:

```php
function mymodule_myfunc(array $groups, FieldHandlerInterface $field_handler,
                         ?string $param_group = NULL, ?string $param_column = NULL): array {
  $values = [];
  foreach ($groups as $group => $rows) {      // $group is a group key or 'column'
    // ... compute from cells via $style->getCell($field_handler, $row_num) ...
    $values[$group] = $result;
  }
  $values['column'] = $whole_column_result;   // used for the totals row
  return $values;
}
```

The two special functions have different signatures:

```php
// Runs first; hides rows in-place, returns nothing meaningful.
views_aggregator_row_filter(StylePluginBase $views_plugin_style,
                            FieldHandlerInterface $field_handler, ?string $regexp = NULL)

// Builds and returns the $groups array all other functions consume.
views_aggregator_group_and_compress(array $view_results,
                            FieldHandlerInterface $field_handler,
                            string $case = 'case-sensitive'): array
```

Set `'is_renderable' => FALSE` in the definition when the result is not a single value the
field's normal renderer can format (e.g. enumerations, counts, labels).

## Useful public methods on the Table style plugin

| Method | Purpose |
|---|---|
| `getCell(FieldHandlerInterface $fh, int $row_num, bool $render = FALSE): string` | Read a cell's (optionally rendered) value. |
| `setCell(FieldHandlerInterface $fh, int $row_num, $new_values, string $separator)` | Write a computed value back into a cell. |
| `getFormats(): array` | Number/format info per field. |
| `isRenderable(string $field_name, bool $is_column = FALSE): bool` | Whether the chosen function keeps the renderer. |
| `buildSortPost()` | Post-render click-sort handling. |

The plugin also provides a `views_aggregator_plugin_style_table` theme hook
(`views_aggregator.theme.inc`) and templates
`views-aggregator-plugin-style-table.html.twig` / `views-aggregator-results-table.html.twig`.
