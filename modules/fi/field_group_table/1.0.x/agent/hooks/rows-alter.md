<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# hook_field_group_table_rows_alter()

The only hook the module invites (`field_group_table.api.php`). It runs in the formatter's
`preRender()` (via `moduleHandler->alter('field_group_table_rows', $element, $children)`) **before**
the rows are built, letting you add or remove rows — commonly to drop empty multivalue rows.

```php
/**
 * Implements hook_field_group_table_rows_alter().
 *
 * @param array &$element
 *   Render array for the field group. Each child key is a field to become a row.
 * @param array &$children
 *   The keys of the render children of $element (from Element::children()).
 */
function mymodule_field_group_table_rows_alter(array &$element, array &$children) {
  // Only operate on the "view" display context.
  if ($element['#mode'] != 'view') {
    return;
  }

  $render_api_properties = ['#theme', '#markup', '#prefix', '#suffix'];

  foreach ($children as $index => $child) {
    // Treat a multivalue field whose first delta has no render API code as empty.
    if (isset($element[$child][0]) && !array_intersect($render_api_properties, array_keys($element[$child][0]))) {
      unset($children[$index]);   // remove from the child list
      unset($element[$child]);    // and from the render array
    }
  }
}
```

Rules:
- **To remove a row you must unset the key in BOTH `$children` and `$element`.**
- `$element['#mode']` is the display context (`'view'` or `'form'`) — gate your logic on it.
- The module itself already decides "emptiness" for normal rows via its `renderApiProperties`
  list (`#theme`, `#markup`, `#prefix`, `#suffix`, `#type`, `widget`); use this hook for cases
  it can't detect (e.g. per-delta emptiness of multivalue fields, or injecting computed rows).

No other hooks, events, or services are provided.
