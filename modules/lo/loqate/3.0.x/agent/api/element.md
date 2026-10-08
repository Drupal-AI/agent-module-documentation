<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `pca_address` element, traits & `Loqate::getApiKey()`

The base module exposes a render element and two reusable traits so custom forms, field widgets and
Webform elements can share Loqate autocomplete. Source: `src/Element/LoqatePcaAddress.php`,
`src/PcaAddressElementTrait.php`, `src/PcaAddressFieldWidgetTrait.php`, `src/Loqate.php`,
`js/pca-address.js`.

## `pca_address` form element

`#[FormElement('pca_address')]` (`LoqatePcaAddress`). Renders address subfields (Line1/2, postal code,
locality, admin area, country) plus a "Search Address" lookup textfield and (optionally) a manual-entry
toggle. Use it in a form array:

```php
$form['address'] = [
  '#type' => 'pca_address',
  '#pca_fields' => [                    // omit to fall back to loqate.settings:pca_fields
    ['element' => 'address_line1', 'field' => 'Line1', 'mode' => 2],
    ['element' => 'locality',      'field' => 'City',  'mode' => 2],
  ],
  '#pca_options' => [
    'key' => 'my_key_entity_id',        // optional; defaults to the site key
    'countries' => ['codesList' => 'USA,CAN'],
    'setCountryByIP' => FALSE,
  ],
  '#show_address_fields' => FALSE,       // hide fields until a result is chosen
  '#allow_manual_input' => TRUE,         // show "enter manually" link
  '#required' => TRUE,
];
```

## How it wires up (`processPcaAddress` in `PcaAddressElementTrait`)

- Wraps the address subfields in a `<div>` (hidden unless `#show_address_fields`), adds the
  `address_lookup` textfield (only visible once a country is filled) and an `address_label`
  fieldset with an "Edit address" link.
- `preparePcaFieldMapping()` — falls back to `loqate.settings:pca_fields`, prefixes each mapping's
  `element` with the element `#name`, appends the lookup field, and exposes the list at
  `drupalSettings.pca_address.elements['#<id>'].fields`.
- `preparePcaOptions()` — resolves `key` via `Loqate::getApiKey($pca_options['key'] ?? default)` and
  merges the rest of `#pca_options`, exposing them at `…['#<id>'].options` (**the key value, not id**).
- Attaches library `loqate/element.pca_address.address.js`, which depends on the external
  `loqate/libraries.pca.address.js` (Loqate SDK from `api.addressy.com`). `js/pca-address.js` reads
  `drupalSettings.pca_address` and instantiates `pca.Address` per element.
- `validateAddress()` is a stub (`@TODO`) — no server-side validation of the picked address.

## `Loqate::getApiKey($key_id = NULL): ?string`

Static helper (`src/Loqate.php`). With no arg it reads
`loqate.loqateapikeyconfig:loqate_api_key` (a Key **id**) and returns that Key entity's **value**;
pass a `$key_id` to resolve a specific Key. Returns NULL if none resolves.

## `PcaAddressFieldWidgetTrait` (for field widgets)

Provides `getFieldWidgetDefaultSettings()`, a settings form (`show_address_fields`,
`allow_manual_input`, `loqate_api_key` key_select), a settings summary, and
`buildFieldWidgetFormElement()` which copies the widget settings onto the `address` sub-element's
`#pca_fields` / `#pca_options` / `#show_address_fields` / `#allow_manual_input` / key. Used by the
`pca_address` submodule widget.
