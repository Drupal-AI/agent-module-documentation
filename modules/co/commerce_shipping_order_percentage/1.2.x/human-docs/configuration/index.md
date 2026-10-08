# Configuration

You configure this module by adding a shipping method that uses the "Percentage
of Order value" plugin.

## Add a percentage shipping method

1. Go to **Commerce → Configuration → Shipping methods**
   (`/admin/commerce/shipping-methods`) and click **Add shipping method**.
2. Choose the **Percentage of Order value** plugin.
3. Fill in the fields:

- **Rate label** *(required)* — the label shown to the customer when they pick
  this rate (for example "Direct to your door").
- **Percentage** *(required)* — the percent of the order subtotal to charge.
  Enter it as a number, with no `%` sign; fractional values are allowed, so `10`
  or `17.5` are both valid. Defaults to 10.
- **Minimum charge** — a floor applied when the computed rate falls below it. For
  example, at 15% a 50 order would compute 7.50, but a minimum of 10 charges 10
  instead. Leave empty or enter **0 for no minimum**. Defaults to 0.
- **Maximum charge** — a cap applied when the computed rate exceeds it, so large
  orders don't pay runaway shipping. Set it to **0 (or leave it empty) to disable
  the cap**. The field defaults to 150.

When you save, the form **validates that the minimum charge is not greater than
the maximum charge** (when a maximum is set) and will show an error otherwise.

## How the rate is computed

At checkout, for a shipment that has a shipping address, the rate is
`subtotal × percentage / 100`, then clamped to the minimum/maximum bounds, priced
in the **order subtotal's own currency** and rounded using Commerce's rounding
rules. If the order has no subtotal, or the shipment has **no shipping address
yet, no rate is returned** — so the option appears once the customer has entered
an address.

## Save and test

Save the method, then test with orders of different subtotals to confirm the
percentage, floor and cap behave as you expect. You can create several
percentage methods and let checkout offer the appropriate one, and combine them
with Commerce shipping conditions to scope them to zones.
