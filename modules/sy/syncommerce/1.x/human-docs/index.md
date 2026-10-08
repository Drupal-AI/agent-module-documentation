# SynCommerce — manual setup guide

**SynCommerce** (`syncommerce`) provides a custom, JavaScript-driven admin screen
for browsing and editing **Drupal Commerce** products and their variations,
backed by a small set of JSON endpoints. It is meant as a fast, staff-facing tool
for bulk product editing — a single screen where you can filter the catalog and
change product and variation details inline, rather than opening each product's
own edit form.

The screen lives at `/syncommerce/products` and hosts a front-end app that talks
to three POST JSON endpoints: a **product listing** (paged and filterable by
article number, title and catalog term, and returning the catalog terms and
attributes too), an **update-product** endpoint (saves a product's title,
article, catalog term and published status), and an **update-variation** endpoint
(saves a variation's price, old/compare-at price, stock quantity, attribute
references and status). The module bundles its own compiled CSS/JS and Twig
templates for the editing UI. It depends on the Commerce module and supports
Drupal 9, 10 and 11.

All four routes — including the two that *change* data (`updateProduct` and
`updateVariation`) — use the `access content` permission as their route
requirement. The module also defines an `administer syncommerce configuration`
permission. The module is currently marked *not covered* by Drupal's security
advisory policy.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Once enabled — and once you have restricted its routes as described above — open
**`/syncommerce/products`**. You get an editing screen where you can filter
products by article number, title or catalog term, page through the list, and
edit product fields (title, article, catalog, published status) and variation
fields (price, old price, stock, attributes, status) inline. Changes are saved
straight back to the underlying Commerce product and variation entities. Treat it
as an editor tool for trusted staff only.
