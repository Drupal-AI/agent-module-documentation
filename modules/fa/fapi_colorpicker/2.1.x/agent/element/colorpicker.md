<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `colorpicker` Form API element

Class `Drupal\fapi_colorpicker\Element\Colorpicker` — `@FormElement("colorpicker")`, extends
`Drupal\Core\Render\Element\FormElementBase`. File: `src/Element/Colorpicker.php`. No other PHP in the module.

## Using it

```php
$form['color'] = [
  '#type' => 'colorpicker',
  '#title' => $this->t('Colour'),
  '#default_value' => '#1a2b3c',
  '#required' => TRUE,
];
```

Supported properties are the standard core form-element ones: `#title`, `#default_value` (a hex string),
`#required`, `#description`. On submit, `$form_state->getValue('color')` is a **7-char lowercase hex string with
a leading `#`** (e.g. `#1a2b3c`). The value is developer-consumed downstream (save to config/entity, emit CSS,
etc.).

## `getInfo()` — element defaults

Returns the element definition:

- `#input => TRUE`
- `#default_value => '#000000'`
- `#process => [[RenderElementBase::class, 'processAjaxForm']]` — so it works inside AJAX forms.
- `#pre_render => [[static::class, 'preRenderColorpicker']]`
- `#theme => 'input__color'`, `#theme_wrappers => ['form_element']` — rendered as a native colour input wrapped
  in the standard form-element wrapper (label, description).
- `#attached => ['library' => ['fapi_colorpicker/colorpicker']]` — attaches the JS library automatically.
- `#element_validate => [[static::class, 'validateColorpicker']]`

## `valueCallback(&$element, $input, $form_state)`

Normalises whatever comes in. If `$input` is present (not FALSE/NULL) it returns `normalizeHex((string) $input)`;
otherwise it normalises `#default_value` (falling back to `#000000`). So `#value` is always a clean hex string
before rendering.

## `preRenderColorpicker(array $element)`

Runs at render time:

- Sets `#attributes['type'] = 'color'` and `#attributes['value'] = $element['#value']`.
- Appends a companion text input as `#suffix`: `<input type="text" class="fapi-colorpicker-hex" maxlength="7"
  value="…" aria-label="Hex value" />`, where the value is passed through
  `htmlspecialchars($element['#value'], ENT_QUOTES, 'UTF-8')`.

## `validateColorpicker(&$element, $form_state)`

Server-side validation in `#element_validate`. Empty value is allowed (returns early). Otherwise the value must
match `/^#[0-9a-fA-F]{6}$/`; if not, sets a form error: "Enter a valid hex colour (e.g. #1a2b3c)."

## `normalizeHex(string $value)` (protected)

Lowercases and trims, prepends `#` if missing, and returns the value only if it matches `/^#[0-9a-f]{6}$/` —
otherwise returns `#000000`. This is the single source of truth for the element's stored format.

## The JS library

`fapi_colorpicker/colorpicker` → `js/fapi_colorpicker.js`, deps `core/drupal` + `core/jquery`. The
`Drupal.behaviors.fapiColorpicker` behavior finds `input[type="color"].fapi-colorpicker-widget`, and two-way-syncs
it with the adjacent `.fapi-colorpicker-hex` text input: editing the native swatch copies its value into the hex
field (`$hex.val(...)`); typing in the hex field copies a valid `#rrggbb` value back into the swatch
(`$color.val(...)`), only when it matches `/^#[0-9a-fA-F]{6}$/`. Values are set via jQuery `.val()` (the input
value property), never as HTML. The picker degrades gracefully: without JS the native colour input and the hex
text field both still work.
