# Custom field types, widgets & formatters

The base module defines two Field API field types (with default widgets/formatters) that the Display tab
of every bundle uses. You can reuse them on your own paragraph types or entities.

## `paragraphs_bundles_rgb` — Color Picker

`src/Plugin/Field/FieldType/ColorItem.php`. Single `value` column, `text` size `tiny`. Stores a color
string (hex like `#1a2b3c` or `#abc`).

- Default widget: **`color_text_widget`** (`FieldWidget/ColorTextWidget.php`) — a textfield (`maxlength 7`,
  HTML `pattern ^#[a-fA-F0-9]{6}`) that attaches the `paragraphs_bundles/color-picker` JS library and
  validates the value with `Drupal\Component\Utility\Color::validateHex()` (empty allowed; invalid → form
  error "Color must be a 3- or 6-digit hexadecimal value").
- Default formatter: **`color_text_formatter_hex`** — renders the trimmed value inside a `<div>`.
- Other formatters: **`color_text_formatter_rgb`** (`ColorTextFormatterRGB.php`) and
  **`color_swatch`** (`ColorSwatchFormatter.php`).

In bundle templates the raw color value is read and injected as a CSS custom property, e.g.
`--pb-bg:rgba(<value>, <opacity>)` — see [../theming/rendering.md](../theming/rendering.md).

## `paragraphs_bundles_range` — BG Opacity Range

`src/Plugin/Field/FieldType/RangeItem.php`. Single integer `value` column with storage settings
`min: 0, max: 100`, `not null`. Represents background opacity as a percentage.

- Default widget: **`range_number_widget`** (`FieldWidget/RangeNumberWidget.php`), attaching the
  `paragraphs_bundles/opacity-range` JS/CSS.
- Default formatter: **`range_number_formatter`** (`FieldFormatter/RangeNumberFormatter.php`).

Templates convert `100` → full opacity and any lower value `n` → `0.<n>` when composing `rgba()`.

## Reusing them

Add a field of type *Color Picker* or *BG Opacity Range* to any bundle/entity via the field UI, or in
code set the field type id (`paragraphs_bundles_rgb` / `paragraphs_bundles_range`) on a field storage.
The widgets/formatters are selected automatically as defaults. Config schema for a stored default lives
under `field.paragraphs_bundles_rgb.value` (`config/schema/paragraphs_bundles.schema.yml`).

There are **no custom plugin *types*** here — these are ordinary Field API plugins (`@FieldType`,
`@FieldWidget`, `@FieldFormatter`).
