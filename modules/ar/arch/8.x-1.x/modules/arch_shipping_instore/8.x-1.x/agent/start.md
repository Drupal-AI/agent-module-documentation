<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# InStore shipping method (arch_shipping_instore) — agent index

Arch Shipping submodule adding a **free in-store pickup** (click-and-collect) shipping method plus an
admin UI to manage pickup addresses. Package *Arch Shipping*. Depends on **`arch`** and
**`arch_shipping`**. No own permissions/config schema. Core `^9.4 || ^10 || ^11`. License
GPL-2.0-or-later.

## What it provides (from source)

- **Shipping method plugin** — `Plugin/ShippingMethod/InStoreShippingMethod` (id `instore`, extends
  `ConfigurableShippingMethodBase`; configure form `AddressOverviewForm`). `getShippingPrice($order)`
  returns a **zero** price (`net 0`, `gross 0`, `vat_category custom`) via the injected Arch
  `price_factory` — the cost is server-computed, never read from the request.
- **Routes** (`arch_shipping_instore.routing.yml`), all `_admin_route` + `_permission:
  'administer shipping methods'`:
  - overview `/admin/store/settings/shipping-methods/instore/address` (`AddressOverviewForm`).
  - add `/…/address/add` and edit `/…/address/{address_id}` (`AddressForm`).
  - delete `/…/address/{address_id}/delete` (`AddressDeleteForm`).
- **Forms** — `AddressForm` (a `machine_name`-id'd address record), `AddressDeleteForm`,
  `AddressOverviewForm`; addresses are persisted in a KeyValue collection.

## Notes

All routes are behind the parent module's `administer shipping methods` permission and use standard
`FormBase` forms (CSRF-protected). Address ids are `#type => machine_name`-validated. There is no
customer-facing state-changing route in this submodule.
