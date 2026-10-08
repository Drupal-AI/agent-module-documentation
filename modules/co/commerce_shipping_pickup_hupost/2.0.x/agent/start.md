<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Shipping Pickup Magyar Posta (commerce_shipping_pickup_hupost) — agent index

**Magyar Posta (Hungarian Post) PostaPont / parcel-machine pickup shipping, with an optional Google-Maps point picker.**

- **Version:** 2.0.x  **Core:** ^8.7.7 || ^9 || ^10 || ^11
- **Depends:** commerce_shipping_pickup_api
- **Shipping plugins:** `pickup_hu_postapont`, `pickup_hu_postapont_map` (map), `pickup_hu_postacsomag`
- **Config object:** `commerce_shipping_pickup_hupost.settings` → `google_maps_api_key` (set on the map method's config form)
- **Data:** points fetched from Magyar Posta PartnerExtra XML feeds via core `http_client`, stored serialized in table `commerce_shipping_pickup_hupost`; refreshed by `hook_cron`.
- **Security:** no routes and no anonymous/mutating endpoints. Feeds fetched via Drupal `http_client` with TLS verification on. Cached blob read with `unserialize()` (module's own flat scalar array, not request data). Google Maps key is a client-side key printed into a script URL by design — restrict by referrer in Google Cloud.

See [configure/setup.md](configure/setup.md).
