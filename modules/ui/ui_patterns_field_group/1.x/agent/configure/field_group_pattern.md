<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a field group to render as a pattern

There is **no settings page** for this module. A field group is switched to pattern rendering per
entity **view display**, in Manage display (`admin/structure/types/manage/<bundle>/display`):

1. Field Group creates the group (Add group). Add the fields you want into it and **save the display
   once** — the pattern config is only reachable after the group has children saved (otherwise the
   formatter shows: *"you have to add fields to this field group and save the whole entity display
   before being able to access the pattern display configuration."*).
2. Set the group's **Format** to **Pattern** (`format_type: pattern_formatter`).
3. In the group's settings gear: pick a **Pattern**, an optional **Variant**, then map each child
   (field, nested group, or the group **label**) to a pattern **slot/field**.

## Where it is stored

Under the view display's `third_party_settings.field_group.<group_name>`:

| Key | Type | Meaning |
| --- | --- | --- |
| `format_type` | string | `pattern_formatter` selects this module. |
| `format_settings.label` | string | Group label. |
| `format_settings.pattern` | string | Pattern (UI Patterns pattern id) to render the group. |
| `format_settings.pattern_variant` | string | Optional pattern variant id. |
| `format_settings.pattern_mapping` | sequence | Field → slot mapping (see below). |
| `format_settings.show_empty_fields` | boolean | Schema-defined toggle for rendering empty fields. |

`pattern_mapping` uses UI Patterns' `ui_patterns.pattern_mapping` type — a sequence whose keys look
like `<plugin>:<source>` and whose values carry:

| Mapping key | Meaning |
| --- | --- |
| `plugin` | Source plugin id: `fields` (a field), `fieldgroup` (a nested group / the `_label` source), etc. |
| `source` | Source identifier (field machine name, nested group name, or `_label`). |
| `destination` | Target slot/field area in the pattern. |
| `weight` | Order within the destination. |

## Config schema

`config/schema/ui_patterns_field_group.schema.yml` declares
`field_group.field_group_formatter_plugin.pattern_formatter` (extends
`field_group.field_group_formatter_plugin.base`) with `pattern`, `pattern_variant`, `pattern_mapping`,
`show_empty_fields`.

## Real example (from the module's test fixture)

```yaml
# core.entity_view_display.node.article.default.yml
third_party_settings:
  field_group:
    group_pattern_group:
      children:
        - field_text
      format_type: pattern_formatter
      format_settings:
        label: 'Pattern group'
        pattern: metadata
        pattern_variant: first
        pattern_mapping:
          'fields:field_text':
            plugin: fields
            source: field_text
            destination: field_1
            weight: 0
```

## Set it in PHP / at deploy time

Field groups themselves are owned by the Field Group module; you only set the format on the group:

```php
$display = \Drupal::service('entity_display.repository')
  ->getViewDisplay('node', 'article', 'default');
$group = $display->getThirdPartySetting('field_group', 'group_pattern_group');
$group['format_type'] = 'pattern_formatter';
$group['format_settings'] = [
  'label' => 'Pattern group',
  'pattern' => 'metadata',
  'pattern_variant' => 'first',
  'pattern_mapping' => [
    'fields:field_text' => [
      'plugin' => 'fields',
      'source' => 'field_text',
      'destination' => 'field_1',
      'weight' => 0,
    ],
  ],
];
$display->setThirdPartySetting('field_group', 'group_pattern_group', $group);
$display->save();
```

The whole mapping exports with the view display config, so it moves between environments via normal
config sync.
