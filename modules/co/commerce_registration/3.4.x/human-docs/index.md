# Commerce Registration — manual setup guide

**Commerce Registration** (`commerce_registration`) connects the
[Registration](https://www.drupal.org/project/registration) module to Drupal
Commerce, so signing up for an event becomes a **purchasable product**. A Commerce
product becomes a registration host: adding it to the cart creates a registration,
and completing checkout confirms it — with event capacity, payment, and an optional
waitlist all handled through Commerce.

The problem it solves is that selling tickets needs two things at once.
Registration models capacity and sign-ups against a host entity; Commerce models
products, carts, and payment. Neither does the whole job alone, and this module is
the join between them. That makes it the tool for selling conference tickets,
course places, or workshop seats with limited capacity — including combining
tickets with other products in a single cart, charging different prices per
attendee type, and reporting on registrations alongside orders.

It has **substantial dependencies**: six Commerce modules (`commerce`,
`commerce_cart`, `commerce_checkout`, `commerce_order`, `commerce_price`,
`commerce_product`) plus `registration`. Its `composer.json` **pins Commerce
`^3.0`** and `registration ^3.4.2`, so a **Commerce 2 site cannot use this
release**. Two submodules cover the harder parts of real event selling:
**Waitlist** handles what happens when an event fills, and **Change Host** lets a
registration be moved to a different event or session without a refund-and-rebook.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, mind the
   Commerce 3 requirement, and enable the module and any submodules.
2. [Configuration](configuration/index.md) — turn a product into a registration
   host and manage its registration settings.

## Where it lives in the admin menu

Registration settings hang off the **product**, not a central page: manage a
product's registrations at `/product/{commerce_product}/registrations` and its
settings at `/product/{commerce_product}/registrations/settings`. Access is
governed by a custom access check that considers both the product and the user,
rather than a single flat permission.
