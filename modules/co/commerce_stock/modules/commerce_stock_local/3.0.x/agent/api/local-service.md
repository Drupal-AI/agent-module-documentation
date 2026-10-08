# Local stock service & storage API

## The service — `local_stock`

`commerce_stock.local_stock_service` (`LocalStockService`, id `local_stock`) implements
`StockServiceInterface`:
- `getId()` → `local_stock`, `getName()` → `Local stock`
- `getStockChecker()` → `LocalStockChecker`
- `getStockUpdater()` → `LocalStockUpdater`
- `getConfiguration()` → `LocalStockServiceConfig`

Normally you go through the parent's `commerce_stock.service_manager` (see the parent's
`api/services.md` for `receiveStock`/`sellStock`/`getStockLevel`), which resolves to this
service for entities configured to use `local_stock`.

## Checker — `commerce_stock.local_stock_checker` (`LocalStockChecker`)

Reads levels straight from the DB:
```php
$checker->getLocationStockLevel($location_id, $entity);                 // one location
$checker->getTotalAvailableStockLevel($entity, array $locations);       // sum available
$checker->getTotalStockLevel($entity, array $locations);
$checker->getLocationsStockLevels($entity, array $locations);
$checker->getIsInStock($entity, array $locations);                      // bool
$checker->getIsAlwaysInStock($entity);                                  // bool
$checker->getLocationList($return_active_only = TRUE);
$checker->getLocationStockTransactionSum($location_id, $entity, $min, $max);
```

## Updater — `commerce_stock.local_stock_updater` (`LocalStockUpdater`)

Writes transactions to `commerce_stock_transaction`, updates aggregated
`commerce_stock_location_level`, and dispatches local stock events
(`LocalStockTransactionEvents`, `FilterLocationsEvent`, `StockLocationEvent`).

## Storage tables

- `commerce_stock_transaction` — append-only ledger (entity, location, zone, qty, type,
  cost, currency, metadata). Available level = sum of these.
- `commerce_stock_transaction_type` — seeded transaction types (maps to
  `StockTransactionsInterface` constants: STOCK_IN, STOCK_OUT, STOCK_SALE, STOCK_RETURN,
  NEW_STOCK, MOVEMENT_FROM, MOVEMENT_TO).
- `commerce_stock_location_level` — per-location aggregated level cache, recomputed by the
  `StockLevelUpdater` queue worker (on cron or real-time per config).

## Location entities

`commerce_stock_location` (content, storage class `StockLocationStorage`) with bundles from
the `commerce_stock_location_type` config entity. Load via the entity type manager
(`commerce_stock_location` / `commerce_stock_location_type` storages). See
`configure/local.md` for creating them.

## Events

Dispatched from the updater/storage (`src/Event/`): `LocalStockTransactionEvent`,
`FilterLocationsEvent` (adjust which locations count for availability), `StockLocationEvent`.
Subscribe to `FilterLocationsEvent` to implement location-based fulfilment rules.
