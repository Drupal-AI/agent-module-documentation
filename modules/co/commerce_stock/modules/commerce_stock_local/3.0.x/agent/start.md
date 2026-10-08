# Commerce Stock Local Storage — agent index

Adds the **`local_stock`** service to Commerce Stock: a database-backed inventory backend with
stock **locations** and append-only **transactions**. Enable it, then set a variation type's
stock service to `local_stock` (parent module config). Depends on `commerce_stock`. Configure
route: `commerce_stock_local.ls_config_form` (`/admin/commerce/config/stock/local_stock_config`).

- **Transaction/cron config + the stock location & location-type entities + permissions** →
  [configure/local.md](configure/local.md)
- **The `local_stock` service, checker/updater API, and the DB tables** →
  [api/local-service.md](api/local-service.md)

Key facts:
- Service id `local_stock` = `commerce_stock.local_stock_service` (`LocalStockService`),
  built from `LocalStockChecker` + `LocalStockUpdater` + `LocalStockServiceConfig`.
- Entities: `commerce_stock_location` (content, bundle = `commerce_stock_location_type`
  config entity). Install creates a default type and one default location.
- Config `commerce_stock_local.transactions`: `transactions_aggregation_mode`
  (`cron`|`real-time`), `transactions_retention` (`keep`|`delete`).
- Config `commerce_stock_local.cron`: `cron_run_mode` (`optimal`|`legacy`),
  `update_interval`, `update_batch_size`.
- DB tables: `commerce_stock_transaction`, `commerce_stock_transaction_type`,
  `commerce_stock_location_level`.
- Permission: `administer commerce_stock_location_type` (plus per-bundle entity permissions
  for `commerce_stock_location`). Queue worker `StockLevelUpdater` recomputes aggregates.
