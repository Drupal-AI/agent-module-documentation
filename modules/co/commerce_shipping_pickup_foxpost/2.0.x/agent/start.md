<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Shipping Pickup Foxpost (commerce_shipping_pickup_foxpost) — agent index

**Foxpost (Hungary) parcel-machine pickup shipping method on the commerce_shipping_pickup_api framework.**

- **Version:** 2.0.x  **Core:** ^8.7.7 || ^9 || ^10 || ^11
- **Depends:** commerce_shipping_pickup_api
- **Shipping plugin:** `pickup_hu_foxpost` (`@CommerceShippingMethod`)
- **Data:** pickup points fetched from `https://cdn.foxpost.hu/...json` (core `http_client`), stored serialized in table `commerce_shipping_pickup_foxpost`; refreshed by `hook_cron` on a per-method interval.
- **Routes/permissions/services:** none — checkout-time plugin only.
- **Security:** no routes and no anonymous/mutating endpoints. Outbound fetch uses Drupal `http_client` with TLS verification on. `getPickups()` calls `unserialize()` on the module's own cached blob (flat array of scalar strings, not request data) — no `allowed_classes => FALSE` but no realistic injection surface.

See [configure/setup.md](configure/setup.md).
