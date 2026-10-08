Commerce Stock Local Storage adds the `local_stock` service to Commerce Stock: a database-backed inventory backend that stores stock as transactions across stock locations (warehouses) and computes available levels from them.

---

This submodule turns Commerce Stock from an abstract framework into a working inventory system. It registers the `commerce_stock.local_stock_service` (`LocalStockService`, id `local_stock`, tagged `commerce_stock.stock_service`) composed of a `LocalStockChecker` (reads levels), a `LocalStockUpdater` (writes transactions and dispatches events) and a `LocalStockServiceConfig`. Stock is modelled as a **`commerce_stock_location`** content entity (bundled by the **`commerce_stock_location_type`** config entity — a default type and one default location are created on install) plus append-only transactions in the `commerce_stock_transaction` table; per-location aggregated levels live in `commerce_stock_location_level`, and `commerce_stock_transaction_type` seeds the transaction types. Available quantity for a purchasable entity is the sum of its transactions across the relevant locations. A settings form at `/admin/commerce/config/stock/local_stock_config` (route `commerce_stock_local.ls_config_form`, `CronConfigForm`) controls two config objects: `commerce_stock_local.transactions` (`transactions_aggregation_mode`: `cron` or `real-time`; `transactions_retention`: `keep` or `delete`) and `commerce_stock_local.cron` (`cron_run_mode` `optimal`/`legacy`, `update_interval`, `update_batch_size`). A `StockLevelUpdater` queue worker recomputes aggregated levels; a `CommerceLocalStockTransactionSubscriber` invalidates caches on new transactions. It adds the `administer commerce_stock_location_type` permission (plus entity permissions for locations) and views data for reporting. To use it, set a variation type's stock service to `local_stock` in the parent module's config.

---

- Track real stock quantities for product variations in the database.
- Model one or more warehouses/stores as stock locations.
- Define multiple stock location types (bundles) with their own fields.
- Record every stock change as an auditable transaction (in, out, sale, return, movement).
- Compute a variation's available level as the sum of its transactions across locations.
- Aggregate stock level stats on cron (for large catalogs) or in real-time.
- Choose to keep all transactions as a full log, or delete unused ones to save space.
- Tune cron behavior: optimal (only changed products) vs legacy (all products), interval, batch size.
- Split availability across locations using the current store/customer context.
- Report on stock levels and transactions via the module's Views data.
- Receive new stock into a specific location programmatically (`receiveStock`).
- Sell/return stock tied to an order and user.
- Move stock between two locations.
- Read a single location's stock level with `LocalStockChecker::getLocationStockLevel()`.
- Get the total available level across locations with `getTotalAvailableStockLevel()`.
- List active stock locations for a purchasable entity.
- Add or edit stock locations from the admin UI (Stock locations collection).
- Restrict who can manage stock location types with a dedicated permission.
- Safely uninstall by first clearing local stock data via the prepare-uninstall form.
- Back the enforcement/field/UI submodules with real stock numbers.
- Give a multi-warehouse merchant per-location inventory visibility.
- Queue recomputation of aggregated levels after bulk transaction imports.
