# Open Graph product tags

Adds `product:*` Open Graph tags (`<meta property="product:…">`), requires
`metatag_open_graph`:

- `product:price:amount` — numeric price.
- `product:price:currency` — ISO currency code.
- `product:availability` — e.g. in stock / out of stock.
- `product:condition` — new / refurbished / used.
- `product:retailer_item_id` — SKU / retailer item id.

Set as Metatag defaults (e.g. on a product type) or per entity; token-enabled to pull from
Commerce fields. Schema: `config/schema/metatag_open_graph_products.metatag_tag.schema.yml`.
