# Configuration

You configure this module by adding a shipping method that uses the Linear Weight
plugin.

## Add a linear-weight shipping method

1. Go to **Commerce → Configuration → Shipping methods**
   (`/admin/commerce/shipping-methods`) and click **Add shipping method**.
2. Choose the **Linear Weight Shipping** plugin.
3. Set the fields:
   - **Rate label** (required) — the text the customer sees for this option (for
     example "Weight-based shipping").
   - **Rate description** (optional) — extra detail shown alongside the rate.
   - **Rate amount** (required) — the amount charged per kg of order weight. The
     shipping cost is this rate multiplied by the order's total weight, so at
     2 €/kg a 2 kg order costs 4 €. Remember weights are treated as kilograms,
     and the charge is purely proportional — there is no fixed base fee or
     minimum, so a 0 kg order (or products with no weight set) ships free.

## Save and test

Save the method, then place test orders of different weights and confirm the
shipping charge scales as expected (rate × weight). Make sure your products
actually have weights set, otherwise the computed cost will not reflect them.

## Scoping the method

As with any Commerce shipping method, you can combine it with shipping conditions
(zones, order constraints) to control when it is offered, and you can run it
alongside flat-rate or other methods so checkout presents the right choices.
