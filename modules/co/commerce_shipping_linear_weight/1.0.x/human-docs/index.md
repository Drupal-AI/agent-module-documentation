# Commerce Shipping Linear Weight — manual setup guide

**Commerce Shipping Linear Weight** (`commerce_shipping_linear_weight`) is a
Drupal Commerce shipping method that prices shipping **linearly by the weight of
the order**. You set a rate per kilogram, and the shipping cost scales
proportionally with the order's total weight. For example, at 2 €/kg a 2 kg order
is charged 4 €. The module assumes **all weights are in kilograms**.

It suits stores whose shipping cost tracks weight rather than a flat fee or cart
value. It plugs into Commerce Shipping as a shipping-method plugin, so the
computed rate flows through Commerce's normal order handling. It depends on
**Commerce Shipping** (`commerce_shipping`), adds no permissions or access role of
its own, and supports **Drupal 8, 9, 10, and 11**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add a linear-weight shipping method
   and set the per-kilogram rate.

## Where it lives in the admin menu

You configure it as a shipping method under **Administration → Commerce →
Configuration → Shipping methods** (`/admin/commerce/shipping-methods`): add a
shipping method that uses the **Linear Weight Shipping** plugin. See
[Configuration](configuration/index.md).
