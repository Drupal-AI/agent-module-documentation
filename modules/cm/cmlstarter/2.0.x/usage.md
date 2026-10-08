<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CML Starter is a Drupal Commerce starter kit that installs the fields, taxonomies, views, image styles, path patterns, blocks and paragraph types needed for a basic online shop, and provides the product field structure that 1C/CommerceML exchange modules build on.
---
The 2.x major targets Drupal core `^11 || ^12`. On install it bootstraps an opinionated Commerce catalog: `cmlstarter_install()` creates a default `commerce_store` (US/USD, or RU/RUB when the site language is Russian) if none exists, and imports a set of `product_options` taxonomy terms from bundled YAML under `config/content/<lang>/`. Its `config/install` directory ships a `product` commerce_product type and `variation` variation type, taxonomy vocabularies (`catalog`, `brand`, `product_options`), a `product_param` paragraph type, dozens of product fields (image, gallery, article, related products, metatag, price prefix, attach, etc.), image styles, responsive image styles and form/view displays; `config/optional` adds catalog/brand/product views, catalog/product/related blocks, a RUB currency and pathauto patterns (installed only when their providers are present). It depends on a broad stack: Commerce (commerce_product), Paragraphs, CSHS, TVI, Image Effects, Colorbox, Field Group, Metatag, Responsive Image and Focal Point.

Operationally the module changes catalog browsing behavior. A `RouteSubscriber` (priority -500) overrides the controller of `entity.taxonomy_term.canonical` so that `catalog`, `brand` and `product_options` terms render an embedded `product` view display (`embed`, `embed_1`, `embed_2`) instead of the standard term page; the swapped controller name is passed through a `hook_cmlstarter_taxonomy_route` alter so other modules can substitute their own. It also adds a "Product has taxonomy term ID (with depth)" views argument and filter (`taxonomy_index_tid_product_depth`) that resolves term hierarchy against a configurable product reference field (default `field_product_category`) via a subquery, letting catalog listings match child terms by depth without a taxonomy_index table.

Setup is essentially: install the dependency stack, enable the module (which provisions the store, catalog structure and views), then adjust the generated commerce_product fields, image styles and views to fit the shop. The taxonomy-term route override and the depth argument/filter are the main behavioral hooks to be aware of when theming term pages or building catalog listings. The shipped field structure is intentionally the contract that the companion cmlapi/cmlexchange/cmlmigrations modules rely on for 1C exchange.
---
- Bootstrap a Drupal Commerce catalog on Drupal 11/12 with one module enable
- Provision a default commerce_store on install (US/USD or RU/RUB by language)
- Import bundled product_options taxonomy terms from config/content YAML
- Get a ready-made `product` commerce_product type and `variation` variation type
- Install catalog, brand and product_options taxonomy vocabularies
- Add the `product_param` paragraph type for product parameters/specs
- Attach product fields: image, gallery, article, related products, metatag, price prefix
- Install product/catalog/brand image styles and responsive image styles
- Get catalog, brand and product views plus catalog/product/related blocks
- Apply pathauto URL patterns for product pages
- Render catalog term pages as an embedded product view (display `embed`)
- Render brand term pages as an embedded product view (display `embed_1`)
- Render product_options term pages as an embedded product view (display `embed_2`)
- Override the taxonomy term canonical controller for shop term bundles
- Swap the term-page controller from another module via hook_cmlstarter_taxonomy_route
- Filter a product view by taxonomy term with hierarchy depth
- Use a contextual filter (argument) to list products under a term and its children
- Point the depth argument/filter at a custom product reference field
- Treat multiple term arguments as OR with the depth argument (1+2+3 syntax)
- Provide the base product field schema for 1C/CommerceML exchange (cmlapi, cmlexchange)
- Build a storefront demo/reference site quickly
- Extend the shipped views to add facets, sorting or exposed filters
- Localize the store address and currency by installing in Russian
- Use Colorbox + Focal Point image handling for product galleries out of the box
