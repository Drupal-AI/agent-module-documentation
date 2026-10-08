# Commerce Better Product Variation Label — manual setup guide

**Commerce Better Product Variation Label** (`commerce_better_product_variation_label`)
improves the labels/titles that Drupal Commerce generates for **product
variations**. By default a variation's label can be terse or ambiguous once it
appears in a cart, an order, or the admin lists; this module makes those titles
read more clearly. It depends only on Commerce Product (`commerce_product`).

Its main feature is prefixing a variation's label with its **parent product's
label**, for the variation types you choose — so instead of a bare variation
title you get something like "*Product name* – variation". The module also
provides a `:label` token for `commerce_product_variation` that yields this
generated label, which you can use in place of the default `:title` token wherever
you build strings with tokens. It changes only how variation titles are
presented; it has no effect on content access or permissions.

This is a small, presentation‑only helper. There is **no central settings page** —
the behaviour is applied per variation type, so you turn it on for the variation
types where you want the improved label rather than site‑wide from one form. Each
product‑variation type's edit form gains a **"Commerce Better Product Variation
Label settings"** section with a checkbox ("Use parent product label as prefix")
and a **prefix separator** field (default: a single space, e.g. change it to
`" - "` or `":"`). The prefix is only applied when the parent product's label and
the variation's own label differ.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no dedicated configuration page** for this module. The improved label
is enabled for the variation types you choose (see "How to use it" below), and
the `:label` token is available immediately.

## Where it lives in the admin menu

The module adds no admin page of its own. Product‑variation types are managed
under **Structure → Commerce → Product variation types**, and that's where the
variation‑type‑level behaviour applies.

## How to use it

1. Decide which product‑variation types should carry the improved, product‑prefixed
   label.
2. For those variation types, the module prefixes each variation's label with the
   parent product label.
3. Where you previously used the `:title` token for a variation, use the new
   `:label` token instead to output the generated label — for example in patterns
   or automatic titles.

Because it only changes how titles are generated, you can enable it, review how
variations now read in carts, orders, and admin lists, and adjust which variation
types use it.
