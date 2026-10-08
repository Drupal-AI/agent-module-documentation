<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `pca_address_advanced` widget & element

Source: `modules/pca_address/src/Plugin/Field/FieldWidget/AddressPcaAddressWidget.php`,
`modules/pca_address/src/Element/AddressPcaAddress.php`.

## Field widget

`@FieldWidget(id = "pca_address_advanced", field_types = {"address"})` — extends Address module's
`AddressDefaultWidget`. Select it on **Manage form display** (`admin/structure/…/form-display`) for any
`address` field. In `formElement()` it takes the parent Address element and switches
`$element['address']['#type']` to `pca_address_advanced`, then applies the widget settings via
`buildFieldWidgetFormElement()` (from `PcaAddressFieldWidgetTrait`).

### Settings (from `getFieldWidgetDefaultSettings()`)

| Setting | Default | Meaning |
|---|---|---|
| `show_address_fields` | `FALSE` | Show the address subfields immediately vs. hide until a lookup result is chosen. |
| `allow_manual_input` | `TRUE` | Offer a "enter manually" link. |
| `loqate_api_key` | `NULL` | Key entity id to use for this widget; empty → site default (`Loqate::getApiKey()`). |
| `pca_fields` | `[]` | Optional per-widget field mapping; empty → `loqate.settings:pca_fields`. |
| `pca_options` | `[]` | Extra Loqate SDK options merged into `#pca_options`. |

Set the widget with Drush:
```php
// drush php:eval
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$fd->setComponent('field_address', [
  'type' => 'pca_address_advanced',
  'region' => 'content',
  'settings' => ['show_address_fields' => FALSE, 'allow_manual_input' => TRUE, 'loqate_api_key' => NULL],
])->save();
```

## Form element

`@FormElement("pca_address_advanced")` (`AddressPcaAddress` extends `\Drupal\address\Element\Address`).
Its `getInfo()` appends `processPcaAddress` to the parent Address `#process` chain and attaches
`loqate/element.pca_address.address.js`. Everything else (lookup field, mapping, key exposure to
`drupalSettings`, client-side SDK) is the shared base-module behavior — see
[../../../../3.0.x/agent/api/element.md](../../../../3.0.x/agent/api/element.md).
