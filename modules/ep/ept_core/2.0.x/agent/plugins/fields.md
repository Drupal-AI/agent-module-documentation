<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The EPT Settings field, widgets, formatter, and shared fields

EPT Core defines a field type and the shared fields that EPT paragraph modules attach to their
paragraph bundles. These are standard `@FieldType`/`@FieldWidget`/`@FieldFormatter` plugins.

## Field type `ept_settings`

`EptSettingsItem` (`@FieldType id = "ept_settings"`, label "EPT Settings",
`default_widget = ept_settings_default`, `default_formatter = ept_settings_default`). Stores a
structured `ept_settings` value — the per-paragraph **design options** (see the schema
`field.value.ept_settings`):

- `pass_options_to_javascript` (bool)
- `design_options`:
  - `box1` margins (top/right/bottom/left) → `box2` borders → `box3` paddings (nested boxes)
  - `other_settings`: `border_color`, `border_style`, `border_radius`, `background_color`,
    `background_media`, `background_image_style`, `edge_to_edge` (int), `container_width`

## Widgets

| Widget id | Class | Use |
|---|---|---|
| `ept_settings_default` | `EptSettingsDefaultWidget` | Full design-options UI (boxes, colours, background media, colorpicker) — the default |
| `ept_settings_simple` | `EptSettingsSimpleWidget` | Reduced widget for simpler paragraph types |

Formatter: `ept_settings_default` (`EptSettingsDefaultFormatter`) renders the settings into the
paragraph (via the generated CSS/JS), template `templates/ept-settings-default.html.twig`.

## Shared paragraph field storages (installed by EPT Core)

Entity type `paragraph`, cardinality 1:

- `field_ept_settings` — type `ept_settings` (the design-options field)
- `field_ept_text` — the shared body/text field
- `field_ept_title` — the shared title field

An EPT paragraph module (or a Starterkit-generated one) creates a `paragraphs_type` and adds
**field instances** (`field.field.paragraph.<bundle>.field_ept_*`) pointing at these storages,
plus form/view displays that place `field_ept_settings` with the `ept_settings_default` widget.

## Attach EPT Settings to an existing paragraph type

```php
use Drupal\field\Entity\FieldConfig;
FieldConfig::create([
  'field_name' => 'field_ept_settings',
  'entity_type' => 'paragraph',
  'bundle' => 'my_paragraph_bundle',
  'label' => 'EPT Settings',
])->save();
// then set the widget on the form display to ept_settings_default
```
