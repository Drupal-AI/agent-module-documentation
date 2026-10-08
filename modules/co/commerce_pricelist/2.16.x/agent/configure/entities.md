# Entities, admin UI & CSV

## Two content entity types

### `commerce_pricelist` — "Price list"
Bundled per purchasable entity type (default bundle `commerce_product_variation`). Base fields
(`PriceList`):

| Field | Type | Purpose |
|---|---|---|
| `name` | string | Label. |
| `stores` | entity_reference → commerce_store (multi) | Limit to these stores (empty = all). |
| `customers` | entity_reference → user (multi) | Limit to specific customers. |
| `customer_roles` | entity_reference → user_role (multi) | Limit to these roles. |
| `start_date` | datetime | When the list becomes active (optional). |
| `end_date` | datetime | When it stops (optional). |
| `weight` | integer | Priority ordering when several lists match (reorderable in UI). |
| `status` | boolean | Enabled/disabled. |
| `uid` | entity_reference → user | Owner. |

### `commerce_pricelist_item` — a "price"
Base fields (`PriceListItem`):

| Field | Type | Purpose |
|---|---|---|
| `price_list_id` | entity_reference → commerce_pricelist | Parent list. |
| `purchasable_entity` | entity_reference (target type = the bundle's purchasable type) | The variation this price applies to. |
| `quantity` | decimal | Minimum quantity for this price (tiered pricing). |
| `price` | commerce_price | The resolved price. |
| `list_price` | commerce_price | Optional MSRP / strike-through. |
| `status` | boolean | Enabled/disabled (enable/disable forms). |

`admin_permission` for both = `administer commerce_pricelist`. Both use Entity API's
`EntityPermissionProvider`, so per-bundle Entity permissions also exist.

## Admin UI paths

- `/admin/commerce/price-lists` — price list collection (+ `/reorder`).
- `/price-list/add`, `/price-list/add/{type}` — add a price list.
- `/price-list/{commerce_pricelist}/edit`, `…/duplicate`, `…/delete`.
- `/price-list/{commerce_pricelist}/prices` — the list's prices, with add / **import** / **export**.
- `/price-list/{commerce_pricelist}/prices/import` — **CSV import** (`PriceListItemImportForm`,
  bulk-load prices; sample columns in the module's `sample_file.csv`).
- `/price-list/{commerce_pricelist}/prices/export` — **CSV export** (`PriceListItemExportForm`).
- `/product/{commerce_product}/variations/{commerce_product_variation}/prices/add` — add a price
  for a variation directly from the product.
- `/admin/commerce/config/price-lists/types` and `…/item-types` — bundle admin.

## Create in code

```php
use Drupal\commerce_pricelist\Entity\PriceList;
use Drupal\commerce_pricelist\Entity\PriceListItem;
use Drupal\commerce_price\Price;

$list = PriceList::create([
  'type' => 'commerce_product_variation',
  'name' => 'Wholesale',
  'status' => 1,
  // optional conditions:
  // 'stores' => [$store->id()],
  // 'customer_roles' => ['wholesale'],
  // 'start_date' => '2026-01-01T00:00:00',
]);
$list->save();

$item = PriceListItem::create([
  'type' => 'commerce_product_variation',
  'price_list_id' => $list->id(),
  'purchasable_entity' => $variation->id(),
  'quantity' => '10',                    // applies at qty >= 10
  'price' => new Price('19.99', 'USD'),
  'status' => 1,
]);
$item->save();
```

There is no `configure` route and no Drush; everything is entity CRUD under *Commerce → Price
lists* or via the entity API above.
