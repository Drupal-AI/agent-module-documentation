<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CML Starter (cmlstarter) — agent index

**Commerce starter kit: installs Drupal Commerce product type, variation type, taxonomies (catalog/brand/product_options), paragraph type, product fields, image styles, views, blocks and pathauto patterns for a basic online store. The product field structure is the base for 1C/CommerceML exchange modules.**

- **Version:** 2.0.x (info.yml `2.0.3`) — new major of the project.
- **Core:** ^11 || ^12
- **Package:** cml
- **Dependencies:** commerce:commerce_product, paragraphs, cshs, tvi, image_effects, colorbox, field_group, metatag, responsive_image, focal_point
- **Install behavior:** `cmlstarter_install()` creates a default `commerce_store` (US/USD, or RU/RUB when site language is `ru`) if none exists, and imports `product_options` terms from `config/content/<lang>/taxonomy_term.product_options.yml`.
- **Service:** `cmlstarter.route_subscriber` (`src/EventSubscriber/RouteSubscriber.php`, arg `@module_handler`) alters `entity.taxonomy_term.canonical` (priority -500) to render catalog/brand/product_options terms via embedded `product` views; the controller string is passed through `hook_cmlstarter_taxonomy_route` alter (`src/Controller/TaxonomyTermController.php`).
- **Views:** argument + filter `taxonomy_index_tid_product_depth` ("Product has taxonomy term ID (with depth)") on `commerce_product_field_data`, default reference field `field_product_category` (`src/Plugin/views/argument/IndexTidProductDepth.php`, `src/Plugin/views/filter/TaxonomyIndexProductTidDepth.php`, registered in `cmlstarter.views.inc`).
- **Config:** ships `config/install/*`, `config/optional/*` and `config/content/<lang>/*`; no `config/schema/`, no settings form (`configure: null`).
- **Permissions:** none defined by the module. No `*.routing.yml`, no `*.permissions.yml`.

See [configure/setup.md](configure/setup.md) and [extend/views-depth.md](extend/views-depth.md).
