<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SynCommerce provides a JavaScript-driven admin screen for managing Drupal Commerce products and their variations, backed by a small set of JSON endpoints.

---

The `/syncommerce/products` route renders a themed page hosting a front-end app; that app talks to three POST JSON endpoints on `SyncommerceController`: `products_list` (paged/filtered product listing plus catalog terms and attributes), `updateProduct` (saves a product's title, article, catalog term and status), and `updateVariation` (saves a variation's price, old price, stock, attribute references and status). Product queries support filtering by article, name and catalog term. The module bundles compiled CSS/JS assets and Twig templates for the editing UI.

All four routes — including the two mutating endpoints `updateProduct` and `updateVariation` — use the route requirement `_permission: 'access content'`. The module also defines an `administer syncommerce configuration` permission. Typical (intended) use is as an editor tool.

---

- Browse Drupal Commerce products in a custom admin UI.
- Filter products by article number.
- Filter products by title.
- Filter products by catalog taxonomy term.
- Paginate the product list.
- Edit a product's title.
- Edit a product's article/SKU-like field.
- Reassign a product to a catalog term.
- Publish or unpublish a product.
- Edit a variation's price.
- Edit a variation's old/compare-at price.
- Update a variation's stock quantity.
- Set variation attribute references.
- Publish or unpublish a variation.
- List product attributes and their values.
- Retrieve the catalog taxonomy for filtering.
- Manage variations inline under each product.
- Provide a fast bulk product-editing screen for staff.
- Integrate a JS front-end app with Commerce entities.
- Expose product data as JSON for the editing UI.
