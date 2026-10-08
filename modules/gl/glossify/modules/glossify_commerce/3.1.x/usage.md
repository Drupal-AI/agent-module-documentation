Glossify Commerce provides the "Glossify: Tooltips with commerce product" text-format filter (`glossify_commerce_product`), which scans filtered text and turns occurrences of Commerce product titles into links to those products and/or hover tooltips sourced from the product body. Requires Drupal Commerce.

---

This submodule subclasses `GlossifyBase` as the `CommerceProductTooltip` filter. Enable it on a text format, choose the source **commerce product types**, and pick the render type: `tooltips` (an `<abbr>` whose title is the product body), `links` (an `<a>` to `/product/[id]`), or `tooltips_links`. `process()` queries `commerce_product_field_data` (joined to `commerce_product__body` for the tooltip text) for published products of the selected types in the current language, tagging the query `glossify_commerce_product_tooltip`. Unlike the node/taxonomy filters, its setting keys are **un-prefixed** (`case_sensitivity`, `first_only`, `ignore_tags`, `glossify_type`, `tooltip_truncate`, `bundles`, `urlpattern`, `synonyms_field`). It supports the same base features: first-only matching, ignore tags, tooltip truncation (300 chars), a URL pattern with `[id]` (default `/product/[id]`), and a synonyms field. Selecting a product type is required when enabled. Config lives under `filters.glossify_commerce_product.settings` in the text-format entity. This submodule only makes sense on a store; the parent project suggests `drupal/commerce`.

---

- Auto-link product-name mentions in articles/blog posts to their product pages.
- Show a product's description as a tooltip when its name appears in content.
- Cross-sell by linking product names wherever they are mentioned editorially.
- Restrict auto-linking to specific product types (e.g. only "Default" products).
- Link only the first occurrence of each product name per field.
- Match product titles case-insensitively.
- Use a custom URL pattern instead of `/product/[id]`.
- Match alternate product names via a synonyms field.
- Skip glossification inside chosen tags (headings, etc.).
- Exclude a specific mention with `class="glossify-exclude"`.
- Truncate long product-body tooltips to 300 characters.
- Provide both a link and a tooltip via "tooltips and links" mode.
- Turn buying-guide content into a network of product links automatically.
- Interlink a catalog's products referenced across marketing pages.
- Localize product matching per language.
- Exclude discontinued products from matching via `hook_query_glossify_commerce_product_tooltip_alter()`.
- Apply product glossification only on selected text formats.
- Keep stored content untouched — links are added at render time.
- Surface product descriptions inline as hover definitions.
- Drive traffic to product pages from editorial content without manual linking.
- Highlight featured product names consistently across the site.
- Reduce manual internal linking effort for merchandisers.
- Auto-link SKU/brand names defined as products to their pages.
