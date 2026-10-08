# CML Starter — manual setup guide

**CML Starter** (`cmlstarter`) is a Drupal Commerce **starter kit**. Enabling it
provisions, in one step, the whole structure a basic online shop needs: a `product`
commerce product type and a `variation` variation type, catalog/brand/product‑option
taxonomies, a product‑parameters paragraph type, dozens of product fields (image,
gallery, article, related products, metatag and more), image styles and responsive
image styles, catalog/brand/product views, blocks, and pathauto URL patterns. It
even creates a default commerce store on install.

It solves the "blank Commerce site" problem — instead of hand‑building the catalog
structure field by field, you get an opinionated, ready‑made shop scaffold to build
on. It's also the **structural foundation that the CML/1C exchange modules expect**:
[CML Migrations](https://www.drupal.org/project/cmlmigrations),
[cmlmerchant](https://www.drupal.org/project/cmlmerchant) and friends map their data
onto the fields this module installs.

This is a **works‑on‑enable feature module** — there's no settings form. The
important consequence of enabling it is that it changes two behaviors you should
know about. First, on install it creates a default `commerce_store` (US/USD by
default, or RU/RUB when the site language is Russian) with a placeholder address and
the mail `admin@example.com` — you'll want to update those for production. Second, it
**overrides catalog term pages**: `catalog`, `brand` and `product_options` taxonomy
terms render an embedded product view instead of the standard term page. It also
adds a Views argument/filter, "Product has taxonomy term ID (with depth)", for
listing products under a term and its children.

Be aware this pulls in a **broad dependency stack** — Commerce, Paragraphs, CSHS,
TVI, Image Effects, Colorbox, Field Group, Metatag, Responsive Image and Focal
Point — so it's a substantial addition, best installed on a fresh or
purpose‑built Commerce site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (with its full
   dependency stack) and enable the module.

There is **no configuration page** — the module provisions everything on enable. See
"How to use it" below for the post‑install tasks.

## How to use it

Enabling CML Starter does the heavy lifting; the work afterward is tuning what it
generated to fit your shop:

1. **Update the default store.** Go to **Commerce → Configuration → Stores** and
   edit the store CML Starter created — set the real name, email address (it's
   `admin@example.com` by default), currency and address.
2. **Adjust the generated fields and image styles.** The `product` type comes with a
   large set of fields and several image styles; add, remove or relabel them to
   match your catalog.
3. **Extend the shipped views.** The `product`, `catalog` and `brand` views are a
   starting point — add facets, sorting or exposed filters as needed.
4. **Understand the term‑page override.** Catalog, brand and product‑option term
   pages now render an embedded product view (displays `embed`, `embed_1`, `embed_2`).
   If you need your own controller for those pages, a developer can implement
   `hook_cmlstarter_taxonomy_route()` to substitute it.
5. **Use the depth argument for catalog listings.** The "Product has taxonomy term ID
   (with depth)" Views argument/filter lets a listing match products under a term and
   all its child terms; point it at your product's category reference field (default
   `field_product_category`).

To populate a demo site quickly, pair it with
[CML Starter Demo](https://www.drupal.org/project/cmlstarter_demo).
