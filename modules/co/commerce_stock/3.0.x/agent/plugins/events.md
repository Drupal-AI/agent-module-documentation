# Stock event plugin types

Order lifecycle changes become stock transactions through an `OrderEventSubscriber`
(`commerce_stock.order_event_subscriber`) that combines two plugin types.

## `stock_events` (the "when/how")

- Manager: `plugin.manager.stock_events` (`StockEventsManager`), annotation `@StockEvents`.
- Discovery: `src/Plugin/StockEvents/`.
- Shipped plugins:
  - `core_stock_events` (`CoreStockEvents`) — the default; reacts to order events per the
    `commerce_stock.core_stock_events` config (see `configure/settings.md`).
  - `disabled_stock_events` (`DisabledStockEvents`) — a no-op; select it (via
    `commerce_stock.service_manager` → `stock_events_plugin_id`) to turn automatic order→stock
    updates off.
- Interface: `StockEventsInterface`. Base: `CoreStockEventsBase`.

## `commerce_stock_event_type` (the concrete order events)

- Manager: `plugin.manager.commerce_stock_event_type` (`StockEventTypeManager`), annotation
  `@StockEventType`.
- Discovery: `src/Plugin/Commerce/StockEventType/`.
- Shipped plugins: `OrderPlace`, `OrderUpdate`, `OrderCancel`, `OrderDelete`,
  `OrderItemUpdate`, `OrderItemDelete`.
- Interface: `StockEventTypeInterface`. Base: `StockEventTypeBase`.

Each event type maps a Commerce order/order-item event to a stock action (e.g. `OrderPlace`
→ decrement/sell, `OrderCancel` → return). The `stock_events` plugin decides whether that
mapping runs and which order-complete transition counts.

## Implement your own

Add an event type:
```php
namespace Drupal\my_module\Plugin\Commerce\StockEventType;

use Drupal\commerce_stock\Plugin\Commerce\StockEventType\StockEventTypeBase;

/**
 * @StockEventType(
 *   id = "my_event",
 *   label = @Translation("My event"),
 * )
 */
class MyEvent extends StockEventTypeBase {}
```

Add a `stock_events` handler by implementing `StockEventsInterface` (extend
`CoreStockEventsBase`) with an `@StockEvents` annotation, then select it as the
`stock_events_plugin_id`.
