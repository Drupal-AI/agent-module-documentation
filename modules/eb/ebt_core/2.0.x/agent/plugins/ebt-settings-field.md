<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `ebt_settings` field (type, widgets, formatter)

EBT Core defines a Field API field for storing a block's **design options**. These are plugins
supplied by the module (not a new plugin *type* — they are ordinary Field API plugins).

## Field type: `ebt_settings`

`EbtSettingsItem` (`@FieldType(id = "ebt_settings", label = "EBT Settings")`):

- Stores a single serialized `ebt_settings` map column (`type: blob`, `serialize: TRUE`,
  `size: big`) — a `MapDataDefinition` property.
- `default_widget = ebt_settings_default`, `default_formatter = ebt_settings_default`.
- `mainPropertyName()` is `NULL` (map item); `isEmpty()` true when the map is NULL/empty.

The saved structure is roughly:

```php
[
  'ebt_settings' => [
    'pass_options_to_javascript' => FALSE,
    'design_options' => [
      'box1' => ['margin_top' => '', 'margin_right' => '', 'margin_bottom' => '', 'margin_left' => '',
        'box2' => ['border_top' => '', ...,
          'box3' => ['padding_top' => '', ...]]],
      'other_settings' => [
        'border_color' => '', 'border_style' => '', 'border_radius' => '',
        'background_color' => '', 'background_media' => '', 'background_image_style' => '',
        'edge_to_edge' => 0, 'container_width' => '',
      ],
    ],
  ],
]
```

(see `field.value.ebt_settings` in `config/schema/ebt_core.schema.yml` for the full mapping.)

## Widgets

- `ebt_settings_default` (`EbtSettingsDefaultWidget`, label "EBT default block settings") — the
  full design-options UI: box-model margin/border/padding, border color/style/radius,
  background color (with color picker), background media (image/video via Media Library Form
  Element), background image style, edge-to-edge, container width. Attaches libraries
  `ebt_core/colorpicker`, `ebt_core/ebt_settings`, and Field Group horizontal tabs. Includes a
  static `validateColorElement()` (HEX validation) reused by the settings form.
- `ebt_settings_simple` (`EbtSettingsSimpleWidget`, label "EBT simple block settings") — a
  reduced variant.

## Formatter

- `ebt_settings_default` (`EbtSettingsDefaultFormatter`) — renders each item through the
  `ebt_settings_default` theme hook (template `ebt-settings-default.html.twig`) with the
  `ebt_settings` value.

## Shipped field storage

`config/install/field.storage.block_content.field_ebt_settings.yml` installs a
`field_ebt_settings` storage of type `ebt_settings` on `block_content` (cardinality 1). EBT
block-type modules add a `field.field.block_content.<bundle>.field_ebt_settings` instance to
their bundle. To add the design-options field to your own block type, create a
`field_ebt_settings` FieldConfig on that `block_content` bundle and set its form/view display
to the `ebt_settings_default` widget/formatter.

## How the settings render

`hook_preprocess_block` (in `EbtCoreHooks`) reads `field_ebt_settings` for any block whose
bundle starts `ebt_`, then calls `ebt_core.generate_css` / `ebt_core.generate_js` — see
[../api/services-and-hooks.md](../api/services-and-hooks.md).
