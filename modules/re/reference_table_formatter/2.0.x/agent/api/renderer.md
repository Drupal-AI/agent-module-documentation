# Reference Table Formatter — the renderer service

Service id `reference_table_formatter.renderer` → `Drupal\reference_table_formatter\EntityToTableRenderer`
(implements `EntityToTableRendererInterface`). Constructor args: `@entity_type.manager`, `@renderer`,
`@entity_display.repository`. Use it to build the same table the formatter produces from your own code.

## Method

```php
public function getTable(
  string $type,      // target entity type id, e.g. 'node', 'paragraph'
  string $bundle,    // target bundle (falsy → falls back to $type for bundle-less types)
  array $entities,   // loaded target entities (the rows)
  array $settings    // ['view_mode' => ..., 'show_entity_label' => bool,
                     //  'hide_header' => bool, 'empty_cell_value' => string]
): array;            // a #theme => 'table' render array with cache metadata applied
```

Behaviour:
- Renders every entity via the `entity_view_display` for `type.bundle.view_mode` (or the bundle's
  `default` display if that view mode has no config), then keeps only display-configurable field
  content and sorts by weight.
- Columns are the union of all rows' fields (`getTableColumns()`); each rendered field cell has its
  label hidden. Missing cells get `settings['empty_cell_value']`.
- Adds each entity — and each entity's `view` access result — as a cacheable dependency, so the table
  invalidates correctly.

Example:

```php
$renderer = \Drupal::service('reference_table_formatter.renderer');
$build = $renderer->getTable('paragraph', 'spec_row', $paragraphs, [
  'view_mode' => 'default',
  'show_entity_label' => FALSE,
  'hide_header' => FALSE,
  'empty_cell_value' => '—',
]);
```

Note: `getTable()` itself does not filter by access — pass entities the user may view (the formatter's
`FormatterBase::getEntitiesToView()` does that filtering before calling it).
