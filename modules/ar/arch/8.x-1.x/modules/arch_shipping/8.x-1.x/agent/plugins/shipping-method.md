<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `shipping_method` plugin type

## Enable

```bash
drush en arch_shipping -y
```

Depends on `arch`, `arch_order`. Provides the plugin type only; enable `arch_shipping_instore` (or
your own plugin) for an actual delivery option.

## Defining a method

Place a plugin class in your module's `Plugin/ShippingMethod/` namespace with the `@ShippingMethod`
annotation (`Annotation\ShippingMethod`: `id`, optional `module`, optional `form`) and extend one of:

- `ShippingMethodBase` — non-configurable method.
- `ConfigurableShippingMethodBase` — adds a `configure` plugin form (`PluginFormInterface`); declare
  it in the annotation `forms = { "configure" = "\\...\\SomeForm" }`.

```php
/**
 * @ShippingMethod(
 *   id = "instore",
 *   label = @Translation("In store"),
 *   forms = { "configure" = "\Drupal\arch_shipping_instore\Form\AddressOverviewForm" },
 * )
 */
class InStoreShippingMethod extends ConfigurableShippingMethodBase {
  public function getShippingPrice(OrderInterface $order) { /* return a price */ }
}
```

The manager `ShippingMethodManager` (`plugin.manager.shipping_method`, `parent:
default_plugin_manager`) discovers them and applies `hook_shipping_methods_plugin_alter()`.

## Per-method state and settings

`ShippingMethodBase` keeps state in the **KeyValue store** `arch_shipping.{plugin_id}` (injected
`@keyvalue`), not exported config:

- `isActive()` / `enable()` / `disable()` — the `status` flag.
- `getWeight()` / `setWeight()` — display order.
- `getSetting()/setSetting()` — arbitrary per-method settings (e.g. the instore method stores its
  `addresses` array here).

`ConfigurableShippingMethodBase` wires the plugin's `configure` form into the admin settings page
via `PluginWithFormsTrait` + `SubformState` (`configFormAlter/Validate/PostSubmit`).

## Availability and price (server-side)

- `isAvailable(OrderInterface $order)` — FALSE unless active; then it runs every
  `hook_shipping_method_access($method, $order, $currentUser)` implementation and is available unless
  any returns a **forbidden** `AccessResult`. Example in `arch_shipping.api.php`: forbid `instore`
  for anonymous-owned orders.
- `isAvailableForAddress($address)` — default TRUE; override to geo-restrict.
- `getShippingPrice(OrderInterface $order)` — returns an Arch price built through `@price_factory`.
  This is computed on the server from the method's own configuration and the order; it is **not**
  taken from any client input, so the delivery cost cannot be tampered with via the request. The
  instore method returns a fixed free price (`net/gross = 0`, `vat_category custom`).

The manager aggregates these: `getAvailableShippingMethods($order)`,
`getAvailableShippingMethodsForAddress($address)`, and `getShippingPrices($order)` (id → price).

## Admin UI

All under permission **`administer shipping methods`** (`arch_shipping.permissions.yml`):

| Route | Path | Handler |
|---|---|---|
| `arch_shipping.shipping_method.overview` | `/admin/store/settings/shipping-methods` | `Form\OverviewForm` |
| `arch_shipping.configure_plugin` | `/admin/store/settings/shipping-methods/{shipping_method}` | `ShippingMethodConfigureController::settings` → `Form\ShippingMethodForm` |
| `arch_shipping.enable_method` | `.../{shipping_method}/enable` | `ShippingMethodConfigureController::enable()` |
| `arch_shipping.disable_method` | `.../{shipping_method}/disable` | `ShippingMethodConfigureController::disable()` |

The overview and configure pages are standard forms; enable/disable are controller actions that flip
the method's `status` in the KeyValue store and redirect back.

## Extra line items & labels

- `ShippingMethodExtraLineItemInterface` — a method may contribute additional order line items.
- `ShippingPriceLabelInterface` — customise how the shipping price is labelled.
- Field formatter `Plugin/Field/FieldFormatter/ShippingMethodFormatter` displays the selected method
  on an order.
