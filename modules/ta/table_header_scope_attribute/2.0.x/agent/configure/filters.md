<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable the filters on a text format

No settings page and no `configure` route. You enable the two `filter` plugins on whichever
text format(s) render your table content (Basic HTML, Full HTML, …).

## The two filters

| Filter id | Title | Effect |
|---|---|---|
| `table_header_scope_attribute` | Set scope attribute for table headers | adds `scope="col/row/colgroup/rowgroup"` to `<th>` |
| `table_header_scope_attribute_empty_th_to_td` | Transform empty table header to table data | replaces empty `<th>` with `<td>` |

Both are `TYPE_TRANSFORM_IRREVERSIBLE`.

## UI

1. *Administration → Configuration → Content authoring → Text formats and editors*
   (`/admin/config/content/formats`), edit a format (e.g. Basic HTML).
2. Enable **both** checkboxes.
3. In *Filter processing order*, place **"Set scope attribute for table headers" before
   "Transform empty table header to table data"**, and keep both **below** "Limit allowed HTML
   tags and correct faulty HTML".
4. Save. The add/edit form has a custom validation that raises an error if the empty-to-td
   filter's weight is ≤ the scope filter's weight while both are enabled — so a wrong order is
   rejected on save.

Why the order: if empty `<th>` were converted to `<td>` first, the scope filter would then see
fewer/incorrect headers and scope the remaining ones wrongly.

## Where it is stored / drush

Config entity `filter.format.<format_id>`:

```yaml
filters:
  table_header_scope_attribute:
    status: true
    weight: 10
  table_header_scope_attribute_empty_th_to_td:
    status: true
    weight: 11        # must be > the scope filter's weight
```

Read back: `drush cget filter.format.basic_html filters.table_header_scope_attribute`.

Enable programmatically:

```php
$format = \Drupal\filter\Entity\FilterFormat::load('basic_html');
$format->setFilterConfig('table_header_scope_attribute', ['status' => TRUE, 'weight' => 10]);
$format->setFilterConfig('table_header_scope_attribute_empty_th_to_td', ['status' => TRUE, 'weight' => 11]);
$format->save();
```

Neither filter has any per-filter settings — enabling (status) and weight (order) are all there is.
