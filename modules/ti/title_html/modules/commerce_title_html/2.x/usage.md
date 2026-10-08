<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Title HTML for Commerce extends Title HTML to Drupal Commerce, letting product, product-variation, and store titles carry inline HTML markup rendered through the text-format filter pipeline.

---

The base Title HTML module only handles node titles. This submodule (`commerce_title_html`, depends on `title_html`) applies the same mechanism to three Commerce entity types: `commerce_product`, `commerce_product_variation`, and `commerce_store`. On each bundle's edit form it adds an "Enable Title HTML Field" checkbox; enabling it reuses the base module's `CopyTitle` helpers to create a `title_html` formatted `text_long` field on that bundle, swap the plain title widget for a rich textarea, batch-copy existing titles into the new field, and record the field name in a per-bundle config entity (`product_type_settings`, `product_variation_type_settings`, or `store_type_settings`). On display it preprocesses each entity type's title field and renders the `title_html` value through `check_markup($value, $format)`, so the shown markup is whatever the field's text format allows. As with the parent, the entity's real title/name property is kept in sync on save as a tag-stripped, entity-decoded plain-text copy (products and variations via `setTitle()`, stores via `setName()`), so storefront metadata, admin product/order lists, and cart summaries stay plain text while the product or store page shows the formatted title. There is no separate settings form: configuration is entirely the per-type toggle plus the parent module's shared text-format selection.

---

- Allow inline HTML in a Commerce product title.
- Italicise a brand or model name in a product title.
- Add a superscript trademark or registered mark to a product title.
- Add a subscript to a chemical/technical product title.
- Format a product-variation title with markup.
- Format a Commerce store name with markup on storefront pages.
- Render Commerce titles through a controlled text format's allowed tags.
- Enable formatted titles per product type without code.
- Enable formatted titles per product-variation type.
- Enable formatted titles per store type.
- Batch-copy existing product titles into the HTML title field on enable.
- Swap the plain product-title widget for a rich textarea.
- Keep admin product lists and order lines showing plain product names.
- Keep the storefront `<title>` and breadcrumbs plain text automatically.
- Reuse the parent module's Title text format for products.
- Toggle the feature off for a product type and restore the plain title.
- Combine node and Commerce formatted titles on one site.
- Display a formatted product title on the product page only.
- Keep cart and checkout summaries showing plain product names.
- Add a manual line break in a long product title.
- Configure which field feeds each product type's rendered title.
