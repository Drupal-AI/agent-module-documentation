# Commerce Measurement — manual setup guide

**Commerce Measurement** (`commerce_measurement`) adds a set of **Drupal Commerce
conditions based on physical measurements** — an order's weight, volume, and
similar physical properties. Once enabled, these conditions become available
anywhere Commerce Core supports conditions: promotions, shipping methods, payment
gateways, and other condition-aware entities.

Concretely, it lets you build rules against per-product-variation measurement
fields (weight, volume, and so on) and their values, and it also provides a
condition based on the **total measurement** across the entire order. So you can,
for example, offer a promotion only when an order weighs over a threshold, or
restrict a shipping method to orders within a certain volume.

The measurement values themselves come from your product and order data via the
**Physical** module (`physical`), which provides physical-field types. Commerce
Measurement simply reads those fields and exposes them as conditions — it has no
settings page of its own and no access-control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Physical dependency.

There is **no configuration page** for this module. It adds condition plugins that
you use inside other Commerce forms (see "How to use it" below), rather than a
central settings form.

## Where it lives in the admin menu

Commerce Measurement adds no admin page. You use its conditions from within the
condition UI of the feature you're configuring — for example, when editing a
promotion at **Commerce → Promotions**, or a shipping method under
**Commerce → Configuration → Shipping methods**.

## How to use it

1. Make sure your product variations carry the relevant **Physical** field(s) —
   weight and/or volume — so there is a measurement to evaluate.
2. Edit a condition-aware entity (a promotion, shipping method, or payment
   gateway).
3. In its **Conditions** section, enable one of the measurement conditions — a
   per-variation measurement condition or the **order total measurement**
   condition — and set the value to compare against (for example, "total weight
   is greater than 5 kg").
4. Save. The condition is now evaluated against each order's measurement data.
