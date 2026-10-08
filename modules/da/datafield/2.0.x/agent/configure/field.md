<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a Data Field

There is no admin settings page. A `data_field` is configured in three places on the entity it is
added to: **storage settings** (the sub-columns), **field settings** (per-column labels/limits), and
the **form/view display** components (per-column widget/formatter + wrapping formatter).

## 1. Storage settings — define the sub-columns

`FieldStorageConfig` for a `data_field` holds `settings.columns` as a list of sub-column definitions.
Schema: `field.storage_settings.data_field` → `datafield_storage_subfield_settings`:

| Key | Meaning |
|---|---|
| `name` | machine name of the sub-column (used as DB column `<field>_<name>`) |
| `type` | storage type: `string`, `text`, `json`, `integer`, `float`, `numeric` (decimal), `boolean`, `email`, `telephone`, `uri`, `datetime_iso8601`, `date`, `entity_reference`, `file`, `serial`, `blob` |
| `max_length` | for string types |
| `size` | int size (`normal`/`big`/…) |
| `precision`, `scale` | for `numeric`/decimal |
| `unsigned` | numeric unsigned flag |
| `datetime_type` | `date` / `datetime` etc. for date columns |

Default storage ships one `value` string column (a table needs ≥1 column before it is created).
Cardinality is normally set to unlimited (`-1`) so each entity stores multiple rows.

## 2. Field (instance) settings — per column

Schema `field.field_settings.data_field` → `field_settings` keyed by column, each
`data_field_subfield_settings`: `label`, `list` (limit allowed values) + `allowed_values`,
`max`, `min`, `required`, `on_label`/`off_label` (boolean), `entity_reference_type`,
`target_bundles`, `view_arguments`.

## 3. Form display — widget per column

The field's widget is `data_field_table_widget` (default) or `data_field_widget`. Its settings
(schema `field.widget.settings.data_field_widget`) hold `inline`, `field_reference` (which sub-column
drives the search), and `widget_settings` keyed per column (`data_field_widget_settings`): `type`
(the chosen widget id), `size`, `placeholder`, `label`, `field_display`, `cols`/`rows`, `step`,
`limit`, `autocomplete`, `fill`, `target_type`, `entity_browser`, `preview_image_style`, `weight`.

Available column widgets (`Plugin/DataField/FieldWidget`): text (`textfield`, `textarea`, full-HTML),
`number`/`range`/`number_format`, `select`/`radios`/`options_buttons`/`options_select`, `boolean_checkbox`,
entity reference (`autocomplete`, `autocomplete_tags`, `browser`), `file`/`image`/`media_library`,
date (`date`, `datetime_default`, `month`, `week`, `year`, `time`, `timestamp_datetime`), `color`,
`password`, `path`, `search`, `uri`, `uuid`, `hidden`, `hierarchical_select`.

## 4. View display — wrapping formatter + per-column sub-formatter

Pick one wrapping formatter on *Manage display*:

| Formatter id | Renders as | Notable settings (schema) |
|---|---|---|
| `data_field_table_formatter` | HTML table | `number_column`, `direction`, `mode`, `caption`, `footer_text`, `datatables_options`, `bootstrap_table_options`, plus `formatter_settings` per column |
| `data_field_chart` | Google Chart / Highchart | `mode`, `chart_type`, `chart_width`, `chart_height` |
| `data_field_details` | collapsible `<details>` | `open` |
| `data_field_html_list` | ordered/unordered list | `list_type` |
| `data_field_unformatted_list` | plain list | inline, custom_class |
| `data_field_json_export` | JSON blob | `recursion_level` |

Each column's sub-formatter (`data_field_formatter_subfield_settings`) controls `format_type`,
`format`, `link`, `hidden`, `key`, decimal/thousand separators, `scale`, `prefix_suffix`, `view_mode`
(entity reference), `image_style`/`image_link`, `trim_length`, `twig_template`, `future_format`/
`past_format`/`granularity` (timestamp-ago), `separator`, `wrap`, `reverse`.

## Set a data_field with Drush (sketch)

```php
// drush php:eval
$storage = \Drupal\field\Entity\FieldStorageConfig::create([
  'field_name' => 'field_specs', 'entity_type' => 'node', 'type' => 'data_field',
  'cardinality' => -1,
  'settings' => ['columns' => [
    'label' => ['name' => 'label', 'type' => 'string', 'max_length' => 255],
    'value' => ['name' => 'value', 'type' => 'numeric', 'precision' => 10, 'scale' => 2],
  ]],
]);
$storage->save();
\Drupal\field\Entity\FieldConfig::create([
  'field_storage' => $storage, 'bundle' => 'article', 'label' => 'Specs',
])->save();
```

Then set the widget/formatter components on the `entity_form_display` / `entity_view_display` with
`type => 'data_field_table_widget'` / `'data_field_table_formatter'` and the per-column settings above.

## Inline editing routes

`/datafield/{entity_type}/{entity}/{field_name}/add|{delta}/edit|clone|delete` and
`/datafield/{entity_type}/{entity}/{field_name}/edit` (edit all) are guarded by `_datafield_access`
(`EntityAccessCheck`): requires entity `update` access AND field `edit` access; if `field_permissions`
is enabled it defers to that module's create/edit check.
