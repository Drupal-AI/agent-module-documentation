<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin internals

The module ships a Views **row plugin** and the language renderers that do the actual view-mode
switching. It does **not** define a new plugin *type*/manager — it plugs into Views' existing
`views_row` plugin type.

## Derivative row plugin

`src/Plugin/views/row/EntityRow.php` (`@ViewsRow id="views_parity_row_entity"`,
`deriver=ViewsParityRowEntityRow`) extends core `\Drupal\views\Plugin\views\row\EntityRow`.

`src/Plugin/Derivative/ViewsParityRowEntityRow.php` creates one derivative **per entity type** that
`($entity_type->getBaseTable())` has Views data and a `view_builder` handler. Each derivative:

- id: `views_parity_row_entity:<entity_type_id>`
- title: `"<Entity label> (alternate)"`, base table = data table (or base table)
- reuses the base plugin class.

So on a node view you pick `views_parity_row_entity:node`; on a media view, `…:media`, etc.

## Options (`defineOptions`)

```php
$options['views_parity_row_enable'] = ['default' => FALSE];
$options['views_parity_row']['contains']['frequency'] = ['default' => 2];
$options['views_parity_row']['contains']['start']     = ['default' => 0];
$options['views_parity_row']['contains']['end']       = ['default' => 0];
$options['views_parity_row']['contains']['view_mode'] = ['default' => 'default'];
$options['views_parity_row_per_row_enable'] = ['default' => FALSE];
// per-row: view_mode_1 .. view_mode_20 (built in buildOptionsForm)
```

The `view_mode` select lists come from `entityDisplayRepository->getViewModeOptions($this->entityTypeId)`.

## The cadence math (`RendererBase::preRender`)

The switching lives in `src/Plugin/views/Entity/Render/RendererBase::preRender()` (an override of core's
language renderer base; concrete subclasses are `CurrentLanguageRenderer`, `DefaultLanguageRenderer`,
`TranslationLanguageRenderer`, `ConfigurableLanguageRenderer`, chosen by the view's rendering language).
For each result row:

```php
$view_mode = $options['view_mode'];                       // primary
$current_item = $previous_pages_item_count + $row->index; // pager-aware, 0-based

if ($options['views_parity_row_enable']) {
  $override = FALSE;
  if ($current_item >= $options['views_parity_row']['start']) {
    if ($options['views_parity_row']['end'] !== '0') {
      if ($current_item < $options['views_parity_row']['end']) { $override = TRUE; }
    } else { $override = TRUE; }                            // end=0 => no upper bound
  }
  if ($override && ($current_item - $start) % $frequency === 0) {
    $view_mode = $options['views_parity_row']['view_mode']; // alternate
  }
}

// per-row wins if set for this (1-based) row:
if ($options['views_parity_row_per_row_enable']
    && !empty($options['views_parity_row_per_row']['view_mode_' . ($current_item + 1)])) {
  $view_mode = $options['views_parity_row_per_row']['view_mode_' . ($current_item + 1)];
}

$this->build[$entity->id()] = $view_builder->view($entity, $view_mode, $this->getLangcode($row));
```

Consequences an agent should know:
- `$current_item` includes `pager->getCurrentPage() * itemsPerPage`, so the cadence **continues across
  paginated pages** rather than restarting each page.
- The alternate fires when `(current_item - start)` is an exact multiple of `frequency` — with
  `start = 0`, that means rows 0, `frequency`, `2*frequency`, … (i.e. the 1st, then every Nth).
- `end` is treated as a **string**; `end === '0'` disables the upper bound. A non-zero `end` stops the
  alternation at that (exclusive) 0-based index.
- **Per-row overrides cadence** for any row 1–20 that has a non-empty `view_mode_<n>`.
- Rendering delegates to the entity `view_builder->view($entity, $view_mode, $langcode)`, so the
  alternate "look" is entirely whatever that view mode's display is configured to show.

## Extending

To customize selection logic, subclass `EntityRow` (or the renderer) in your own module and register a
row plugin; there is no service to decorate and no dedicated plugin manager to extend.
