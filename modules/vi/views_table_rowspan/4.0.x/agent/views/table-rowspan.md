<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views style: Table Rowspan

The module's entire surface. A Views style plugin that renders a table like the core table
style, then merges repeated cells in a **grouped** column into a single cell with an HTML
`rowspan`, and hides the duplicates.

- Plugin id: `table_rowspan`
- Class: `Drupal\views_table_rowspan\Plugin\views\style\TableRowSpan` (extends
  `Drupal\views\Plugin\views\style\Table`)
- Annotation: `title = "Table Rowspan"`, `theme = "views_view_table"`, `display_types = {"normal"}`
- Reuses the core table template `views-view-table.html.twig` (no custom template).

## Configure in the UI

1. Create/edit a view that shows **fields** (not entities).
2. Format → **Table Rowspan**.
3. Add the fields to display.
4. In the style settings, set **Grouping field Nr.1** (and Nr.2, … for nested groups) to the
   field whose repeated values should be merged — this is the core Table `grouping` option.
5. Enable **Merge rows in table** (the `rowspan` checkbox, on by default).

Because merging follows the `grouping` option, adjacency is handled by Views' grouping (it
collects rows with the same group value into one set). No grouping ⇒ nothing merges and it
renders as an ordinary table.

## Style options

| Option | Type | Default | Notes |
|--------|------|---------|-------|
| `rowspan` | boolean | `TRUE` | Checkbox "Merge rows in table". When on **and** `grouping` is set, cells merge. |
| `grouping` | array (inherited from core Table) | — | List of `{field, rendered, rendered_strip}` levels; the grouped field(s) are what merge. |
| all other core Table options | — | — | `columns`, `default`, `info`, `sticky`, `caption`, `summary`, `empty_table`, responsive/`description`, etc. inherited unchanged. |

The module ships **no config schema**; `rowspan` piggybacks on the view config that core Views
already stores for style options. Configuration is per view display — there is no global
settings form or config object.

### As stored in the view config (YAML)

```yaml
display:
  default:
    display_options:
      style:
        type: table_rowspan
        options:
          grouping:
            - field: field_category
              rendered: true
              rendered_strip: false
          rowspan: true
          columns: { ... }        # core Table columns map
          default: '-1'
          # …remaining core Table options…
```

Set via PHP by editing the view entity's display style options:

```php
$view = \Drupal::entityTypeManager()->getStorage('view')->load('my_view');
$display = &$view->getDisplay('default');
$display['display_options']['style']['type'] = 'table_rowspan';
$display['display_options']['style']['options']['rowspan'] = TRUE;
$display['display_options']['style']['options']['grouping'] = [
  ['field' => 'field_category', 'rendered' => TRUE, 'rendered_strip' => FALSE],
];
$view->save();
```

## How it works at runtime

1. `defineOptions()` adds `rowspan` (default `TRUE`) to the core Table options.
2. `buildOptionsForm()` adds the `rowspan` checkbox to the standard table options form.
3. `renderGroupingSets($sets)` — when `grouping` **and** `rowspan` are both set: it flattens the
   grouped sets into a single flat list of leaf rows via `getColSpanRows()`, wraps them in one
   group (`group => ''`), then **clears `$this->options['grouping']`** before calling
   `parent::renderGroupingSets()`, so core does not emit group headers/subtables — one table, one
   header row. `getColSpanRows()` recurses the sets, and for each group records
   `$this->view->rowspan[$group_field_name][$first_row_index] = [row indices in the group]`
   (`getDeepestRows()` collects the leaf rows of nested groups). Multiple grouping levels each
   contribute their own field entry.
4. `views_table_rowspan_preprocess_views_view_table(&$vars)` reads `$view->rowspan` and rewrites
   the rendered cell attributes:
   - First cell of each group: `rowspan = count(group rows)` and CSS class **`cell-rowspan`**.
   - Every duplicate cell below it: inline `style="display:none"` (kept in the DOM but hidden).
   - If a targeted cell has no attributes object, that column entry is `unset()` instead.

Cell **values are rendered by the normal Views field pipeline** (core Table's `render()`), so
they are already escaped/sanitized before this plugin touches only their wrapper attributes; the
module adds no raw output of its own.

## Theming

No CSS or library is shipped. The merged cell carries class `cell-rowspan` (target it for
borders/vertical-align); hidden duplicates use inline `display:none`. Style them in your theme.
Note that `rowspan` changes how assistive tech maps cells to headers — verify meaningful merged
tables read correctly.
