# Stock service API

## The service manager — `commerce_stock.service_manager`

`Drupal\commerce_stock\StockServiceManager` (interface `StockServiceManagerInterface`).
Resolves the configured stock service for a purchasable entity and exposes the transaction
API. Key methods:

```php
$mgr = \Drupal::service('commerce_stock.service_manager');

$service = $mgr->getService($variation);          // StockServiceInterface for this entity
$ids     = $mgr->listServiceIds();                // ['always_in_stock' => 'Always in stock', 'local_stock' => 'Local stock']
$level   = $mgr->getStockLevel($variation);       // current available level (float/int)

// Low-level: create any transaction type.
$mgr->createTransaction($entity, $location_id, $zone, $quantity, $unit_cost, $currency_code, $transaction_type_id, array $metadata = []);

// High-level helpers (build the right transaction type for you):
$mgr->receiveStock($entity, $location_id, $zone, $quantity, $unit_cost, $currency_code, $message = NULL);
$mgr->sellStock($entity, $location_id, $zone, $quantity, $unit_cost, $currency_code, $order_id, $user_id, $message = NULL);
$mgr->moveStock($entity, $from_location_id, $to_location_id, $from_zone, $to_zone, $quantity, $unit_cost, $currency_code, $message = NULL);
$mgr->returnStock($entity, $location_id, $zone, $quantity, $unit_cost, $currency_code, $order_id, $user_id, $message = NULL);
$location = $mgr->getTransactionLocation($context, $entity, $quantity);
```

> These write real stock only when the resolved service supports it (i.e. `local_stock`). With
> `always_in_stock` there is nothing to store.

## Transaction type constants — `StockTransactionsInterface`

`STOCK_IN = 1`, `STOCK_OUT = 2`, `STOCK_SALE = 4`, `STOCK_RETURN = 5`, `NEW_STOCK = 6`,
`MOVEMENT_FROM = 7`, `MOVEMENT_TO = 8`. Pass one as `$transaction_type_id` to
`createTransaction()`.

## Availability checker

`commerce_stock.availability_checker` (`StockAvailabilityChecker`) is tagged
`commerce_order.availability_checker`, so Commerce consults stock when validating order items
(blocks quantities above the available level). It delegates to the resolved service's checker
and honours "always in stock".

## Registering a custom stock service

Tag a service `commerce_stock.stock_service`; the manager's `service_collector` picks it up
via `addService()`:
```yaml
# my_module.services.yml
services:
  my_module.stock_service:
    class: Drupal\my_module\MyStockService
    tags:
      - { name: commerce_stock.stock_service, priority: 0 }
```
Implement `StockServiceInterface` (a checker `StockCheckInterface`, an updater
`StockUpdateInterface`, and a config `StockServiceConfigInterface`). Its id (from
`getId()`) then appears in the config form's service selects. See `commerce_stock_local`'s
`LocalStockService` for the reference implementation.

## Always-in-stock

`commerce_stock.always_in_stock_service` (`AlwaysInStockService`, id `always_in_stock`) is the
default: every entity is available, no storage. Use it for products you never want blocked.
