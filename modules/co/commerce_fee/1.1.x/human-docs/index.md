# Commerce Fee — manual setup guide

**Commerce Fee** (`commerce_fee`) gives Drupal Commerce a user interface for
defining **fees** — surcharges added to an order under configurable conditions.
Think of it as the mirror image of Commerce **promotions**: a promotion is an
offer plus conditions applied as a *negative* adjustment, while a fee is the same
machinery pointing the other way — a *positive* adjustment for a card surcharge, a
small‑order handling charge, a remote‑delivery surcharge, a booking fee, an
environmental levy, and so on.

Without this UI, each of those fees has to be built as a custom order processor
with its conditions written in code, and a developer is needed every time an
amount changes — even though fees are commercial decisions that finance, not
engineering, tends to own. Commerce Fee supplies the interface instead: you can
add fixed or percentage fees, apply them conditionally (by order total, payment or
shipping method, user role or customer profile, or custom plugin logic), stack
multiple fees on an order, and have them appear in the order summary as order
adjustments. It requires `commerce`, `commerce_order`, `inline_entity_form` and
core's `options` module, and is compatible with Drupal Commerce 2.x and 3.x.

Three things worth knowing are about fees rather than about the module. **Tax
treatment is jurisdiction‑specific and is not the module's job** — whether a fee is
itself taxable, and at what rate, is a question for your site's tax configuration
and your accountant, and getting it wrong is a compliance problem. **Disclosure is
regulated** in many markets — surcharges that appear only at the final step are
restricted or banned, and card surcharges specifically are capped or prohibited in
the EU and elsewhere — so *when* a fee becomes visible is a legal question. And
**order adjustments must be reproducible** — a fee whose condition later changes
must not silently rewrite historic orders, so adjustments are stored on the order
rather than recalculated at display time.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

There is **no single settings form** for this module. You work with it by creating
and editing individual **fee** entities — much like Commerce promotions — described
in "How to use it" below.

## Where it lives in the admin menu

Commerce Fee adds a fee‑management UI under Commerce's configuration, alongside
promotions (**Administration → Commerce → Configuration → Fees**). This is a
listing where you add, edit and delete individual fees, not a page of global
settings.

## How to use it

Because a fee mirrors a promotion, the workflow will feel familiar if you have used
Commerce promotions:

1. Go to the **Fees** admin listing under Commerce configuration and click to add
   a new fee.
2. Give the fee a name and choose its **offer** — a **fixed amount** or a
   **percentage** to add to the order.
3. Add **conditions** that decide when the fee applies — for example a specific
   **payment method** (a card surcharge), a **shipping method** (a delivery
   surcharge), an order **total** threshold (a small‑order handling fee), or a
   **user role / customer profile**. For anything the built‑in conditions don't
   cover, custom condition plugins can be added in code.
4. Save. Matching orders now carry the fee as an **order adjustment**, visible in
   the order summary. Fees can be applied automatically by their conditions or
   triggered by custom code.

Before going live with a fee, revisit the three points above: confirm its tax
treatment with your accountant, make sure it is disclosed early enough to satisfy
the rules in your market, and check that adjustments are recorded on the order so
historic orders stay accurate.
