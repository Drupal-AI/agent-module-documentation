<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Icon field: type `list_icon`, widgets, formatter

The module ships a field type so any fieldable entity can store an icon choice. The stored scalar is
the icon id string `"<icon_set_id>:<icon_name>"` (or `''`).

## Field type — `list_icon`

`Drupal\icons\Plugin\Field\FieldType\ListIconItem` extends core `options`'s `ListStringItem`.

| Aspect | Value |
|---|---|
| id / label | `list_icon` / "List (icon)" |
| category | `icons` (registered by `icons.field_type_categories.yml`) |
| default widget | `icon_select_widget` |
| default formatter | `list_icon` |
| value property | `value` (string, max length 255, required) |

The allowed values are **not** a static list: `getSettableOptions()` returns
`icons.manager::getIconOptions()`, i.e. every icon across all Icon Sets (grouped by set label when
more than one set exists). The storage-settings form hides the core "Allowed values list"
(`allowed_values['#access'] = FALSE`); schema key `field.storage_settings.list_icon` keeps only
`allowed_values_function`.

## Widgets

| Widget id | Class | Notes |
|---|---|---|
| `icon_select_widget` | `IconSelectWidget` (extends `OptionsSelectWidget`) | Default. Renders the `icon_select` element (styled dropdown showing the icon glyphs). `multiple_values: TRUE`. |
| `font_icon_picker` | `FontIconPickerWidget` (submodule `icons_iconpicker`) | jQuery **fontIconPicker** search-and-select. Setting: `icon_picker_theme` (`grey`/`darkgrey`/`bootstrap`/`inverted`, default `grey`). Renders `#type => 'font_icon_picker'`. Requires the fontIconPicker JS library installed under `/libraries`. |

Both widgets source options from `icons.manager::getIconOptions()`.

## Formatter — `list_icon`

`Drupal\icons\Plugin\Field\FieldFormatter\IconFormatter` (label "Icon"). For each non-empty item it
returns `Icon::buildRenderArray($item->value)` — i.e. a `#type => 'icon'` element that resolves the
`set:name` value to CSS classes at render time. No formatter settings.

## Add the field in code

```php
FieldStorageConfig::create([
  'entity_type' => 'node', 'field_name' => 'field_icon', 'type' => 'list_icon',
])->save();
FieldConfig::create([
  'entity_type' => 'node', 'bundle' => 'page', 'field_name' => 'field_icon', 'label' => 'Icon',
])->save();
// Form display: use widget 'icon_select_widget' (or 'font_icon_picker').
// View display: use formatter 'list_icon'.
```
