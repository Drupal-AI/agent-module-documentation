# Configuration

Commerce Repeat Order is light to configure, but the details matter for both
correctness and security.

## Choose the cart behaviour

The module lets an administrator choose what happens to the cart when a customer
repeats an order:

- **Replace the existing cart** — clear whatever is in the cart and load the
  repeated order's items in its place, or
- **Add to the existing cart** — append the repeated order's items to whatever is
  already there.

Pick the option that matches how your customers reorder. "Replace" suits a clean
"buy this again" action; "add" suits building up a larger order from several past
orders.

## Place the repeat-order link

There is no automatic button; you add a link that points at the repeat-order route
with the order ID, for example in an order-history template, a view, or a custom
block. Conceptually the link targets `commerce-repeat-order/{order_id}`, where
`{order_id}` is the order to repeat.

The module validates ownership: a customer repeating an order must own it — one
customer cannot load another customer's order into their cart through this route.

## Permission and the ownership check

- The module defines the permission **`commerce repeat order admin access`**. Grant
  it deliberately — note that it covers **administration**, not the per-order "does
  this order belong to the person asking" decision.
- **Ownership is the check that matters.** Make sure the links you expose only ever
  point a customer at their **own** past orders (for example by rendering them only
  in that customer's order history), so the feature can't be used to peek at or
  replay someone else's order.

## Watch out for a changed catalogue

Repeating an old order raises the question of what "the same order" means when the
catalogue has moved on. Before relying on this on a catalogue that changes, confirm
how the module behaves when an item has been **discontinued**, has **changed
price**, is **out of stock**, or has had its **variations restructured** — so
customers don't silently get the wrong cart or an outdated price. If the real need
is recurring delivery rather than convenient reordering, consider a subscriptions
module instead.
