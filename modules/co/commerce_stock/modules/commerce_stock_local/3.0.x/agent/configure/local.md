# Configure local stock (locations, transactions, cron)

## Settings form

`CronConfigForm` at **`/admin/commerce/config/stock/local_stock_config`** (route
`commerce_stock_local.ls_config_form`, permission `administer commerce stock`).

### `commerce_stock_local.transactions`
| Key | Values | Default | Meaning |
|---|---|---|---|
| `transactions_aggregation_mode` | `cron` \| `real-time` | `cron` | When aggregated stock levels are recomputed. `cron` batches on cron; `real-time` updates immediately. |
| `transactions_retention` | `keep` \| `delete` | `keep` | `keep` = full transaction log; `delete` = drop unused transactions (no log). |

### `commerce_stock_local.cron`
| Key | Values / type | Default | Meaning |
|---|---|---|---|
| `cron_run_mode` | `optimal` \| `legacy` | `optimal` | `optimal` only updates products with new transactions; `legacy` reprocesses all. |
| `update_interval` | integer (seconds) | `3600` | Seconds between cron stock operations (0 = every cron run). |
| `update_batch_size` | integer | `50` | Products processed per legacy batch. |

```bash
drush cget commerce_stock_local.transactions
drush cset commerce_stock_local.transactions transactions_aggregation_mode real-time -y
drush cset commerce_stock_local.transactions transactions_retention delete -y
```

## Stock locations

- **`commerce_stock_location`** — a content entity (a warehouse/site). Collection at
  `/admin/commerce/config/stock/locations` (link `entity.commerce_stock_location.collection`).
  Install creates one default location.
- **`commerce_stock_location_type`** — the config bundle entity. Collection at
  the location-types page; install creates a `default` type.

Create a location in code:
```php
$loc = \Drupal::entityTypeManager()->getStorage('commerce_stock_location')->create([
  'type' => 'default',
  'name' => 'West Warehouse',
  'status' => 1,
]);
$loc->save();
```
Read them: `\Drupal::entityTypeManager()->getStorage('commerce_stock_location')->loadMultiple()`.

## Permissions

- `administer commerce_stock_location_type` — manage stock location types (restricted).
- Per-bundle entity permissions for `commerce_stock_location` (view/create/update/delete),
  provided by the Entity API permission provider (`permission_granularity = bundle`).

## Wiring it up

Local storage does nothing until a purchasable entity's stock service is `local_stock`. Set
`default_service_id` or the per-bundle `<entity_type>_<bundle>_service_id` to `local_stock` in
`commerce_stock.service_manager` (see the parent module's `configure/settings.md`).

## Uninstall

Clear local stock data first via `/admin/modules/uninstall/commerce_stock_local`
(`PrepareUninstallForm`); a `LocalStockUninstallValidator` blocks uninstall until then.
