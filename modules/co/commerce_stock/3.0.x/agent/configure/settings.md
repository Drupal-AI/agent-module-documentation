# Configure stock services & events

Form `StockConfigForm` at **`/admin/commerce/config/stock/settings`** (route
`commerce_stock.stock_config`, permission `administer commerce stock`). It edits two config
objects.

## `commerce_stock.service_manager`

| Key | Meaning |
|---|---|
| `default_service_id` | The stock service used when a bundle has no override. Values are service ids from the manager: `always_in_stock`, `local_stock` (with `commerce_stock_local`). Form defaults to `always_in_stock` when unset. |
| `<entity_type>_<bundle>_service_id` | Per purchasable-entity-type/bundle override. For a product variation type `default` the key is `commerce_product_variation_default_service_id`. Value `use_default` (the default) means "fall back to `default_service_id`". |
| `stock_events_plugin_id` | Which `stock_events` plugin handles order events. Default `core_stock_events`; `disabled_stock_events` turns automatic order→stock updates off. |

```bash
drush cget commerce_stock.service_manager
drush cset commerce_stock.service_manager default_service_id local_stock -y
drush cset commerce_stock.service_manager commerce_product_variation_default_service_id local_stock -y
```
Or in PHP:
```php
\Drupal::configFactory()->getEditable('commerce_stock.service_manager')
  ->set('default_service_id', 'local_stock')
  ->set('commerce_product_variation_default_service_id', 'local_stock')
  ->save();
```

The form lists a select per purchasable entity type → bundle (built from every entity type
implementing `PurchasableEntityInterface`), plus the default service and the event plugin.

## `commerce_stock.core_stock_events`

Used when `stock_events_plugin_id` is `core_stock_events`:

| Key | Type | Meaning |
|---|---|---|
| `core_stock_events_order_complete_event_type` | string | Which order event triggers the "sell/complete" stock transaction (e.g. order place vs a workflow transition). |
| `core_stock_events_order_cancel` | boolean | React to order cancel (return stock). |
| `core_stock_events_order_updates` | boolean | React to order updates. |

## Permissions

- `access commerce stock administration pages` — reach the Stock admin section
  (`/admin/commerce/config/stock`).
- `administer commerce stock` — change these settings (restricted).

Local-storage / enforcement have their own settings — see those submodules' docs.
