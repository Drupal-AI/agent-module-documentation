# API — the `coloriswidget` render element

`Drupal\coloris\Element\ColorisWidget` (`@FormElement("coloriswidget")`, extends core
`Textfield`) is a reusable form element you can drop into any custom form or render array to get
a Coloris-powered color input — no field needed.

```php
$form['brand_color'] = [
  '#type' => 'coloriswidget',
  '#title' => $this->t('Brand color'),
  '#default_value' => '#ff8800',
  // Any of the settings below map to data-* attributes on the input:
  '#format' => 'hex',
  '#alpha' => TRUE,
  '#swatches' => ['#ff8800', '#0088ff'],
  '#theme_mode' => 'dark',
  '#data_theme' => 'large',
  '#inline' => FALSE,
];
```

## Behaviour (`processFormElement`)

The element's `#process` callback rebuilds it as a `textfield` wrapped in
`<div class="coloris-wrapper">`, adds class `coloris`, attaches the `coloris/element.coloris`
library, and serialises the following `#…` properties into `data-*` attributes read by
`js/coloris.js`:

| `#property` | data-attribute | notes |
|---|---|---|
| `#wrap` | `data-wrap` | `false` when explicitly `FALSE`, else `true` |
| `#data_theme` | `data-theme` | default `default` |
| `#theme_mode` | `data-theme-mode` | default `light` |
| `#margin` | `data-margin` | default `2` |
| `#format` | `data-format` | default `hex` |
| `#format_toggle` | `data-format-toggle` | |
| `#alpha` | `data-alpha` | |
| `#swatches_only` | `data-swatches-only` | |
| `#focus_input` | `data-focus-input` | |
| `#clear_button_show` | `data-clear-button-show` | |
| `#clear_button_label` | `data-clear-button-label` | |
| `#swatches` | `data-swatches` | `json_encode(array_filter(...))` |
| `#inline` | `data-inline` | |
| `#default_color` | `data-default-color` | if set |
| `#parent` | `data-parent` | added when `#parent !== FALSE` |

## Validation

The element's `#element_validate` (`validateFormElement`) applies the same color regex as the
field widget: only `#hex`, `rgb()/rgba()`, `hsl()/hsla()` values pass; anything else raises
"The color code %color is not valid." Empty passes.

The field widget `text_coloris` (`ColorisWidget::formElement`) is just a thin wrapper that maps
the field's settings onto a `#type => coloriswidget` element, so custom-form usage and field
usage share this element.
