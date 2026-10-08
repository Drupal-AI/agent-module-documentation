# Configuration

There is no separate settings page for this module. You configure a giveaway by
creating (or editing) a **Commerce Promotion** and choosing the **Giveaway** offer
type.

## Create a giveaway promotion

1. Go to **Commerce → Promotions** and click **Add promotion**
   (`/promotion/add`).
2. Give the promotion a **name** and, if relevant, restrict it to a store and set
   start/end dates.
3. In the **Offer** section, choose the offer type **Giveaway**.
4. Configure the Giveaway offer fields:
   - **Giveaway** — the **product variation** to add to the order, selected via an
     entity autocomplete. This is the free (or discounted) item the customer
     receives.
   - **Quantity** — how many units of that variation to add.
   - **Show price** — choose how the giveaway appears on the order:
     - *Override the order item price with 0* — the item is added at zero price,
       with no separate adjustment shown, so it simply reads as free.
     - *Show the list price and subtract it as an order adjustment* — the item
       keeps its normal list price and an equal "Giveaway" adjustment is
       subtracted, so the discount is visible on the order summary.
5. Add **conditions** — for example a minimum order total, or that specific
   products are in the cart — to control when the giveaway applies.
6. Optionally attach a **coupon** and/or set **usage limits** to control who can
   claim it and how often.
7. Save the promotion.

## How it behaves

- When the promotion's conditions match, the giveaway item is added to the order
  **once** (a marker is stored in the order data so it isn't added repeatedly).
- If the order changes so the promotion no longer applies, the giveaway item is
  **removed automatically** on the next order refresh.
- Promotion usage is registered when the order is placed — including for the
  zero-priced case — so your usage limits are respected.

## Preventing abuse

The giveaway product and quantity come entirely from this promotion's
configuration, not from anything the customer submits, and everything runs
server-side inside Commerce's promotion engine. A customer cannot change the item,
its quantity, or stack it beyond the limits you set. The controls that matter are
therefore the promotion's own **conditions, coupon, and usage limits** — set these
to bound how often and by whom the giveaway can be claimed.
