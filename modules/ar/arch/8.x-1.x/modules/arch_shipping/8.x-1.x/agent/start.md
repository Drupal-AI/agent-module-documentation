<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Shipping (arch_shipping) — agent index

Umbrella module defining a **`shipping_method` plugin type** for Arch delivery. Package `Arch`.
Depends on `arch`, `arch_order`. Core `^9.4 || ^10 || ^11`. License GPL-2.0-or-later. Version dir
`8.x-1.x` (installed `8.x-1.0-alpha26`). Ships no method itself — see submodule
`arch_shipping_instore`. Provides no config schema (settings live in the KeyValue store).

- **The plugin type, base classes, price calculation, availability, admin routes** →
  [plugins/shipping-method.md](plugins/shipping-method.md)

## Plugin type

- **`shipping_method`** — manager `ShippingMethodManager` (service `plugin.manager.shipping_method`,
  `parent: default_plugin_manager`), namespace `Plugin/ShippingMethod`, annotation
  `Annotation\ShippingMethod` (`id`, `module`, `form`), interface `ShippingMethodInterface`, alter
  hook `hook_shipping_methods_plugin_alter()`. Base classes `ShippingMethodBase` and
  `ConfigurableShippingMethodBase` (adds a `configure` plugin form).

## Manager API (`ShippingMethodManager`)

`getAllShippingMethods()`, `getShippingMethods()` (active only), `getShippingMethod($id)`,
`getAvailableShippingMethods($order)` (filters by `isAvailable($order)`),
`getAvailableShippingMethodsForAddress($address)`, `getShippingPrices($order)` (per-method
`getShippingPrice($order)`).

## Method behaviour (`ShippingMethodBase`)

- Active flag, weight and settings in KeyValue store `arch_shipping.{plugin_id}`
  (`isActive()`, `enable()`, `disable()`, `getWeight()`/`setWeight()`).
- `isAvailable($order)` = active AND not forbidden by any `hook_shipping_method_access()` implementation.
- `getShippingPrice($order)` returns an Arch price (via `@price_factory`) — computed **server-side**;
  never read from the request.

## Routes & permission (all `_permission: 'administer shipping methods'`)

- `arch_shipping.shipping_method.overview` — `/admin/store/settings/shipping-methods` (`OverviewForm`).
- `arch_shipping.configure_plugin` — `/admin/store/settings/shipping-methods/{shipping_method}`
  (`ShippingMethodConfigureController::settings` → `ShippingMethodForm`).
- `arch_shipping.enable_method` / `arch_shipping.disable_method` —
  `/admin/store/settings/shipping-methods/{shipping_method}/enable|disable`
  (`ShippingMethodConfigureController::enable()/disable()`).

## Extension points

- `hook_shipping_method_access($shipping_method, $order, $account)` — return an `AccessResult` to
  veto a method for an order (see `arch_shipping.api.php`).
- `hook_shipping_methods_plugin_alter()` — alter plugin definitions.
- `ShippingMethodExtraLineItemInterface` — add extra order line items;
  `ShippingPriceLabelInterface` — custom price label. Field formatter `ShippingMethodFormatter`.

## Other plugins/classes

- `Plugin/Field/FieldFormatter/ShippingMethodFormatter` — displays the selected method.
- Forms: `Form/OverviewForm`, `Form/ShippingMethodForm` (+ `ShippingMethodFormInterface`).
