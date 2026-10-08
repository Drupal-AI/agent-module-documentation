# Commerce Packeta — manual setup guide

**Commerce Packeta** (`commerce_packeta`) adds a **Packeta** shipping method to
Drupal Commerce, letting customers choose a **pickup point** at checkout and
automatically submitting the completed packet to Packeta's API. Packeta is a large
Central/Eastern European pickup-point carrier, known under several names depending
on the country — **Zásilkovna** (Czech Republic), **Zásielkovňa** (Slovakia),
**Csomagküldő** (Hungary), **Przesyłkownia** (Poland), and **Coletăria** (Romania).

At checkout, the module renders Packeta's pickup-point selector widget. In this
**3.x** version the widget is integrated into the default shipping-information pane,
so the customer enters their shipping address first, then chooses Packeta as the
shipping method and picks a pickup point. The chosen pickup point is stored on the
shipment, and when the order is processed the module assembles a packet — recipient
name/email/phone from the billing profile, order number, total (and cash-on-delivery
value for COD orders), currency, and weight in kilograms — and sends it to Packeta's
SOAP API, authenticating with your configured API password.

Two practical prerequisites matter. Since 1 September 2021, Packeta's API requires a
**weight** to accept a package, so your products must have weights. And because the
packet needs a phone number, you map which **profile field** holds the customer's
phone. To help with weights, the bundled **Commerce Packeta Views**
(`commerce_packeta_views`) submodule provides a product-variation View with a bulk
operation for setting weights.

It depends on **Commerce**, **Commerce Checkout**, **Commerce Shipping**, and the
**Profile** module.

> **Upgrading from an earlier version?** 3.x is a reworked approach — verify your
> checkout flow settings and test checkout in a staging environment after updating,
> as adjustments may be needed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and (optionally) enable the Views helper submodule.
2. [Configuration](configuration/index.md) — add the Packeta shipping method, enter
   your API credentials, map the phone field, and wire the pickup-point widget into
   checkout.

## Where it lives in the admin menu

Packeta is configured as a **shipping method** under Drupal Commerce's shipping
configuration (**Commerce → Shipping methods**), using the *Packeta* plugin. There
is no separate top-level settings page — all of its settings live on the shipping
method itself.
