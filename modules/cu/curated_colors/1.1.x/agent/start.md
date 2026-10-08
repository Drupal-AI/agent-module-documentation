<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Curated Colors (curated_colors) — agent index

Reusable, exportable **color palettes** plus a **`curated_color` field type** whose value is a
palette color *key*. Ships a swatch-picker widget, two formatters, a standalone Form API picker
element, a palette resolver service with a mutation event, and optional **Drupal Canvas** SDC
integration. Package `Field types`. Core `^10.3 || ^11 || ^12`. License GPL-2.0-or-later.
Version 1.1.0. No runtime module dependencies (`drupal/canvas` is only a dev/suggest dep).

## Solution docs

- **Palette config entity, editor form, routes & permission** → [entities/palette.md](entities/palette.md)
- **The `curated_color` field type, widget, formatters & computed properties** → [fields/field-type.md](fields/field-type.md)
- **The `curated_color_picker` Form API element** → [api/form-element.md](api/form-element.md)
- **Palette resolver service + `PaletteColorsEvent`** → [api/resolver-event.md](api/resolver-event.md)
- **Drupal Canvas / SDC integration** → [canvas/integration.md](canvas/integration.md)
- **`curated_colors_example` submodule** → [modules/curated_colors_example/1.1.x/agent/start.md](../../modules/curated_colors_example/1.1.x/agent/start.md)

## What it provides (from source)

- **Config entity** `curated_color_palette` (`src/Entity/ColorPalette.php`): exports `id`, `label`,
  `description`, `groups`, `colors`. Each color = `{key, label, hex?, style?, groups[], enabled}`.
  Helpers `getColors()` (keyed by `key`, injects `enabled` default TRUE), `getOptions()`,
  `getGroups()`. Admin permission `administer curated color palettes`.
- **Field type** `curated_color` (`src/Plugin/Field/FieldType/CuratedColorItem.php`): single
  `value` varchar(64) column storing a color key; `default_widget` `curated_color_picker`,
  `default_formatter` `curated_color_swatch`. Instance settings `palette` + `allowed_groups`.
  Four **computed** properties (`hex`, `style`, `label`, `css`) via `CuratedColorComputedProperty`.
  Implements `OptionsProviderInterface`; validates value against an `AllowedValues` constraint.
- **Widget** `curated_color_picker` (`.../FieldWidget/CuratedColorPickerWidget.php`).
- **Formatters** `curated_color_swatch` (chip + label, theme `curated_colors_swatch`) and
  `curated_color_value` (plain-text key/label/hex/style) — both in `.../FieldFormatter/`.
- **FAPI element** `curated_color_picker` (`src/Element/CuratedColorPicker.php`) extending core
  `Select`.
- **Service** `curated_colors.palette_resolver` → `ColorPaletteResolver` (`src/ColorPaletteResolver.php`,
  iface `ColorPaletteResolverInterface`): `resolveForCanvas()` + `getColors()` (fires the event).
- **Event** `PaletteColorsEvent` (`src/Event/PaletteColorsEvent.php`, name
  `curated_colors.palette_colors`) — subscribers may add/remove/replace colors.
- **Hooks** in `curated_colors.module`: `hook_theme`, `hook_field_widget_info_alter`,
  `hook_canvas_storable_prop_shape_alter` (Canvas-gated).
- **Libraries** (`curated_colors.libraries.yml`): `picker` (js/curated-colors-picker.js) and
  `palette_form` (editor UI). **Install hook** `curated_colors_update_10001` backfills the
  `enabled` flag on stored colors.
- **Routes** (`curated_colors.routing.yml`): entity collection/add/edit/delete under
  `/admin/config/content/curated-colors`, all gated by `administer curated color palettes`.
  Config schema in `config/schema/curated_colors.schema.yml`.
- **Submodule** `curated_colors_example`: a `drupal_brand` palette + a `colored_card` SDC component.
