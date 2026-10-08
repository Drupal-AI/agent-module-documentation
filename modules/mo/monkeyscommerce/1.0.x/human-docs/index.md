# MonkeysCommerce — manual setup guide

**MonkeysCommerce** (`monkeyscommerce`) is a modern, API-first commerce suite for
Drupal 11.3+ and Drupal 12. Rather than a single module, it is a whole stack —
catalog, cart, checkout, orders, payments, shipping, tax, inventory and
promotions — built on an **event-sourced** architecture, where every change to an
order is stored as an immutable event, and offering **dual rendering** through
both Twig templates and a JSON:API / REST storefront so you can build a
traditional or a headless store.

The `monkeyscommerce` package is the umbrella; the real functionality is
delivered by a family of `mkc_*` submodules that you enable as needed. The
foundation is **`mkc_core`** (multi-store resolution, sales channels, GDPR consent
and PII redaction, audit logging) — the base module depends on it. On top of that
sit `mkc_catalog`, `mkc_cart`, `mkc_checkout`, `mkc_order`, `mkc_inventory`,
`mkc_shipping`, `mkc_payment`, `mkc_tax`, `mkc_promotions` and more (fifteen in
all). Payment gateways, tax providers, shipping-rate providers and promotion
rules are all annotation-based plugins, so you can add new ones without touching
core.

Because this is a large framework rather than a drop-in feature, plan your build
around which submodules you actually need. There is no single settings page to
fill in on enable; configuration happens per subsystem (stores, product types,
payment gateways, tax zones, shipping zones and so on) as you turn each submodule
on. Any payment or provider **API credentials should be stored as secrets**
(environment-backed), never committed to the repository.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Heads-up:** at the time of writing this project does **not** have Drupal
> security-advisory coverage. Weigh that before using it on a production store,
> and keep it updated yourself.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   base plus the submodules you need.

There is no single global configuration form for the suite, so this guide has no
separate Configuration page. Each subsystem is configured through its own admin
screens once its submodule is enabled (see "How to set it up" below).

## How to set it up

1. Install the suite with Composer and enable the base module, which brings in
   **`mkc_core`** (see [Installation](installation/index.md)).
2. Enable the submodules for the capabilities you need — for example
   `mkc_catalog` for products, `mkc_cart` and `mkc_checkout` for the shopping
   flow, `mkc_order` for the event-sourced order lifecycle, and `mkc_payment`,
   `mkc_shipping` and `mkc_tax` for money handling.
3. Configure each subsystem through its own admin screens: define your store(s)
   and channels, product types, tax zones, shipping zones, and payment gateways.
4. Choose your front end — themeable Twig checkout templates for a traditional
   store, or the storefront REST/JSON:API (with Server-Sent Events for real-time
   cart and inventory updates) for a headless build.

## A note on payments and webhooks

The `mkc_payment` submodule provides a **gateway plugin system** that supports
authorize, capture, refund and webhook handling, with an **idempotency guard**
that prevents the same payment being processed twice (guarding against double
charges). Payment gateways call provider APIs directly through Drupal's built-in
Guzzle HTTP client rather than bundling heavy vendor SDKs. The exact
callback-verification behaviour — such as whether a given provider's webhook
signature is checked before an order is advanced — depends on the individual
gateway plugin you enable, so review the plugin you intend to use and store its
API credentials as environment-backed secrets. Serve the storefront and any
webhook endpoints over HTTPS.
