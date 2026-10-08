<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CML Starter — setup & install behavior

## What enabling the module does
1. Requires the full dependency stack first (Commerce, Paragraphs, CSHS, TVI, Image Effects, Colorbox, Field Group, Metatag, Responsive Image, Focal Point).
2. `config/install/*` provisions: `commerce_product` type `product`, variation type `variation`, vocabularies `catalog`/`brand`/`product_options`, paragraph type `product_param`, product fields (image, gallery, article, short, title, price prefix, related products/category, metatag, attach, tx options, paragraph), image styles and responsive image styles, form/view displays.
3. `config/optional/*` adds catalog/brand/product views, catalog/product/related blocks, a RUB currency, term view/form displays and a product pathauto pattern (installed only when their providers are present).

## Install hook side effects (`cmlstarter.install`)
- Creates a **default commerce_store** if none exists. Language `ru` → "Example Store", RUB, Moscow address; otherwise "US Store", USD, Greenville SC address. Store mail is `admin@example.com` — change it post-install.
- Imports `product_options` **taxonomy terms** from `config/content/<lang>/taxonomy_term.product_options.yml` (throws `InvalidArgumentException` if the language file is missing/unreadable).

## Catalog term pages
The module replaces the default taxonomy term page for shop bundles with an embedded product view:
- `catalog` → view `product`, display `embed`
- `brand` → view `product`, display `embed_1`
- `product_options` → view `product`, display `embed_2`
- any other bundle → normal `full` term render.

To substitute your own controller, implement `hook_cmlstarter_taxonomy_route(&$controller)`.

## Typical post-install tasks
- Update store name/mail/currency/address for production.
- Adjust the generated product fields and image styles.
- Extend the shipped `product`/`catalog`/`brand` views (facets, sorting, exposed filters).
