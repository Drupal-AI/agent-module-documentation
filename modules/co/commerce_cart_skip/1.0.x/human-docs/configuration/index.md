# Configuration

Everything in Commerce Cart Skip is driven by **rules**. A rule says "when a
product variation matches these conditions, skip the cart and create an order
directly," and defines what the buyer sees while it happens. Rules are
configuration entities, so they export with the rest of your site config.

## Open the rules list

1. Log in as a user with the **`administer commerce cart skip rules`** permission.
2. Go to **Commerce → Configuration → Products → Commerce Cart Skip**
   (`/admin/commerce/config/products/commerce_cart_skip`).

You'll see the list of existing rules with **Add**, **Edit**, and **Delete**
actions. All of these forms carry Drupal's standard CSRF protection and are
restricted to holders of the permission above.

## Add a rule — the matching conditions

When you add or edit a rule, you set the conditions that decide which product
variations it applies to. You can use any or all of:

- **Product type** — restrict the rule to a particular product type.
- **Product variation type** — restrict it to a particular variation type.
- **Product variation price** — match on the variation's price (for example, to
  target only free products).
- **Whether the user is authenticated** — apply the rule only to logged‑in users,
  or only to anonymous users.

A common setup is a rule that matches a free product type so that clicking "Add"
during a registration flow immediately creates the order without a cart step.

## Add a rule — what gets created and shown

For each rule you also define:

- **The order and order item** that get created when the rule fires.
- **The buyer‑facing text** — the label on the buy‑now button, an optional
  terms‑and‑conditions link, the success message, and similar wording — so the
  express flow reads the way you want.

## What happens when a rule matches

On a product whose variation matches a rule, the normal add‑to‑cart submit is
replaced: submitting creates an order directly (no intermediate cart) and routes
the buyer to a **purchased** confirmation page for that order. That page requires
`commerce_order.view` access on the created order, so buyers only ever see their
own order, and the order id in the URL is constrained to digits. There are no
anonymous rule‑management routes.

## Tips

- **Test on staging first.** Rule matching alters the add‑to‑cart behaviour of
  real products, so confirm each rule matches exactly the variations you intend
  before enabling it in production.
- **Combine with checkout customisations** if you want a fully express flow — for
  example pairing a cart‑skip rule with a streamlined checkout for single‑item
  sales, donations, or event tickets.
