# Basic Cart — manual setup guide

**Basic Cart** (`basic_cart`) is a lightweight shopping cart and checkout for small
Drupal sites that want to take simple orders without the weight of a full commerce
platform. You mark one or more of your existing content types as "buyable"; the
module then gives each of those nodes an **Add to cart** button (optionally with a
quantity selector). Visitors add items to a per‑visitor cart, review it at `/cart`,
and complete an order at `/checkout` — which records the order as a node and emails
the site admin (and, optionally, the customer).

There is no product entity to learn: any content type — "Product", "Tour", "Ticket"
— becomes sellable just by enabling it in the settings, at which point the module adds
the add‑to‑cart field (and an optional price field). The cart lives in the visitor's
session by default, or in a database table if you prefer. Two blocks show the cart
contents and a live item count. Checkout collects the customer's address, phone,
email, and a message, and stores everything as a **Basic Cart Order** node so staff
can review orders later.

Order notification emails are fully templated — you set the admin recipient list and
both email bodies, and can drop in tokens (including a rendered list of the ordered
products). Currency, price/VAT display, all button and page labels, and a
post‑add‑to‑cart redirect are configurable. A Drush command (and a bulk node action)
can switch on "add to cart" across every node of your enabled types at once. The
module requires the **Telephone** and **Entity Reference Quantity** modules.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (with its required
   modules) and enable it.
2. [Configuration](configuration/index.md) — the cart and checkout settings, the
   order content type, email templates, and the permissions.

## Where it lives in the admin menu

The two settings forms are at **Configuration → Basic Cart**: cart settings at
`/admin/config/basic-cart/settings` and checkout/email settings at
`/admin/config/basic-cart/checkout` (both require the **Administer cart**
permission). Shoppers use `/cart` and `/checkout`; orders are listed with the
bundled orders View.

## How to use it

1. On the cart settings form, choose the **content types** you want to sell. Enabling
   a type automatically adds the add‑to‑cart (and price) field to it.
2. Set your currency, labels, and display options; set up the notification emails on
   the checkout settings form.
3. Grant the **Use cart** permission to the shoppers (anonymous and/or authenticated)
   who should be able to add to cart and check out.
4. Visitors browse your buyable content, click **Add to cart**, review `/cart`, and
   place an order at `/checkout`. Each order becomes a Basic Cart Order node and
   triggers the admin (and optional customer) email.

See [Configuration](configuration/index.md) for the full field‑by‑field details.
