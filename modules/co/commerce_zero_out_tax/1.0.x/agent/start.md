<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# commerce_zero_out_tax — agent start

Adds one **Commerce promotion offer** that resets an order's tax to **zero** by replacing its tax
adjustments with 0-amount adjustments. Version **1.0.0-alpha1** (alpha; not covered by Drupal
security advisory policy). Core `^10 || ^11`. Depends on `commerce`, `commerce_order`,
`commerce_promotion`, `commerce_tax`. No routes, no permissions, no config page — you use it by
building a Commerce promotion whose **offer** is "Zero out tax".

## How it works (whole module is 3 classes)

Trigger for the zero-out is a **Commerce Promotion with offer `zero_out_tax_offer` becoming
applicable** to the order — evaluated by the core `commerce_promotion` engine (the promotion's
conditions and, if used, coupon). The offer itself carries no per-order input beyond its admin-set
`modes`.

- **`ZeroOutTaxOffer`** — promotion offer plugin, id `zero_out_tax_offer`, label "Zero out tax",
  `entity_type = commerce_order`, extends `PromotionOfferBase`.
  `src/Plugin/Commerce/PromotionOffer/ZeroOutTaxOffer.php`.
  - `apply()`: if the order matches and `configuration['modes']` is non-empty, sets order data
    `zero_out_tax` = `array_fill_keys($modes, TRUE)` (a flag; does not itself touch adjustments).
  - Config form: required checkboxes **`non_included`** ("Non-included taxes (added on top)", e.g.
    US sales tax) and **`included`** ("Included taxes built into prices", e.g. VAT/GST). Default =
    `['non_included']`.
- **`ClearZeroOutTaxFlagProcessor`** — order processor, priority **500** (runs early each refresh).
  `unsetData('zero_out_tax')` so the flag is cleared every cycle and must be re-set by the offer to
  take effect. `src/OrderProcessor/ClearZeroOutTaxFlagProcessor.php`.
- **`ZeroOutTaxOrderProcessor`** — order processor, priority **-200** (runs after tax calculation).
  If the `zero_out_tax` flag is set, for the order **and each order item** it removes every tax
  adjustment whose included/non-included mode is selected and re-adds a `Price('0', …)` tax
  adjustment labelled `"<original label> (removed tax)"` (preserves `included` flag and
  `source_id`). `src/OrderProcessor/ZeroOutTaxOrderProcessor.php`.

Registration: `commerce_zero_out_tax.services.yml` tags both processors as
`commerce_order.order_processor` (priorities 500 and -200).

## Usage

Enable the module → **Commerce → Promotions → Add promotion** → set the offer to **Zero out tax**,
pick which tax modes to strip, and scope it with the promotion's conditions/coupons. The tax total
becomes zero for orders the promotion applies to. See [../usage.md](../usage.md) and the
human guide [../human-docs/index.md](../human-docs/index.md).

## Notes for agents

- No `config/schema` ships; offer config (`modes`) is stored via the promotion offer's standard
  configuration array. No custom permissions, routes, services beyond the two processors, or
  external calls.
- Zeroing tax carries **tax-compliance** obligations — scope any such promotion to genuinely exempt
  cases via its conditions/coupons.
