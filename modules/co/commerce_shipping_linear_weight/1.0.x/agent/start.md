<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Shipping Linear Weight (commerce_shipping_linear_weight) — agent index

**Commerce shipping-method plugin `commerce_shipping_linear_weight` that charges `rate_amount * order_weight_in_kg`, rounded to 2 decimals.** A pure proportional rate (through the origin) — there is **no fixed/base component**, no minimum, no maximum.

- **Version:** 1.0.3 (branch 1.0.x)
- **Core:** `^8 || ^9 || ^10 || ^11`
- **Dependencies:** `commerce`, `commerce_order`, `commerce_price`, `physical`, `commerce_shipping`
- **Plugin:** `Drupal\commerce_shipping_linear_weight\Plugin\Commerce\ShippingMethod\LinearWeightShipping` (annotation id `commerce_shipping_linear_weight`, label "Linear Weight Shipping"), extends `ShippingMethodBase`. Single shipping service `default` whose label is the configured `rate_label`.
- **Config (stored on each `commerce_shipping_method` entity's plugin config):**
  - `rate_label` (textfield, **required**) — shown to the customer; becomes the `default` service label.
  - `rate_description` (textfield, optional) — extra detail, passed through as the `ShippingRate` description.
  - `rate_amount` (`commerce_price`, **required**) — the per-kilogram rate. The `#description` frames it as €/kg (e.g. `2` → 4 € for a 2 kg order); the module treats **all weights as kg**.
- **Rate math (`calculateRates()`):** `$weight = $shipment->getWeight()->convert('kg')->getNumber();` then `round($rate_amount['number'] * $weight, 2)`, wrapped in a `Price` using `$rate_amount['currency_code']`. Weight is Commerce Shipping's server-side shipment weight (summed from product/variation physical weight fields via the packer) — not client input.
- **Setup:** add a shipping method at `/admin/commerce/shipping-methods`, pick "Linear Weight Shipping", set label + per-kg rate.
- **Other files:** `.module` provides only `hook_help()`. No routes, no permissions, no services, no config/schema, no submodules, no Drush, no libraries, no JS.
- **Security:** rate is computed server-side from the shipment's own weight and the admin-configured per-kg rate; no route, no permission, no anonymous surface — configuration is behind Commerce's shipping-method admin access. No security findings.

## Notes / caveats

- **Purely proportional:** a 0 kg order (or products with no weight set) yields a 0 shipping charge; `round(..., 2)` means sub-cent products can round to 0. There is no configurable minimum.
- The `rate_description` `#description` and README example use `€`, but the actual currency is whatever `rate_amount`'s currency code is.

See [../usage.md](../usage.md) for a task-oriented walkthrough.
