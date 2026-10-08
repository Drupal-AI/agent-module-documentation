<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CML Starter (cmlstarter) — agent index

**Commerce starter kit: installs Drupal Commerce product type, variation type, taxonomies (catalog/brand/product_options), paragraph type, product fields, image styles, views, blocks and pathauto patterns for a basic online store.**

- **Version:** 8.x-1.x (info.yml `8.x-1.92`)
- **Core:** ^9 || ^10 || ^11
- **Package:** cml
- **Dependencies:** commerce:commerce_product, paragraphs, cshs, tvi, image_effects, colorbox, field_group, metatag, responsive_image, focal_point
- **Install behavior:** `cmlstarter_install()` creates a default commerce_store (US/USD, or RU/RUB when site language is `ru`) and imports `product_options` terms from `config/content/<lang>/`.
- **Service:** `cmlstarter.route_subscriber` (`RouteSubscriber`) alters `entity.taxonomy_term.canonical` (priority -500) to render catalog/brand/product_options terms via embedded `product` views; controller passed through `hook_cmlstarter_taxonomy_route` alter.
- **Views:** argument + filter `taxonomy_index_tid_product_depth` ("Product has taxonomy term ID (with depth)"), default reference field `field_product_category`.
- **Permissions:** none defined by the module.
- **Security:** no routing.yml of its own; the route override reuses the core taxonomy term canonical route's access. Views depth argument/filter build subqueries from an admin-configured reference-field machine name and view arguments (no request-string concatenation). No anonymous mutation endpoints, no external calls, no secrets. No security findings.

See [configure/setup.md](configure/setup.md) and [extend/views-depth.md](extend/views-depth.md).
