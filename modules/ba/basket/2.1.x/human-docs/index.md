# Drupal AlternativeCommerce (Basket) — manual setup guide

**Drupal AlternativeCommerce**, usually just called **Basket** (`basket`), is a
self‑contained online store for Drupal. It gives you a cart, orders, multiple
currencies, delivery and payment — but, unlike Drupal Commerce, it is built as
its own system rather than on top of the Commerce entity stack. It is aimed at
sites that want a shop without adopting (and learning) the full Commerce
framework.

Because the store logic is bespoke, Commerce knowledge does not transfer: the
cart, the order entities and their admin screens, currency handling, scheduled
maintenance (cron) and data export are all the module's own code, living under
its own admin paths. Its permission model is notably fine‑grained — order rights
are split so that, for example, you can let one person change an order's *status*
without letting them change its *financial* status.

Basket keeps its dependencies modest — core **Node**, **Token** and **Views** —
plus one that catches people out: **`scss_compiler`**. The storefront's styling
is compiled from Sass at runtime, so that separate module must be installed and
working or the shop renders unstyled. **PHP 8.1+** is required. Delivery and
payment integrations ship as separate companion projects (for example
**Basket PayPal** for payments, and a Nova Poshta carrier module), which are
expected to live under the Basket directory.

One honest caveat: in the environment where these docs were produced, `basket`
could not be enabled on a bare Drupal 11.4 site, so its runtime screens were
documented from source and install metadata rather than verified live. The most
likely cause is the `scss_compiler` requirement and the store's own install
prerequisites. Budget time to get those in place. Note too that the project's
centre of gravity is the Russian/Ukrainian Drupal community, so a good deal of
upstream documentation and UI translation is in those languages.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements (including
   `scss_compiler` and PHP 8.1+), Composer install and enabling the store.
2. [Configuration](configuration/index.md) — the order admin area, the
   fine‑grained permissions, currencies, cron/export, and adding payment/carrier
   modules.

## Where it lives in the admin menu

Basket registers its own admin area (under the **Online store** package) with
dedicated screens for orders and store settings, on the module's own paths rather
than the usual Commerce paths. See [Configuration](configuration/index.md).
