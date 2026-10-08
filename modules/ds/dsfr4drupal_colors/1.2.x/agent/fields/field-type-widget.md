<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field type, widget, render element (dsfr4drupal_colors)

## Field type — `dsfr4drupal_color_field_type`

`src/Plugin/Field/FieldType/ColorFieldType.php` extends `FieldItemBase`.

- **Attribute**: `default_widget: dsfr4drupal_color_field_widget_box`,
  `default_formatter: dsfr4drupal_color_field_formatter_text`.
- **Storage** (`schema()`): single column `color`, `varchar(128)`, nullable, indexed.
  `mainPropertyName()` = `color`; `propertyDefinitions()` = one string `color`.
- **Value shape**: DSFR CSS variable name without the leading `--`, e.g. `blue-france-main-525`
  (`generateSampleValue()` returns exactly that). `isEmpty()` is true when `color` is `NULL`/`''`.
- **Validation constraint** (in the attribute): `ComplexData` → `color` → `Regex` pattern
  `#^[a-z0-9-]+-[0-9]+$#`. Enforced on entity validation (the content form path), constraining
  the stored value to the DSFR color-token charset (lowercase letters, digits, hyphens, ending
  in `-<digits>`).

### Per-field settings (`fieldSettingsForm`)

`defaultFieldSettings()` = `allowed_colors: []`, `contrast_ratio_type: ''`,
`contrast_ratio_value: ''`. Config schema key is `field.field_settings.color_field_type`
(`config/schema/dsfr4drupal_colors.schema.yml`).

1. **Allowed colors** (`fieldSettingsFormAllowedColors`): a fieldset of checkboxes grouped by DSFR
   family via `ColorsHelper::getColorsOptionsByGroups()` / `getGroups()` (primary, neutral, system,
   illustrative). Empty selection = all colors allowed. `#element_validate` callback
   `validateAllowedColors()` collapses the checkbox map to an indexed array of selected color IDs.
   Attaches library `dsfr4drupal_colors/allowed-colors-select`.
2. **Contrast ratio validation** (`fieldSettingsFormContrastRatio`): a `type` select with options
   `field` (another DSFR color field on the same bundle), `color_field` (a Color Field module
   field), `hex` (a `#rgb`/`#rrggbb` code, `pattern` `#([0-9a-fA-F]{3}){1,2}`), `name` (a DSFR
   color variable). `#states` show the matching value input. `validateContrastRatio()` writes the
   chosen `contrast_ratio_type` / `contrast_ratio_value` back into settings and errors if a per-field
   choice has no available field. Minimum required ratio noted in UI as `450`.

## Widget base — `ColorFieldWidgetBase`

`src/Plugin/Field/FieldWidget/ColorFieldWidgetBase.php` (abstract), gets the helper service in
`create()`.

- `formElement()` builds a `color` child as a `textfield` (overridden by subclass), forces a stable
  HTML id via `getHtmlIdentifier()` (`Html::getId('dsfr4drupal-color-<field>-<delta>-input')`) on
  `#uid`, and turns the wrapper `#type` into `container`.
- If `contrast_ratio_type` is set, attaches library `dsfr4drupal_colors/contrast-ratio`, publishes
  all colors+hex to `drupalSettings.dsfr4drupal_colors.colorsAvailable`, and the field's contrast
  config under `contrastRatio[<uid>]` (`type`, `value`). For type `field`, `value` is resolved to
  the target field's HTML id.
- `getColorsOptions()` returns `ColorsHelper::getColorsOptions()` filtered by the `allowed_colors`
  setting.

## Widget — `dsfr4drupal_color_field_widget_box`

`ColorFieldWidgetBox` extends the base.

- `defaultSettings()`: `squares_size: 'medium'`, `has_search: FALSE`.
- `settingsForm()`: `squares_size` radios (`small`/`medium`/`large`), `has_search` checkbox.
- `formElement()`: calls parent, then switches the `color` element `#type` to the
  `dsfr4drupal_color_box` render element and passes `#allowed_colors`, `#has_search`, `#squares_size`.

## Render element — `dsfr4drupal_color_box`

`src/Element/ColorBoxElement.php`, `#[FormElement('dsfr4drupal_color_box')]`, extends core
`Textfield`. Reusable in custom forms (see class docblock example).

- `getInfo()`: adds `#process` `processColorBox` and `#pre_render` `preRenderColorBox`; defaults
  `#allowed_colors: []`, `#has_search: FALSE`, `#squares_size: 'medium'`.
- `processColorBox()`: if `#uid` was set, use it as `#id`.
- `preRenderColorBox()`: adds class `dsfr4drupal-color-widget-box--element`; builds per-element
  `drupalSettings.dsfr4drupal_colors.widgetBox[<id>]` = `hasSearch`, `required`, `squaresSize`,
  `colors` (helper options filtered by `#allowed_colors`); publishes the active `scheme`
  (`dsfr4drupal_colors.settings:scheme`) and the light/dark theme class names
  (`ColorsHelperInterface::CLASS_THEME_LIGHT` / `CLASS_THEME_DARK`); attaches library
  `dsfr4drupal_colors/color-field-widget-box`.

## Configure

Field UI: add a field of type *DSFR for Drupal - Color*; set widget *DSFR for Drupal - Color boxes*
on *Manage form display*; set allowed colors / contrast validation in the field settings; pick a
formatter on *Manage display*.
