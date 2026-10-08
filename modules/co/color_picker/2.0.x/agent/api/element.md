# The `color_picker` form element

Use it like any Form API element in a custom form/render array.

```php
$form['colour'] = [
  '#type' => 'color_picker',
  '#title' => $this->t('Colour'),
  '#color_values' => '#000000,#ffffff,#ff0000', // comma-separated hex swatches
  '#default_value' => '#000000',
  '#required' => TRUE,
];
```

## Properties / defaults (`ColorPicker::getInfo()`)

| Property | Value | Note |
|---|---|---|
| `#input` | `TRUE` | It's an input element. |
| `#size` / `#maxlength` | `7` | Fits `#rrggbb`. |
| `#pattern` | `#([A-Fa-f0-9]{6})` | HTML5 pattern; enforces 6 hex digits. Applied via `processPattern`. |
| `#process` | `processAjaxForm`, `processPattern` | Standard input processing. |
| `#pre_render` | `preRenderColorPicker` | Sets `type=text`, copies attributes incl. `color_values`. |
| `#theme` | `color_picker` | `templates/color-picker.html.twig`. |
| `#theme_wrappers` | `form_element` | Standard label/description wrapper. |
| `#attached[library]` | `color_picker/color_picker` | jQuery + Drupal + once + module JS/CSS. |
| `#color_values` | (you set) | Comma-separated hex list rendered as selectable swatches. |

## How `#color_values` reaches the JS

1. `preRenderColorPicker()` calls `Element::setAttributes()` including `color_values`, so the
   value lands on the input as a `color_values` HTML attribute.
2. `color_picker_preprocess_color_picker()` moves it to `data-color-values` (and unsets the raw
   `color_values`).
3. `js/color_picker.js` reads `data-color-values` to build the `.color-values` swatch list next to
   the input (wrapper markup from the twig template).

## Value handling

The submitted value is the plain text of the input (a `#rrggbb` string). There is no custom
`valueCallback`/`massageFormValues`; treat it as a normal text input constrained by `#pattern`.
Validate server-side too if you rely on the format (the HTML pattern is a client-side hint).
