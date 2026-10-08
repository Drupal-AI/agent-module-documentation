<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Render element `print_area_button` + `area_print()` helper

The developer-facing surface: a render element and a convenience function, both producing a
Print control that prints one selected region of the current page.

## Render element `print_area_button`

- Class: `Drupal\area_print\Element\PrintButton` (extends `RenderElement`)
- Annotation: `@RenderElement("print_area_button")`

Properties (from `getInfo()`):

| Property | Default | Meaning |
|----------|---------|---------|
| `#css_selector` | `main#main` | CSS selector of the element whose contents are printed. |
| `#as_link` | `FALSE` | `FALSE` → `<button>`; `TRUE` → `<a>`. |
| `#label` | `t('Print')` | Visible text of the button/link. |

`preRender()` builds the markup (a `<button>` or `<a>` with fixed id `print-area-button` and
`title` "Opens in a popup"), then attaches:

- library `area_print/area_print_js`
- `drupalSettings.area_print = { button_id: 'print-area-button', selector: <#css_selector> }`

The id is hardcoded, so only **one** print control per page is supported.

### Usage

```php
$build['print'] = [
  '#type' => 'print_area_button',
  '#label' => $this->t('Print page'),
  '#css_selector' => 'main#main',
  '#as_link' => FALSE,
];
```

Important: `preRender` reads `#label` for the text — pass `#label`, not `#value`. (`#value`, used by
the block and the helper below, is ignored, so those paths render the default "Print".)

## Helper `area_print()`

`area_print(array $options = [])` in `area_print.module` returns the render array. It supports a
reduced subset of the legacy option set:

| Option | Maps to | Default |
|--------|---------|---------|
| `value` | `#value` (ignored by preRender — see above) | `t('Print')` |
| `target_id` | `#css_selector` = `'#' . target_id` | `content` |
| `type` | `#as_link` (`'button'` → FALSE, `'link'` → TRUE) | `button` |

```php
$build['print'] = area_print([
  'target_id' => 'my_printable_div',
  'type' => 'link',
]);
```

(`README.txt` documents older options `button_id`, `custom_css`, `hide_button` and a
`area_print_form()` function; those are not implemented in this release.)

## Library / behavior

`area_print/area_print_js` (`area_print.js`, depends on `core/drupalSettings`) registers
`Drupal.behaviors.area_print`. On click of `#print-area-button` it `window.open()`s the current
URL, hides every sibling of the selected element and its ancestors, calls `print()`, then closes
the popup. A separate legacy branch shows an "Press OK to print." alert for old Internet Explorer.

A `@media print` stylesheet still controls how the printed region looks; this element only chooses
what is sent to the dialog.
