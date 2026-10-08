# Catalog configuration

Entities:
- `commerce_product` (content) — marketing item (title, body, images, store(s)).
- `commerce_product_variation` (content) — purchasable unit: SKU, price, attribute values.
  This is the "purchasable entity" cart/order use.
- `commerce_product_type` / `commerce_product_variation_type` (config) — bundles; extend with
  Field UI. A product type references a variation type.
- `commerce_product_attribute` / `commerce_product_attribute_value` (config/content) — e.g.
  Size → S/M/L. Attributes attached to a variation type generate the add-to-cart options.

Manage at `/admin/commerce/config/product-types`,
`/admin/commerce/config/product-variation-types`, `/admin/commerce/config/product-attributes`.
Products edited at `/admin/commerce/products`.

`Drupal\commerce_product\ProductAttributeFieldManager` programmatically creates the attribute
reference fields on variation types when attributes are enabled.

## Permissions (dynamic + `commerce_product.permissions.yml`)
- `administer commerce_product_type` — manage product types/fields (restricted).
- `translate commerce_product_attribute` — translate attributes (restricted).
- Per-product-type: `manage <type> commerce_product` (create/update/delete), plus view
  permissions generated per bundle.

Config schema: `config/schema/commerce_product.schema.yml`.
