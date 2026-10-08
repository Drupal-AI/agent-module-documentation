# Configuration

Commerce Product Type Fees is configured from a single settings form provided by the
module under **Commerce → Configuration**. You need the permission to administer
Commerce configuration to reach it.

## Add fees to a product type

1. Open the module's fee settings form under **Commerce → Configuration**.
2. Choose the **product type** you want to charge a fee on.
3. Add one or more **percentage fees**. You can add as many as you need — each is
   entered as a percentage that will be applied to the order subtotal.
4. Give each fee a clear label so it reads sensibly on the order and to the customer.
5. Save.

## How the fees are applied

Once configured, whenever a customer's cart contains a product of that type, the
fees are applied to the order **subtotal** as part of Commerce's normal
order-processing. That means:

- The calculation happens **server-side** and is authoritative — it is part of the
  real order total, not a display-only figure.
- Fees are proportional (a percentage), so they scale with the order subtotal.

## Tips

- Add fees per product type rather than per product — if you need a charge on just
  one product, consider whether a dedicated product type or a Commerce promotion
  fits better.
- Test with a real order after configuring: add a product of the affected type to
  the cart and confirm the fee and resulting total are what you expect, including
  when the cart mixes affected and unaffected products.
