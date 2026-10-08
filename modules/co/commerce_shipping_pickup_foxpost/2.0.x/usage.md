<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Shipping Pickup Foxpost provides a Foxpost (Hungary) parcel-machine pickup shipping service as a `@CommerceShippingMethod` plugin (`pickup_hu_foxpost`) on top of the `commerce_shipping_pickup_api` framework.

---

At checkout the customer selects a Foxpost pickup point from a select list; the chosen point is written into the shipping profile's address (`country_code = HU`). The pickup-point catalogue is fetched from Foxpost's public CDN (`https://cdn.foxpost.hu/foxpost_terminals_extended_v3.json`) via Drupal's `http_client`, normalised to an array of `id => label` strings, and stored serialized in the module's own `commerce_shipping_pickup_foxpost` database table. A configurable per-method cron interval (hourly/daily/weekly, via `hook_cron` + `state`) refreshes the list; it also refreshes lazily the first time the list is empty.

The module exposes no routes, permissions or services and no anonymous endpoints — it is entirely a checkout-time shipping plugin. `getPickups()` reads the cached blob with `unserialize()`; the data is produced by the module itself from the provider feed and is a flat array of scalar strings (no objects), so there is no realistic object-injection surface, though `unserialize()` without `['allowed_classes' => FALSE]` is worth noting. TLS verification on the outbound fetch is Drupal's default (enabled).

---
- Install `commerce_shipping_pickup_api`, then enable this module.
- Add the `pickup_capable_shipping_information` checkout pane (labelled *Shipping information*).
- Or use the pre-built `pickup` checkout flow.
- Add a shipping method using the `pickup_hu_foxpost` plugin to your store.
- Set the pickup-list refresh frequency (disabled/hourly/daily/weekly).
- Let cron refresh the Foxpost pickup points on the chosen interval.
- Trigger a manual refresh by clearing the table / first empty load.
- Let customers pick a Foxpost parcel machine at checkout.
- Populate the shipment profile address from the selected point.
- Ship orders to Hungarian (`HU`) Foxpost locations.
- Inspect the `commerce_shipping_pickup_foxpost` table for cached points.
- Review the `commerce_shipping_pickup_foxpost` logger channel on fetch failure.
- Combine with other pickup providers (e.g. hupost) in one store.
- Sort pickup points using Hungarian collation for display.
- Disable refresh (interval 0) to freeze the current point list.
- Uninstall to drop the cache table and clear the cron state.
