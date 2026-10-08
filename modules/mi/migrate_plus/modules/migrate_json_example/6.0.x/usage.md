A minimal, self-contained example that imports products from a bundled JSON file into a Product content type using Migrate Plus's `url` source and `json` parser.

---

Migrate JSON Example is the smallest end-to-end demonstration of consuming JSON with Migrate Plus. It ships a `products.json` fixture (in `artifacts/`), a `product` content type with `field_upc`, `field_price` and `field_description` (installed as optional config), and a single `migrate_plus.migration.product` migration whose `url` source uses the `json` data parser to read the file and map each object to a node. It is the clearest reference for the `item_selector`, `fields[].selector` and `ids` keys that drive JSON ingestion. Because everything — source data, destination fields, and migration — is included, you can enable it and immediately run `drush migrate:import product` to see JSON become content. It is a learning aid, not a production module.

---

- Learn the minimal config to import a JSON file into nodes.
- See a `url` source with `data_parser_plugin: json` in a real migration.
- Study `item_selector` pointing at the array of items in the payload.
- Map JSON keys to fields with `fields[].selector`.
- Declare source `ids` for a JSON migration.
- See how a Product content type + fields are provisioned as optional config.
- Import UPC, price and description fields from JSON.
- Practice `drush migrate:import product` on a known dataset.
- Practice `drush migrate:status` / `migrate:rollback` with JSON data.
- Copy the pattern to import from a remote JSON API (swap the URL).
- Understand fetching a local file vs an HTTP endpoint.
- Reference the shape of `artifacts/products.json` as an input template.
- See a complete, dependency-light migration you can read in minutes.
- Use as a starting point for a custom JSON importer.
- Verify Migrate Plus JSON parsing is working in an environment.
- Onboard developers to JSON-source migrations quickly.
