# Glossify Commerce — agent index

Provides the **`glossify_commerce_product`** text-format filter ("Glossify: Tooltips with commerce
product"), a subclass of `GlossifyBase` that auto-links/tooltips **Commerce product titles** (tooltip
= product body). Requires Drupal Commerce (`commerce_product`). Enable it on a text format. Base
engine: [../../../../3.1.x/agent/api/glossifybase.md](../../../../3.1.x/agent/api/glossifybase.md).

- **Enable & configure the filter: settings keys (note: un-prefixed), defaults, source query** →
  [configure/filter.md](configure/filter.md)

Key facts:
- Term source: published products of the chosen **product types** from `commerce_product_field_data`
  + `commerce_product__body` (body = tooltip). Query tag `glossify_commerce_product_tooltip`.
- Settings at `filter.format.<format>` → `filters.glossify_commerce_product.settings`. Keys are
  **un-prefixed** (`bundles`, `glossify_type`, `urlpattern`, …). Selecting a product type is
  **required** when enabled. Default URL pattern `/product/[id]`.
