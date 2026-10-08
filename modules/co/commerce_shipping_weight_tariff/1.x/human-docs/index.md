# Commerce Shipping Weight Tariff — manual setup guide

**Commerce Shipping Weight Tariff** (`commerce_shipping_weight_tariff`) adds a
shipping method that calculates the shipping rate from the **total weight of an
order**. Shipping cost so often depends on weight — a heavier order costs more to
send — and Drupal Commerce's core shipping handles flat and per‑item rates but not
weight‑tiered tariffs directly. This module fills that gap, so checkout charges the
right amount for what is actually being sent. It depends on **Commerce**,
**Commerce Order**, **Commerce Price**, the **Physical** fields module, and
**Commerce Shipping**.

It lets you build a matrix of tariffs by weight band across several shipping
services — for example a "2–3 days" service and an "Express delivery" service,
each with prices for "up to 0.5 kg", "up to 2 kg", "up to 5 kg", and so on. Each
tariff band is stored as a **product entity** carrying a weight field (the maximum
weight for that band), a shipping‑service field (which service it belongs to), and
the usual Commerce price fields (the price for that band). These tariff products
are never added to the cart or referenced by nodes — their price is simply returned
to Commerce Shipping as the rate.

Two things make or break the result: the tariff bands must match your carrier's
pricing, and — crucially — **your products must carry accurate weights**, because
the rate is only as good as the weight data the calculation reads. It is a
checkout‑time calculation with no unusual security surface.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

This module has **no single settings page**. You configure it by creating tariff
products (the weight bands) and adding a weight‑tariff shipping method, described
in "How to use it" below.

## How to use it

1. **Make sure products have weights.** Every purchasable product/variation needs
   an accurate physical weight (via the Physical fields), or the rate will be
   wrong. Confirm this first — it is the operational prerequisite.
2. **Create your tariff bands.** For each shipping service and weight band, create
   a tariff product entity with: the **maximum weight** for the band, the
   **shipping service** it belongs to, and the **price** for that band. Together
   these form your weight matrix (for example: "2–3 days, up to 2 kg, £4"). Do not
   reference these tariff products from nodes or add them to the cart.
3. **Add the shipping method.** Under **Commerce → Configuration → Shipping
   methods**, add a shipping method that uses the weight‑tariff calculation.
4. **Test at checkout.** Place test orders of different total weights and confirm
   the shipping cost matches the band you configured.

> **Tip:** See the project's README for known limitations and roadmap items before
> relying on it for a complex tariff matrix.
