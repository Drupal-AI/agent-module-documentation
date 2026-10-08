# migrate_json_example — agent start

Learning module (package Examples). Smallest end-to-end JSON migration: imports
`artifacts/products.json` into a `product` content type (fields `field_upc`, `field_price`,
`field_description`, installed as optional config) via a single `migrate_plus.migration.product`
using the `url` source + `json` data parser. Depends on `migrate`, `migrate_plus`.

Self-contained — enable it and run `drush migrate:import product`. The clearest reference for
`item_selector` / `fields[].selector` / `ids` in JSON ingestion. No config UI or plugins of its
own to document; the `url` source + `json` parser are documented under the parent `migrate_plus`
module (`agent/plugins/data-plugins.md`).
