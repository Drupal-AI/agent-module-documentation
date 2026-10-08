<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Serializable fields & export formatters

There is no admin settings page (`configure` is null). You configure everything inside a
**REST Export** view display.

## The serializable field handler

For every field that has the core Views `field` handler, REST Views' `hook_views_data_alter()`
adds a parallel handler labelled **"<field> (serializable)"**, exposed in Views data as
`<field>_export`, with `plugin_id: field_export` (class `EntityFieldExport`). In the Views UI,
when you *Add field*, pick the **(serializable)** variant. It:

- wraps the value in a `SerializedData` object so serialization gets real data, not a string;
- automatically exports multi-value fields as **arrays** (based on field cardinality, even if
  only one value is present);
- returns `[]` (multi) or `null` (single) for empty fields.

In the view display config a serializable field looks like:

```yaml
display_options:
  fields:
    field_tags:
      id: field_tags
      table: node__field_tags
      field: field_tags
      plugin_id: field_export        # <-- the serializable handler
      type: entity_reference_export  # <-- an export formatter (below)
      entity_type: node
      entity_field: field_tags
```

## Export field formatters

These emit non-string JSON and **only work with the `field_export` handler**:

| Formatter id | Field types | Output |
|---|---|---|
| `boolean_export` | boolean | real JSON `true`/`false` |
| `number_export` | integer/decimal/float | JSON number |
| `entity_reference_export` | entity_reference | nested entity structure; setting `extra` = list of extra metadata keys |
| `entity_reference_entity_id_export` | entity_reference | just the target entity id |
| `entity_path` | entity_reference | the referenced entity's path/URL; setting `absolute` (bool) |
| `file_export` | file | structured file data |
| `image_export` | image | structured image data; settings `export_alt`, `export_title` (bools) |
| `link_export` | link | uri + title object |
| `list_export` | list_* | raw allowed values |

Config schema for the settings lives in `config/schema/rest_views.schema.yml`
(`field.formatter.settings.image_export`, `…entity_reference_export`, `…entity_path`).

## Set a serializable field in code

```php
use Drupal\views\Entity\View;
$view = View::load('my_feed');
$display = $view->get('display');
$display['default']['display_options']['fields']['nid'] = [
  'id' => 'nid', 'table' => 'node_field_data', 'field' => 'nid',
  'plugin_id' => 'field_export', 'type' => 'number_export',
  'entity_type' => 'node', 'entity_field' => 'nid',
];
$view->set('display', $display)->save();
```

## Nested references

`entity_reference_export` gives a nested structure, but for deep/nested paragraph or
entity-reference-revisions data you generally need a dedicated **display mode** whose fields
themselves use export formatters (see the project's issue links), plus the
`rest_views_revisions` submodule for entity reference revisions.
