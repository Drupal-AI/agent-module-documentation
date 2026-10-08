# Configuration

Commerce Donation Flow is configured from a central donation‑settings page, plus
the standard Commerce building blocks it tailors. Because the module's own
documentation deliberately points you to the on‑page guidance rather than listing
fixed field labels, this page describes the pieces you will be wiring together
rather than pretending every field has a fixed name.

## Start at the donation settings page

1. Log in as a user with permission to administer the donation configuration.
2. Go to **Administration → Commerce → Configuration → Donation settings**
   (`/admin/commerce/config/donation-settings`).
3. Follow the guidance on that page — it walks you through completing the setup
   for your chosen scenario (donations only, donations alongside a store, or a
   separate donation process).

## The pieces you are configuring

- **Donation order item** — a Commerce order item type pre‑configured with the
  fields a donation needs (notably the amount). This is what a donation becomes
  in an order, in place of a product variation.
- **Checkout flows** — the module provides two customised checkout flows that
  extend Commerce's standard checkout, streamlined so a donor reaches payment
  without the full cart/product experience. Assign the flow you want to your
  donation order type under Commerce's checkout‑flow configuration.
- **Checkout panes** — donation‑specific panes collect the donation data into the
  order item during checkout. Enable and order them on the checkout flow you use.
- **Donation amount widget** — an AJAX‑powered widget for the Commerce Price
  field that presents a range of suggested donation amounts and lets the donor
  switch between one‑time and monthly giving. Configure it as the widget for the
  amount field on the donation form, and set the suggested amounts you want to
  offer.
- **Quick‑donation block** — a block that pre‑populates an amount and takes the
  donor straight to the payment details step. Place it in a region (for example
  on a campaign page) via **Structure → Block layout**.

## Pair it with a payment gateway

Donation Flow shapes the experience but does not move money. Add and configure a
Commerce **payment gateway** at **Administration → Commerce → Configuration →
Payment gateways** to actually take donations. The security of the transaction —
verifying the payment result server‑side — lives in that gateway, so pick one
that confirms its callbacks properly. If you want **monthly** donations, choose a
gateway that supports recurring payments.

## Permissions

The module provides its own permission for administering the donation
configuration. Grant it (under **People → Permissions**) only to the roles that
should manage donation settings.
