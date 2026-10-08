<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Form API `#mask` property (custom forms)

For custom forms, Mask adds a **`#mask`** render-element property to supported element types,
so you can mask an input without touching form display config.

## Supported element types

`hook_element_info_alter()` in `mask.module` adds `#mask` to the types returned by
`_mask_supported_element_types()`:

- `textfield`
- `tel`

(These are FAPI `#type`s, distinct from the field *widget* ids used by the plugin type.)

## Using it

```php
$form['phone'] = [
  '#type' => 'tel',
  '#title' => $this->t('Phone'),
  '#mask' => [
    'value' => '(00) 0000-0000',   // required; empty value = no mask
    'reverse' => FALSE,
    'clearifnotmatch' => FALSE,
    'selectonfocus' => FALSE,
  ],
];
```

`Drupal\mask\Helper\ElementHelper::processElement()` runs as a `#process` callback: when
`#mask['value']` is non-empty it writes `data-mask-value` plus `data-mask-reverse` /
`data-mask-clearifnotmatch` / `data-mask-selectonfocus` attributes (booleans only added when
true), attaches the `mask/mask` library and the configured `translation` symbols to
`drupalSettings.mask.translation`. `js/mask.js` then finds `[data-mask-value]` elements and
calls the jQuery Mask Plugin. Defaults for the four keys come from the element info, so you may
pass only `value`.

## Adding `#mask` to another element type

`_mask_supported_element_types()` is hard-coded (no alter hook), so to mask a different FAPI
type from your module, call `ElementHelper::elementInfoAlter()` yourself in your own
`hook_element_info_alter()`:

```php
function mymodule_element_info_alter(array &$info) {
  if (isset($info['search'])) {
    (new \Drupal\mask\Helper\ElementHelper())->elementInfoAlter($info['search']);
  }
}
```

## Public API surface

- `Drupal\mask\Mask::getCdnUrl(): string` — the jQuery Mask CDN URL.
- `Drupal\mask\Helper\ElementHelper` (`ElementHelperInterface`) — `elementInfoAlter()` and the
  static `processElement()` `#process` callback.

Reminder: masking is **client-side only** and does not validate the posted value.
