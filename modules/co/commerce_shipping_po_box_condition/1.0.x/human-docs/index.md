# Commerce Shipping PO Box Condition — manual setup guide

**Commerce Shipping PO Box Condition** (`commerce_shipping_po_box_condition`)
adds a Commerce shipping **condition** that checks whether the customer's shipping
address is a **Post Office Box** or **Highway Contract Box**, and shows or hides a
shipping method accordingly. It solves a common real‑world problem: some carriers
(and some services) will only deliver to PO Boxes, while others will not deliver
to them at all. With this condition you can offer postal services *only* for PO
Box addresses, or exclude carriers that don't ship to PO Boxes. It depends on
**Commerce Shipping** (`commerce_shipping`).

The module works by inspecting the shipping address line for a PO Box or Highway
Contract Box. There is nothing global to switch on — you attach the condition to
whichever shipping methods you want it to govern, and its behaviour is per‑method.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

This module has **no settings page of its own**. It plugs in as a condition on
Commerce shipping methods, described in "How to use it" below.

## Where it lives in the admin menu

The condition appears on each shipping method's own edit form, under **Commerce →
Configuration → Shipping methods**. When you edit a method you'll find it under
**Conditions → Customer → Shipping PO Box**.

## How to use it

Use it like any other Commerce shipping condition:

1. Go to **Commerce → Configuration → Shipping methods** and edit (or add) the
   shipping method you want to gate.
2. In the method's **Conditions**, open the **Customer** group and find
   **Shipping PO Box**.
3. **Tick the box to enable the condition.** With it enabled (and not negated),
   the method is shown to the customer **only when** the shipping address contains
   a PO Box or Highway Contract Box — ideal for a postal‑only service.
4. To flip the logic, tick **Negate the condition**. Now the method is **hidden**
   whenever the address is a PO Box or Highway Contract Box — ideal for a carrier
   that refuses PO Box deliveries.
5. Save the shipping method.

Repeat per method: enable it on your postal service (not negated) and negate it on
your courier services, and each customer only sees the methods that can actually
deliver to their address.
