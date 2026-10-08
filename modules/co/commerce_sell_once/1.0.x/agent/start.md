<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Sell Once (commerce_sell_once) — agent index

A **Commerce Stock service** that limits a purchasable entity to a **single sale**: once its one
unit is sold the product reports zero stock and drops out of availability. Built for genuinely
unique/one-off items (a single artwork, one ticket, one-of-a-kind inventory). It is not a standalone
enforcer — it is a `commerce_stock.stock_service` plugin, so the actual "can't add to cart / can't
check out" blocking is performed by Commerce Stock's availability layer, and the README states the
**Commerce Stock Enforcement** submodule is required to actually restrict purchasing more than once.

Version `1.0.4`. Core `^10.2 || ^11`. Package `Commerce Stock`. Depends on
`commerce_stock:commerce_stock` (composer: `drupal/commerce_stock:^1.0 || ^3.0`). No settings form,
no `configure` route, no permission of its own, no Drush, no config schema, no plugin types of its
own, no JS/templates.

## How it works (mechanism)

1. **Base field.** `commerce_sell_once_entity_base_field_info()` (`commerce_sell_once.module`) adds a
   boolean base field `commerce_sell_once_sold` (label "Sold", default `FALSE`, form-configurable as
   a `boolean_checkbox`) to **every** entity type implementing
   `Drupal\commerce\PurchasableEntityInterface` (i.e. every product variation type). This field is the
   entire persisted state — there is no custom table.
2. **Stock service.** `SellOnceService` (`src/SellOnceService.php`, id `commerce_sell_once`, name
   `Sell Once`) is registered via `commerce_sell_once.services.yml` with the tag
   `commerce_stock.stock_service` (priority 0). It wires together a checker, an updater and a config.
   An admin selects it as the default (or per-variation) stock service under **Commerce →
   Configuration → Stock → Stock configuration**.
3. **Checker.** `SellOnceChecker` (`src/SellOnceChecker.php`) implements
   `StockCheckInterface`. `getTotalStockLevel()` returns **1** when `commerce_sell_once_sold` is
   empty/FALSE and **0** once it is TRUE; `getTotalAvailableStockLevel()` delegates to it;
   `getIsInStock()` is `level > 0`; `getIsAlwaysInStock()` is always `FALSE`. Availability is derived
   solely from the boolean flag — the number sold is never counted.
4. **Updater.** `SellOnceUpdater::createTransaction()` (`src/SellOnceUpdater.php`) is invoked by
   Commerce Stock when it records a stock transaction. It sets `commerce_sell_once_sold = ($quantity
   < 0)` and saves the entity — a stock-**decrement** transaction (a sale) marks the item sold; a
   positive transaction (e.g. restock on order cancel) clears the flag back to available. It then
   dispatches `SellOnceTransactionEvent`. Returns `NULL` (there is no transaction id/ledger).
5. **Locations.** `SellOnceServiceConfig` (`src/SellOnceServiceConfig.php`) returns a single
   `EmptyLocation` (`src/EmptyLocation.php`, id `null`, always active) — this service has no real
   stock locations; state is per purchasable entity, global (not per user).
6. **Cache.** `CommerceSellOnceTransactionSubscriber` (event `commerce_sell_once.stock_transaction`)
   invalidates the purchasable entity's cache tags after each transaction so availability re-renders.

## Enforcement path (important)

The single-sale rule is enforced through Commerce Stock, not by this module directly. This module
only reports availability (checker) and flips the flag (updater). For the check to actually block
purchasing, Commerce Stock must (a) have this service selected as the stock service for the relevant
variations and (b) have the **Commerce Stock Enforcement** submodule enabled (per README). The
"sold" state is set from a Commerce Stock **transaction**, which Commerce Stock creates on the order
lifecycle event you configure in Commerce Stock (placement vs. completion) — this module does not
choose that timing.

## Uninstall handling

- `SellOnceUninstallValidator` (tagged `module_install.uninstall_validator`) blocks uninstall while
  any purchasable entity type still has `commerce_sell_once_sold` field data, surfacing a
  "Remove field values" link.
- Route `commerce_sell_once.prepare_module_uninstall`
  (`/admin/modules/uninstall/commerce_sell_once`, permission `administer modules`) →
  `Form\PrepareUninstallForm`, a confirm form that NULLs `commerce_sell_once_sold` in the data and
  revision-data tables of every purchasable entity type. This is the module's only route.

## Extending — the transaction event

- `SellOnceTransactionEvents::SELL_ONCE_TRANSACTION` = `'commerce_sell_once.stock_transaction'`
  (`src/Event/SellOnceTransactionEvents.php`).
- `SellOnceTransactionEvent` (`src/Event/SellOnceTransactionEvent.php`, extends `commerce\EventBase`):
  `getEntity()` loads the purchasable entity, `getSold()` returns the new bool, `getStockTransaction()`
  returns the raw array `['entity_id', 'entity_type', 'sold']`. Subscribe to react when an item is
  sold or restocked (the module's own subscriber uses it only for cache invalidation).

## Files

- `commerce_sell_once.module` — the `commerce_sell_once_sold` base field.
- `commerce_sell_once.services.yml` — service + tag wiring.
- `commerce_sell_once.routing.yml` — the uninstall-prepare route.
- `src/SellOnceService.php`, `SellOnceChecker.php`, `SellOnceUpdater.php`, `SellOnceServiceConfig.php`,
  `EmptyLocation.php` — the stock-service implementation.
- `src/Event/*`, `src/EventSubscriber/CommerceSellOnceTransactionSubscriber.php` — the event.
- `src/SellOnceUninstallValidator.php`, `src/Form/PrepareUninstallForm.php` — uninstall data cleanup.
