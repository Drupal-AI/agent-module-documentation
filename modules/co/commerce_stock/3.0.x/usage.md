Commerce Stock is the framework (API) that tracks and enforces stock levels for Drupal Commerce purchasable entities (product variations). It defines pluggable "stock services" and event handling, but by itself only ships the Always-in-stock service — real inventory needs the Local Storage submodule.

---

The core module provides a **stock service** abstraction: services are tagged `commerce_stock.stock_service` and collected by the `commerce_stock.service_manager` (`StockServiceManager`), which resolves the right service for a purchasable entity and exposes the transaction API (`createTransaction`, `receiveStock`, `sellStock`, `moveStock`, `returnStock`, `getStockLevel`). A `StockAvailabilityChecker` is registered as a `commerce_order.availability_checker` so Commerce refuses to add out-of-stock items to an order. Which service applies is chosen on the config form at `/admin/commerce/config/stock/settings` (route `commerce_stock.stock_config`), stored in `commerce_stock.service_manager` config: a `default_service_id` plus per purchasable-entity-type/bundle overrides (`<entity_type>_<bundle>_service_id`). Order lifecycle changes are turned into stock transactions by an `OrderEventSubscriber` driven by two plugin types: **`stock_events`** (`CoreStockEvents` / `DisabledStockEvents`, chosen via `stock_events_plugin_id`) decide *whether/when* to react, and **`commerce_stock_event_type`** plugins (`OrderPlace`, `OrderUpdate`, `OrderCancel`, `OrderDelete`, `OrderItemUpdate`, `OrderItemDelete`) define the concrete order events. The bundled `AlwaysInStockService` reports everything as available; the `commerce_stock_local` submodule adds a database-backed `local_stock` service with real stock levels, locations and transactions. Two permissions gate the admin pages (`access commerce stock administration pages`, `administer commerce stock`).

---

- Track inventory for Commerce product variations across one or more stock locations (with the Local submodule).
- Prevent customers from adding more of a product to their cart than is in stock (availability checker).
- Choose a different stock service per product variation type (e.g. some tracked, some always in stock).
- Mark certain products as "always in stock" so they are never blocked on availability.
- Record stock movements as transactions (receive, sell, move, return) via the service manager API.
- Programmatically read a variation's available stock level with `getStockLevel()`.
- Automatically decrement stock when an order is placed/completed.
- Automatically restore stock when an order is cancelled.
- Choose which order event triggers the stock decrement (place vs complete) via the events config.
- Disable automatic order-driven stock changes entirely (DisabledStockEvents plugin).
- Add a custom stock backend by registering a `commerce_stock.stock_service` tagged service.
- Add a custom order stock event by implementing a `commerce_stock_event_type` plugin.
- Integrate stock availability into the standard Commerce checkout flow.
- Build reports of stock levels using the Local storage views data.
- Restrict who can administer stock settings with the module's permissions.
- Provide a stock-aware add-to-cart experience (with the Enforcement submodule).
- Expose a stock-level field on product variations for editors (with the Field submodule).
- Give warehouse staff a transaction entry form (with the UI submodule).
- Model multiple warehouses/locations and split availability across them.
- Migrate to Commerce Stock by mapping each variation type to a stock service.
- Keep stock decoupled from product data so the same product can be tracked differently per store.
- Use context (store + customer) to determine which locations count toward availability.
