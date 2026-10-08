<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add a "Table" field group and its settings

There is no module settings page. You add a **Field Group** group and choose format **Table**
(`field_group_table`) on a *Manage display* / *Manage form display* page.

## UI

1. Go to the bundle's *Manage display* (view) or *Manage form display* (form), e.g.
   `/admin/structure/types/manage/article/display`.
2. **Add field group** (a Field Group UI button), give it a label + machine name.
3. Set its **Format** to **Table**.
4. Drag the fields you want into the group; **Save**.
5. Click the group's cog to set the Table format settings (below).

## Where it is stored

Field Group writes groups into the display config's third-party settings:

```yaml
# core.entity_view_display.node.article.default  (or core.entity_form_display.* for forms)
third_party_settings:
  field_group:
    group_specs:                     # <group_name>
      children: [field_sku, field_weight]
      parent_name: ''
      weight: 10
      region: content
      label: 'Specifications'
      format_type: field_group_table    # <-- this module
      format_settings:
        first_column: 'Property'
        second_column: 'Value'
        label_visibility: 2
        table_row_striping: true
        # ...see settings below
```

## Format settings (`format_settings` keys)

| Key | Values | Meaning |
|---|---|---|
| `label_visibility` | 1 hidden, 2 above table, 3 `<caption>`, 4 below table | how the group label shows |
| `desc` | string | description text for the group |
| `desc_visibility` | 1 hidden, 2 above, 4 below | where the description shows |
| `first_column` | string | first column header text (header row only shows if either column set) |
| `second_column` | string | second column header text |
| `empty_label_behavior` | 1 keep empty label cell, 2 merge (colspan=2) | rows with no label |
| `table_row_striping` | bool | zebra striping (sets `no_striping` inverse per row) |
| `always_show_field_label` | bool | force the field label into column 1 for every row |
| `always_show_field_value` | bool | render a row even when the field is empty |
| `empty_field_placeholder` | string | text shown for an empty field (needs `always_show_field_value`) |
| `hide_table_if_empty` | bool | output no markup at all when there are no value rows |

Plus the inherited Field Group formatter settings (`classes`, `id`, `label`) from
`FieldGroupFormatterBase`. The constants live on the plugin class:
`DISPLAY_HIDDEN=1`, `DISPLAY_ABOVE=2`, `DISPLAY_CAPTION=3`, `DISPLAY_BELOW=4`;
`EMPTY_LABEL_KEEP=1`, `EMPTY_LABEL_MERGE=2`.

## Scriptable (drush php:eval)

```php
$d = \Drupal::service('entity_display.repository')->getViewDisplay('node','article','default');
$d->setThirdPartySetting('field_group', 'group_specs', [
  'children' => ['body'],
  'parent_name' => '', 'weight' => 10, 'region' => 'content',
  'label' => 'Specifications',
  'format_type' => 'field_group_table',
  'format_settings' => ['first_column' => 'Property', 'second_column' => 'Value', 'label_visibility' => 2],
]);
$d->save();
```

Read back: `drush cget core.entity_view_display.node.article.default third_party_settings.field_group`.

## Row output

Each child field becomes a table row: a header (`<th>`) label cell + a value cell. In **view**
context, when the field label display is "Above" (or *always show field label* is on) the label
goes in column one and the module hides the in-value label; otherwise the value cell can span
both columns (per `empty_label_behavior`). The table gets classes `field-group-table`, the group
name, `table`, and an `<entity_type>-<bundle>-<mode>` class.
