Umbrella module that defines a pluggable shipping-method system for Arch orders, with server-side price calculation per method.

---

`arch_shipping` provides the framework for delivery options in an Arch store. It declares a `shipping_method` plugin type — managed by `ShippingMethodManager` (`plugin.manager.shipping_method`), discovered from each module's `Plugin/ShippingMethod` namespace via the `@ShippingMethod` annotation, and altered through `hook_shipping_methods_plugin_alter()`. A method advertises whether it is active (per-plugin KeyValue store `arch_shipping.{id}`), whether it is available for a given order (via `hook_shipping_method_access()` and `isAvailable()`), and computes its own delivery price for an order through the Arch price factory (`getShippingPrice()`). Store administrators manage the list at `/admin/store/settings/shipping-methods` — enabling, disabling, weighting and configuring each method (permission `administer shipping methods`). The module ships no method itself; the `arch_shipping_instore` submodule provides the "In store" pickup method.

---

- Offer customers a choice of delivery methods at checkout.
- Add custom shipping methods by writing a `@ShippingMethod` plugin (extend `ShippingMethodBase` / `ConfigurableShippingMethodBase`).
- Compute delivery cost server-side per method, per order, via the Arch price factory (with VAT support).
- Enable or disable individual shipping methods from the admin UI.
- Order/weight shipping methods to control their display order at checkout.
- Give each configurable method its own settings form (plugin `forms.configure`).
- Restrict a method's availability per order using `hook_shipping_method_access()` (e.g. hide a method for anonymous orders).
- Restrict a method's availability by delivery address (`isAvailableForAddress()`).
- Store per-method settings (status, weight, custom config) in a KeyValue store rather than exported config.
- Query available shipping methods for an order (`getAvailableShippingMethods()`) or an address.
- Fetch all shipping prices for an order at once (`getShippingPrices()`).
- Provide a field formatter to display the chosen shipping method (`ShippingMethodFormatter`).
- Add extra order line items from a shipping method (`ShippingMethodExtraLineItemInterface`).
- Integrate delivery pricing with the rest of Arch's order totals and VAT handling.
- Build "click and collect" / in-store pickup with the bundled `arch_shipping_instore` submodule.
- Centralize all shipping administration under the store settings menu.
- Let other modules react to or alter the list of available methods before checkout.
