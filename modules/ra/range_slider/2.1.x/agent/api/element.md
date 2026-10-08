<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `range_slider` render element, Webform element & library

## Render / form element

`Drupal\range_slider\Element\RangeSlider` (`@FormElement("range_slider")`) extends core
`Drupal\Core\Render\Element\Range`, so it accepts all `range`/`number` properties (`#min`, `#max`,
`#step`, `#default_value`, …) plus:

| Property | Default | Meaning |
|---|---|---|
| `#data-orientation` | `horizontal` | `horizontal` or `vertical`; rendered as the `data-orientation` attribute. |
| `#output` | `FALSE` | one of `below`/`above`/`left`/`right` to show the live value; `FALSE` = none. |
| `#output__field_prefix` | `''` | text placed before the printed value. |
| `#output__field_suffix` | `''` | text placed after the printed value. |

Example:

```php
$form['quantity'] = [
  '#type' => 'range_slider',
  '#title' => $this->t('Quantity'),
  '#min' => 0,
  '#max' => 100,
  '#data-orientation' => 'vertical',
  '#output' => 'below',
  '#output__field_prefix' => '$',
  '#output__field_suffix' => 'USD',
];
```

`processRangeSlider()` pushes `#output` and the prefix/suffix into
`drupalSettings.range_slider.elements['#<id>']` and attaches library
`range_slider/element.rangeslider`.

## Webform element

`Drupal\range_slider\Plugin\WebformElement\RangeSlider` (`@WebformElement id="range_slider"`,
category "Advanced elements", extends Webform's `Range`) exposes the same slider inside Webform
forms — no extra config needed beyond selecting the element.

## Library

`range_slider/element.rangeslider` (see `range_slider.libraries.yml`) depends on
`range_slider/libraries.rangeslider.js`, which loads **rangeslider.js 2.3.2** CSS/JS from
`cdn.jsdelivr.net`. No Composer/npm install is required, but the CDN must be reachable at runtime
(or you can override the library to serve the files locally).

There are **no plugin types, hooks, permissions, Drush commands, or configure route** in this module.
