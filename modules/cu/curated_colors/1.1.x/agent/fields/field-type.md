<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `curated_color` field type, widget & formatters

## Field type: `CuratedColorItem` (`src/Plugin/Field/FieldType/CuratedColorItem.php`)

`#[FieldType(id: 'curated_color', …)]`, `default_widget: 'curated_color_picker'`,
`default_formatter: 'curated_color_swatch'`, `category: 'curated_color'`. Extends `FieldItemBase`,
implements `OptionsProviderInterface`.

- **Storage** (`schema()`): one `value` column, `varchar(64)`, nullable, indexed. Stores the color
  **key** only (`brand-blue`), never the hex/CSS.
- **Instance settings** (`defaultFieldSettings()`): `palette` (string id, required in the settings
  form) and `allowed_groups` (sequence). Schema in `field.field_settings.curated_color`.
- **`fieldSettingsForm()`** — a `palette` select of all palettes (`label (id)`) with an AJAX
  callback, and, once a palette is chosen, an `allowed_groups` **checkboxes** element listing the
  palette's groups plus an "Ungrouped" toggle (only offered when the palette actually has
  ungrouped colors). `normalizeAllowedGroups()` (an `#after_build`) reduces the checkboxes value to
  a plain sequence of checked names to match the config schema.
- **`getPalette()`** loads the configured `ColorPalette` (or NULL). **`getAllowedColors()`** loads
  the palette's colors *through the resolver service* (so `PaletteColorsEvent` runs) and filters
  by `allowed_groups`; an empty filter means "all colors". `UNGROUPED_KEY = '_ungrouped'` is the
  sentinel for colors in no group.
- **Options/validation**: `getPossibleOptions()`/`getSettableOptions()` return the allowed
  `key => label` map. `getConstraints()` adds an `AllowedValues` constraint (`['']` + allowed keys)
  so only real palette keys — or empty — validate. `isEmpty()` treats `NULL`/`''` as empty;
  `mainPropertyName()` is `value`.
- **`calculateDependencies()`** adds a config dependency on the selected palette entity.

### Computed properties (`CuratedColorComputedProperty`, `src/TypedData/`)

`propertyDefinitions()` defines four read-only computed string properties, each backed by
`CuratedColorComputedProperty` with a `color_property` setting; the class loads the item's palette
through the resolver, looks up the stored key, and returns:

| Property | Returns |
|---|---|
| `value` | stored key (the raw column) |
| `hex` | palette entry's hex, or `''` |
| `style` | palette entry's custom CSS, or `''` |
| `label` | palette entry's human label |
| `css` | `style` if set, else `background:<hex>;`, else `''` — ready for a `style` attribute |

Use in Twig: `{{ node.field_accent.value }}`, `{{ node.field_accent.label }}`,
`{{ node.field_accent.css }}`. The recommended production pattern is to apply `value` as a CSS
modifier class and keep real colors in your stylesheet; use `css` only where inline styles are
unavoidable (email, SVG).

> When Canvas is installed, `propertyDefinitions()` tags `value` with a `StringSemantics: prose`
> constraint so the field is discoverable in Canvas's field-binding dropdown (Canvas gates
> bare-string prop matches on that constraint). It's skipped on non-Canvas sites.

## Widget: `curated_color_picker` (`.../FieldWidget/CuratedColorPickerWidget.php`)

`#[FieldWidget(id: 'curated_color_picker', field_types: ['curated_color'])]`, extends `WidgetBase`.
Settings (schema `field.widget.settings.curated_color_picker`): `display_groups` (bool, default
TRUE — render group sections) and `show_label` (bool, default TRUE — show the selected color's
label on the trigger). `formElement()` builds a single `#type => 'curated_color_picker'` element
(see [../api/form-element.md](../api/form-element.md)), passing the field's palette id, the
instance `allowed_groups`, the two widget settings, and translated `#labels`. When no palette is
configured it shows a "choose one in the field settings" description. `massageFormValues()`
converts an empty `''` selection back to `NULL`.

## Formatters (`.../FieldFormatter/`)

### `curated_color_swatch` — `CuratedColorSwatchFormatter`

`#[FieldFormatter(id: 'curated_color_swatch', field_types: ['curated_color'])]`, label
*Color swatch*. Setting `show_label` (bool, default TRUE). `viewElements()` loads the field's
palette, and for each item whose key exists renders `#theme => 'curated_colors_swatch'` with
`color_key`, `color_label`, `color_hex`, `color_style` (= custom style, else `background:<hex>;`,
else `''`) and `show_label`, attaching library `curated_colors/picker`. It applies the palette's
**cacheable metadata** to each item, so display caches invalidate when the palette changes. Theme
variables are declared by `hook_theme()` (`curated_colors_swatch`); template
`templates/curated-colors-swatch.html.twig` (overridable).

### `curated_color_value` — `CuratedColorValueFormatter`

`#[FieldFormatter(id: 'curated_color_value', field_types: ['curated_color'])]`, label
*Raw color value*. Setting `output` (default `hex`) selects `key`, `label`, `hex`, or `style`
(custom CSS, or `background:<hex>;` fallback). Renders each item as `#plain_text`; applies palette
cache metadata.

## Enabling the field (example)

```bash
# Add a curated_color field to article (via UI: Manage fields → Curated color).
# Choose a palette, optionally restrict allowed_groups, in the field settings.
drush cset core.entity_view_display.node.article.default \
  content.field_accent.type curated_color_swatch -y
drush cr
```
