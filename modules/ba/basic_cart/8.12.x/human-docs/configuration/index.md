# Configuration

Basic Cart has two settings forms — **Cart settings** and **Checkout settings** —
both under **Configuration → Basic Cart** and both requiring the **Administer cart**
permission. Together they control what you sell, how the cart looks, and how order
emails are sent.

## Cart settings

Go to **Configuration → Basic Cart → Settings**
(`/admin/config/basic-cart/settings`).

### Buyable content types

- **Content type** — the content types enabled for selling. Ticking a type
  automatically adds the **Add to cart** field (and a price field) to it, and adds a
  display for the cart view mode. This is the key setting — nothing is sellable until
  you enable at least one type here.

### Price, quantity, VAT, and currency

- **Quantity status / Quantity label** — show a quantity selector and label it.
- **Price status / Price label** — show item prices and label them.
- **Total price status / Total price label** — show the cart total and label it.
- **Currency status / Currency** — show a currency symbol; the currency code defaults
  to `INR`, so set it to your own (e.g. `USD`, `EUR`).
- **Price format** — how prices are formatted.
- **VAT state / VAT value** — apply a VAT rate to the order total.

### Buttons, titles, and messages

Labels for the add‑to‑cart button, cart page title, empty‑cart text, cart block
title, view‑cart button, update button, "cart updated" and "added to cart" messages,
checkout page title, place‑order button, and cart button. Set these to match your
site's wording.

### Behaviour

- **Add to cart redirect** — a path to send the shopper to after they add an item
  (used by the "direct" add‑to‑cart route).
- **Use cart table** — off by default (carts live in the session); turn on to store
  carts in a database table instead.
- **Cart items linked**, **cart item view modes**, and **order status** — additional
  display and workflow options for cart items and orders.

## Checkout settings

Go to **Configuration → Basic Cart → Checkout**
(`/admin/config/basic-cart/checkout`).

- **Admin emails** — a newline‑separated list of admin recipients for order
  notifications. Leave empty to use the site email.
- **Admin subject / Admin body** — the notification email sent to the admin when an
  order is placed.
- **Send email to user** — off by default; turn on to also send the customer a
  confirmation, using the **User subject / User body** templates.
- **Thank‑you page** — the title, text, and optional custom page shown after an order
  is placed.

### Email tokens

The email bodies accept tokens, including standard ones like `[node:title]` and
`[site:name]`, plus the module's own `[basic_cart_order:*]` tokens — for example
`[basic_cart_order:products]` (renders the list of ordered items),
`[basic_cart_order:basic_cart_total_price]`, and `[basic_cart_order:basic_cart_email]`.
Use these to build a useful order confirmation.

## The order content type

Enabling the module installs a **Basic Cart Order** (`basic_cart_order`) content type
with fields for address, city, zip code, phone, email, message, VAT, total price, and
a reference (with quantities) to the ordered products. Each checkout creates one of
these order nodes, and the bundled **Basic Cart orders** View lists them for staff.

## Permissions

- **Use cart** — the front‑end cart and checkout (`/cart`, `/checkout`, the add/remove
  routes, `/thankyou`). Grant to the shoppers (anonymous and/or authenticated) who
  should be able to buy.
- **Create direct orders** — the direct order form at `node/add/basic_cart_order`
  (create an order without going through the cart). The project README recommends
  restricting this to admins.
- **Administer cart** — the two settings forms above.
- **View orders** — viewing the Basic Cart orders listing/View.

> **Note.** The cart add/remove routes are simple permission‑gated links that change
> only the visitor's **own** session cart, so there is no CSRF token on them — this is
> expected for a lightweight cart, and the impact is limited to the caller's own cart.
> Notification recipients are set by an admin, not taken from request input.
