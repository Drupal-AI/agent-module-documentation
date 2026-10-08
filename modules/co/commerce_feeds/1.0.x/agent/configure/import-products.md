<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Build a feed type that imports Commerce products

Commerce Feeds has **no configure route of its own** (`configure: null`). You configure it by
creating a Feeds **feed type** (`feeds_feed_type` config entity) that uses the
`entity:commerce_product` processor, then mapping source columns to product fields.

## Via the UI

1. Go to **Structure → Feeds** (`/admin/structure/feeds`), *Add feed type*.
2. Choose a **Fetcher** (e.g. *Upload* for files, *Download* for a URL) and a **Parser**
   (*CSV*, *XML*, *JSON*, *RSS*).
3. Set **Processor** to **Product** (`entity:commerce_product`). In the processor settings
   pick the product **type/bundle** (`values.type`) and update/expire behaviour.
4. On **Mapping**, map source columns to product fields. For a price field choose the
   **Commerce price** target and set its **Currency**; for weight/dimensions choose the
   physical measurement / dimensions target and its **Unit**.
5. Save. Add a feed (`/feed/add`), upload the file or set the URL, and **Import**.

## As config (feeds_feed_type entity)

The processor id is the load-bearing field:

```yaml
# core config: feeds.feed_type.<id>
id: cf_products
label: 'Commerce products'
fetcher: upload
fetcher_configuration:
  allowed_extensions: 'csv txt'
  directory: 'public://feeds'
parser: csv
parser_configuration: {  }
processor: 'entity:commerce_product'      # <-- the Commerce Feeds processor
processor_configuration:
  values:
    type: default            # commerce_product_type (bundle) machine name
  authorize: true
  update_existing: 0         # 0 skip, 1 replace, 2 update
  update_non_existent: _keep
  expire: -1
  skip_hash_check: false
mappings:
  - target: title
    map: { value: title }
  - target: field_price          # a commerce_price field on the product type
    map: { number: price }
    settings: { currency_code: USD }   # commerce_feeds_price target setting
```

## Scriptable (drush php:eval)

```php
use Drupal\feeds\Entity\FeedType;
FeedType::create([
  'id' => 'cf_products',
  'label' => 'Commerce products',
  'fetcher' => 'upload',
  'fetcher_configuration' => ['allowed_extensions' => 'csv txt', 'directory' => 'public://feeds'],
  'parser' => 'csv',
  'parser_configuration' => [],
  'processor' => 'entity:commerce_product',
  'processor_configuration' => ['values' => ['type' => 'default'], 'authorize' => TRUE, 'update_existing' => 0, 'update_non_existent' => '_keep', 'expire' => -1, 'skip_hash_check' => FALSE],
])->save();
```

Read it back: `drush cget feeds.feed_type.cf_products processor` → `entity:commerce_product`.

Notes:
- A `commerce_store` should exist for a working storefront; the processor does not create
  one (`@todo set default store` in source). For a pure import + verify you can create the
  feed type without a store.
- Mapping the SKU and using `update_existing` with a unique target lets re-imports update
  products in place instead of duplicating them.
