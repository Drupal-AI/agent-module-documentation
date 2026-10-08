<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Feeds — agent index

Bridges **Commerce** and **Feeds**. It adds a Feeds **processor** for products plus three
**field target** mappers for Commerce field types. No config UI, no permissions, no Drush,
no services, no config schema of its own — you drive it through Feeds at
`/admin/structure/feeds`.

- **The plugins it provides (processor id, target ids, their settings)** →
  [plugins/feeds-plugins.md](plugins/feeds-plugins.md)
- **Build a feed type that imports Commerce products (config entity shape, drush)** →
  [configure/import-products.md](configure/import-products.md)

Key facts:
- Processor id: **`entity:commerce_product`** (title "Product"), extends Feeds'
  `EntityProcessorBase` — creates/updates `commerce_product` entities.
- Targets: **`commerce_feeds_price`** (`commerce_price` field, adds a Currency select),
  **`commerce_feeds_physical_measurement`** (`physical_measurement`, Unit select),
  **`commerce_feeds_physical_dimensions`** (`physical_dimensions`, length/width/height + Unit).
- The two `physical_*` targets need the **`drupal/physical`** module (they map its field types).
- Depends on `feeds`, `commerce`, `commerce_product`.
