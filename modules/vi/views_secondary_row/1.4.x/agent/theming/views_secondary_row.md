<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming — templates, theme hooks, and the row-doubling preprocess

The module registers two theme hooks in `views_secondary_row_theme()` (`views_secondary_row.module`),
both backed by `views_secondary_row.theme.inc`:

| Theme hook | Template | Preprocess | Purpose |
|---|---|---|---|
| `views_secondary_row_view_table` | `templates/views-secondary-row-view-table.html.twig` | `template_preprocess_views_secondary_row_view_table()` | The **rendered table** output (front-end). |
| `views_secondary_row_style_plugin_table` | `templates/views-secondary-row-style-plugin-table.html.twig` | `template_preprocess_views_secondary_row_style_plugin_table()` | The **Views-UI settings grid** (adds the 4 extra columns). |

The style plugin declares `theme = "views_secondary_row_view_table"`, so this template renders the
display. It is a near-verbatim copy of core's `views-view-table.html.twig` (same `attributes`,
`header`, `rows.columns`, `caption`, `sticky`, `responsive` variables), so any knowledge of the core
Views table template transfers directly.

## Overriding the output template

Copy `templates/views-secondary-row-view-table.html.twig` into your theme and add a suggestion.
Because it uses the standard Views table variables, the usual template-suggestion patterns apply
(e.g. by view id/display via `hook_theme_suggestions_HOOK_alter()` if you add them). The row loop is
plain:

```twig
{% for row in rows %}
  <tr{{ row.attributes }}>
    {% for key, column in row.columns %}
      <td{{ column.attributes.addClass(column_classes) }}>
        {% for content in column.content %}
          {{ content.separator }}{{ content.field_output }}
        {% endfor %}
      </td>
    {% endfor %}
  </tr>
{% endfor %}
```

## How the preprocess builds the two rows

`template_preprocess_views_secondary_row_view_table()` is a modified copy of core's table preprocess.
Key differences from core:

- **Row doubling.** For source result index `$num`, the primary row is written at index `$num * 2`
  and the secondary row at `$num * 2 + 1`. A field with `info[FIELD][break2]` set is written into the
  **secondary** (odd) row under the target column named by `break2`; otherwise into the primary row.
  After building, `ksort()` restores order so each primary row is immediately followed by its
  secondary row.
- **Header suppression.** Fields whose `break2` is set are skipped when building `header`, so
  secondary-row fields never contribute a column label.
- **Field output.** `$field_output = $handler->getField($old_num, $field)` (Views' rendered,
  pipeline-escaped field value) is wrapped as `['#markup' => $field_output]` — identical to core's
  table preprocess.
- **Rowspan / colspan.** `rowspan1 === 2` adds `rowspan=2` to the primary cell; a non-empty
  `colspan2` adds that `colspan` to the secondary cell.
- **Empty secondary rows.** A secondary row with no content gets
  `class="views-secondary-row--no-content hidden"` (the module's only bespoke CSS classes — style
  them or rely on core's `hidden` utility).
- **Column reordering.** Secondary-row columns are re-ordered to match the configured column order,
  since fields may land there out of sequence.

Inherited unchanged from core: `active`/`order` click-sort links, per-field `align`, responsive
priority classes (attaches `core/drupal.tableresponsive`), sticky header (attaches
`core/drupal.tableheader`), caption/summary/description, and the `empty_table` empty-text row.

## The settings-grid template

`template_preprocess_views_secondary_row_style_plugin_table()` is a copy of core's
`template_preprocess_views_ui_style_plugin_table()` with four extra header cells and four extra body
cells inserted (1st row Rowspan, Secondary row, 2nd row Separator, 2nd row Colspan) and the "None"
row's colspan widened from 6 to 10. You normally never touch this — it only renders inside the Views
UI.

## Accessibility note

Splitting a record across two `<tr>` rows changes the table's row/column semantics, which is exactly
what assistive technology relies on to interpret a data table. The preprocess copies core's header
`id`/`headers` association logic, but a secondary row's cells reference the primary header ids. If the
table conveys data relationships, verify with a screen reader that the `colspan`/header associations
read sensibly, and consider a caption/summary describing the layout.
