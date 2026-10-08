# Commerce Stock API — agent index

The stock **framework** for Drupal Commerce. Defines pluggable stock services + order→stock
event handling and an availability checker. Ships only the **Always-in-stock** service; real
inventory comes from the `commerce_stock_local` submodule. Depends on `commerce_product`,
`commerce_order`. Configure route: `commerce_stock.stock_config`
(`/admin/commerce/config/stock/settings`).

- **Choose the stock service (default + per variation type) & event config; the two permissions** →
  [configure/settings.md](configure/settings.md)
- **The service manager API: getStockLevel, createTransaction, receive/sell/move/returnStock; the `commerce_stock.stock_service` tag; availability checker** →
  [api/services.md](api/services.md)
- **The `stock_events` and `commerce_stock_event_type` plugin types (order lifecycle → stock)** →
  [plugins/events.md](plugins/events.md)

Submodules (nested): `commerce_stock_local` (DB-backed stock service, locations, transactions),
`commerce_stock_field` (stock-level field), `commerce_stock_ui` (transaction forms),
`commerce_stock_enforcement` (block out-of-stock in cart/checkout).

Key facts:
- Config `commerce_stock.service_manager`: `default_service_id` (e.g. `always_in_stock`,
  `local_stock`), `stock_events_plugin_id` (default `core_stock_events`), and per-bundle
  `<entity_type>_<bundle>_service_id` (e.g. `commerce_product_variation_default_service_id`;
  value `use_default` means fall back to the default).
- Config `commerce_stock.core_stock_events`: `core_stock_events_order_complete_event_type`,
  `core_stock_events_order_cancel` (bool), `core_stock_events_order_updates` (bool).
- Service manager: `commerce_stock.service_manager`. Built-in services: `always_in_stock`,
  `local_stock` (with the local submodule).
- Permissions: `access commerce stock administration pages`, `administer commerce stock`
  (restricted).
