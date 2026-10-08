# Commerce Product taxonomy filter — manual setup guide

**Commerce Product taxonomy filter** (`commerce_product_taxonomy_filter`) brings
core's familiar taxonomy-index Views integration to **Commerce products**. Drupal
core lets you filter, relate, and argue *nodes* by taxonomy term; this module does
exactly the same for `commerce_product` entities, so you can build category pages,
faceted catalog listings, and related-product blocks driven by the terms attached
to your products — all inside the Views UI, with no code.

It works by quietly maintaining a denormalized index table that maps each product
to the taxonomy terms it references (across every term reference field and all
translations), kept in sync automatically as products are created, updated, and
deleted. On top of that index it exposes a set of Views handlers on the product
base table: a term **relationship**, an "all terms" **field**, a "Has taxonomy
term(s)" **filter** and a "Has taxonomy term ID" **contextual filter (argument)**,
plus **depth-aware** variants that include a term's child terms.

Because it reuses core's approach so closely, the UX will feel immediately
familiar to anyone who has built taxonomy-driven node listings — you're just
pointing the same tools at products instead. There's no admin page, no permissions,
and no Drush commands; everything is configured in Views.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it requires
   Commerce) and enable it.

## Where it lives in the admin menu

The module has **no settings page of its own**. Everything happens in the **Views**
UI at **Structure → Views** (`/admin/structure/views`) when you build or edit a View
of *Products*. On install it backfills the product/term index from your existing
catalog and ships an optional example View called *product_terms* you can enable and
adapt.

## How to use it

After enabling, create or edit a View of **Products** and use the new handlers:

- **Category landing page** — add a contextual filter *Product: Has taxonomy term
  ID* (or the *with depth* variant to include child terms) so the URL's term ID
  drives which products are listed.
- **Exposed category selector** — add the *"Has taxonomy term"* filter and expose it,
  so visitors can pick one or more terms.
- **Show or sort by term** — add the term **relationship**, then a term-name field.
- **Related products** — build a block that matches products sharing terms with the
  current product.

The "with depth" filter and argument include a term plus its descendants (great for
hierarchical categories), and an extra depth-modifier contextual filter lets you
adjust that depth dynamically. The whole product↔term index stays in sync
automatically — respecting core's *maintain index table* taxonomy setting — so you
never rebuild it by hand.
