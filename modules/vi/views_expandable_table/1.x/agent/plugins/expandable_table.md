<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Style plugin: Expandable Table (`views_view_expandabletable`)

Class `Drupal\views_expandable_table\Plugin\views\style\ExpandableTable`
(`src/Plugin/views/style/ExpandableTable.php`), **extends core
`Drupal\views\Plugin\views\style\Table`**. Annotation: `id = "views_view_expandabletable"`,
`title = "Expandable Table"`, `help = "Displays rows in an expandable table."`,
`theme = "views_view_expandabletable"`, `display_types = {"normal"}`.

Because it extends the core Table style, it inherits every core table setting (per-column sorting,
sticky header, grouping field, override, caption/summary, empty-table text, responsive priorities).
It adds the expand/collapse behavior and three extra options.

## Enable & select

1. `drush en views_expandable_table` (or Extend UI). Only dependency is core `views`.
2. Edit a View → the display's **Format → Style** → choose **"Expandable Table"** → *Apply*.
3. In the style settings, order fields so the content that should collapse is the **last column**.
   At render time the last column is removed from the normal row and shown as the expandable detail
   row; the last header cell is also dropped.

There is no admin page and no permission — configuration is entirely per view display, stored in the
view's own config (`views.view.*`). The module ships **no `config/schema`**; option values are
booleans/enumerated strings persisted with the view.

## Options (over core Table)

Defined in `defineOptions()` and exposed in `buildOptionsForm()`:

| Option | Type | Default | Effect |
| --- | --- | --- | --- |
| `triggerable_row` | checkbox | `TRUE` | If checked, the **entire row** is the click target. If unchecked, a small toggle `<span>` is appended to a chosen column instead. |
| `toggle_location` | select `first` \| `last` | `last` | (Only when `triggerable_row` is off) which visible column receives the toggle element. |
| `element_location` | select `before` \| `after` | `after` | (Only when `triggerable_row` is off) whether the toggle element is placed before or after the cell's existing content. |

`toggle_location` / `element_location` are shown via `#states` only when `triggerable_row` is
unchecked. All three are constrained inputs (a checkbox and two fixed-option selects) — no free text.

## Render / attach

`render()`:
```php
$build = parent::render();
$build['#attached']['library'][] = 'views_expandable_table/expandable_table';
$build['#attached']['drupalSettings']['views_expandable_table']['triggerable_row'] = $this->options['triggerable_row'];
return $build;
```
Library `views_expandable_table/expandable_table` (`views_expandable_table.libraries.yml`) pulls
`css/views_expandable_table.css`, `js/views_expandable_table.js`, and deps `core/jquery`,
`core/drupal`, `core/once`.

## Preprocess mechanism

`template_preprocess_views_view_expandabletable(&$variables)` in `views_expandable_table.module`:

1. Calls core `template_preprocess_views_view_table($variables)` first (so all standard table vars
   exist), then reads `$options = $view->style_plugin->options`.
2. Per row:
   - **Triggerable row on**: generate `$id = Crypt::randomBytesBase64(12)`; add class
     `views-expandable-table-trigger` and attribute `data-views-expandable-table-trigger=$id` to the
     row.
   - **Triggerable row off**: pick the target column via
     `array_slice($row['columns'], first?0:-2, 1)`; if it is `views_bulk_operations_bulk_form`, shift
     to the next column (avoids crowding the VBO checkbox). Add a `data-views-expandable-table-target`
     attribute + a `<span class="views-expandable-table-trigger">&nbsp;</span>` render element,
     unshifted (before) or appended (after) per `element_location`.
   - `array_pop($row['columns'])` → `expandable_row.column`; give `expandable_row.attributes` class
     `views-expandable-table-target` + `data-views-expandable-table-target=$id`; set
     `expandable_row.column_attributes` `colspan = count($row['columns'])`.
3. `array_pop($variables['header'])` removes the last header cell; adds `views-expandable-table`
   class to the table.

Twig `templates/views-view-expandabletable.html.twig` is core's table template plus, after each data
row, an extra `<tr{{ row.expandable_row.attributes }}><td{{ row.expandable_row.column_attributes }}>`
holding the popped column's `content`. The detail cell renders the **same `content.field_output`**
render arrays Views built — no re-fetching, no access re-implementation.

## Frontend / JS

`js/views_expandable_table.js` (`Drupal.behaviors.viewsExpandableTable`, guarded by `once`):
- Reads `settings.views_expandable_table.triggerable_row` to pick the trigger elements
  (`tr[data-views-expandable-table-trigger]` vs `span.views-expandable-table-trigger`).
- On click, `toggleExpanded()` toggles the `expanded` class on both trigger and target rows.
  `stopPropagation` on inner `a`, `btn`, `input` so links/controls inside a trigger row don't toggle.
- Hover syncing adds `views-expandable-table-hover` to both rows.

CSS (`css/views_expandable_table.css`) hides
`html.js table.views-expandable-table tr[data-views-expandable-table-target]:not(.expanded)` and
shows the up/down arrow icons from `img/`. Theming hooks: target
`tr[data-views-expandable-table-trigger]`, `tr[data-views-expandable-table-target]`, and the
`expanded` / `views-expandable-table-hover` classes. Because the detail row is a real `<tr>` in the
DOM, adjust zebra-stripe CSS accordingly.

## Notes

- No config schema ships, so `config inspect` / schema validation will report the three style options
  as untyped; they still save with the view.
- In the non-triggerable branch the target column gets `addClass('data-views-expandable-table-trigger')`
  (a class literally named like a data attribute) plus the real `data-views-expandable-table-target`
  attribute — cosmetic/legacy, harmless.
