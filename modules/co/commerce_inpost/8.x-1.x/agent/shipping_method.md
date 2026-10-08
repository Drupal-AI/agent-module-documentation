<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# InPost shipping method (flat rate)

`Drupal\commerce_inpost\Plugin\Commerce\ShippingMethod\InPostShipping`
(`@CommerceShippingMethod id = "commerce_inpost_shipping"`, label "InPost Shipping"), extends
`ShippingMethodBase`.

This is a **fixed-price shipping method**, like Commerce's core Flat Rate. There is **no live-rate
call to InPost** — the amount is whatever you enter in the plugin form.

## Configuration form
`buildConfigurationForm()` adds three fields (on top of the base plugin fields such as
services/conditions):

| Field | Type | Required | Config key |
|-------|------|----------|------------|
| Rate label | textfield | yes | `rate_label` |
| Rate description | textfield | no | `rate_description` |
| Rate amount | `commerce_price` | yes | `rate_amount` |

`submitConfigurationForm()` writes these three keys back to `$this->configuration`. Default config
(`defaultConfiguration()`): `rate_label = ''`, `rate_description = ''`, `rate_amount = NULL`,
`services = ['default']`.

The constructor registers a single shipping service: `new ShippingService('in_post', rate_label)`
into `$this->services['default']`.

## Rate calculation
`calculateRates(ShipmentInterface $shipment)` returns exactly one `ShippingRate`:

```php
new ShippingRate([
  'shipping_method_id' => $this->parentEntity->id(),
  'service' => $this->services['default'],
  'amount' => Price::fromArray($this->configuration['rate_amount']),
  'description' => $this->configuration['rate_description'],
]);
```

The amount is always the fixed `rate_amount`; it does not vary by weight, destination, or locker.

## How the checkout pane recognises it
`InPostPane::getInpostIds()` loads all `commerce_shipping_method` entities and, for each whose plugin
`instanceof InPostShipping`, builds the option key `"{shipping_method_id}--in_post"`. That key is how
the pane detects that an InPost method is selected (drives the `#states` visibility of the locker
picker and the validation/submit of the locker fields). So the locker UI appears for **any** shipping
method that uses this plugin.
