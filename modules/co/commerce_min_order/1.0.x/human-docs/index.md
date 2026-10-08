# Commerce Minimum Order — manual setup guide

**Commerce Minimum Order** (`commerce_min_order`) enforces a **minimum order
amount** on the Drupal Commerce cart. Until the cart total reaches the minimum you
set, the checkout button is disabled and checkout is blocked — and shoppers see a
progress meter telling them how much more they need to add. It's the classic tool
for wholesale minimums or simply avoiding low-value orders that aren't profitable
to fulfil.

The minimum is set **per store**, so a multi-store site can require different
thresholds for different stores. On the standard cart page, the module injects a
themed progress element showing the current total, the minimum, the remaining
amount, and a percentage; while the total is below the minimum, it disables the
checkout action and adds a submit-time validation error with the formatted
shortfall — so even if someone re-enables the button in their browser, the server
still refuses to proceed.

Setup is unusual in one way: rather than a settings form, the minimum is driven by
a **field you add to your Store entity** (see below). The module has no admin
settings page, no permissions, and no routes — it's pure cart form logic. It
depends on Drupal Commerce, Commerce Cart, and Commerce Order, and targets
**Drupal 9, 10, and 11**. Note it is **not covered by Drupal's security advisory
policy**. It doesn't ship styling for the progress bar (it is Bootstrap-friendly);
you can theme it with a Twig template in your custom theme.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — you set the minimum by adding
a field to your Store type, described under "How to set the minimum" below.

## Where it lives in the admin menu

Commerce Minimum Order adds no admin page. You configure it on your **Store type**
at **Commerce → Configuration → Store types**
(`/admin/commerce/config/store-types`), by adding and populating the
`field_store_min_order` field.

## How to set the minimum

1. Go to **Commerce → Configuration → Store types** and manage the fields of your
   store type.
2. Add a new field with the machine name **`field_store_min_order`** and the field
   type **Number**. The machine name must match exactly — that's how the module
   finds the minimum.
3. Edit each **Store** (**Commerce → Stores**) and set its minimum order amount in
   that field. Different stores can have different minimums; a store with no value
   simply has no minimum.

Once the field is set, the cart enforces the minimum automatically — the progress
meter appears and checkout is blocked until the total is reached.

## Styling the progress bar (optional)

The module themes a `commerce_min_order_progress` element but ships no CSS of its
own. It works with Bootstrap out of the box; to customize its appearance, add a
Twig template override for the progress element in your custom theme.
