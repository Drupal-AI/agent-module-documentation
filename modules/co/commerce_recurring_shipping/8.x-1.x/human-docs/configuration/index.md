# Configuration

Commerce Recurring Shipping does nothing until you tell it which subscription types
should carry shipping. The setup is short but has a few prerequisites that must all
be true for shipping to actually appear on renewals.

## Make a subscription type shippable

1. Log in as a user who can administer Commerce configuration.
2. Go to **Commerce → Subscriptions → Settings**.
3. Select the **subscription type(s)** you want to be shippable.
4. Save.

Once a subscription type is marked shippable, its subscription bundle gains **two
additional shipping-related fields**, and all **new recurring orders** created for
that type will receive shipments and shipping adjustments.

## Prerequisites for shipping to work

For shipping to appear and be charged correctly on renewals, make sure that:

- The relevant **order types support shipping** (Commerce Shipping must be enabled
  on the recurring order type).
- The **product variations** (the purchasable entities) being subscribed to are
  themselves **shippable** (they have a shipping/dimensions setup).

If either of these is missing, marking the subscription type shippable will not
produce shipments.

## Test it

Create a new subscription of a shippable type and let it generate a recurring
order (or trigger a renewal). Confirm the recurring order has a shipment and a
shipping adjustment reflecting the customer's shipping preferences. Note that these
changes apply to **new** recurring orders — existing subscriptions created before
you enabled shipping may need to be revisited.
