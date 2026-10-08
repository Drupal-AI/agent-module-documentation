<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Shipping Pickup Magyar Posta adds Hungarian Post (Magyar Posta) pickup shipping to Drupal Commerce as a set of `@CommerceShippingMethod` plugins built on `commerce_shipping_pickup_api`: `pickup_hu_postapont` (PostaPont list), `pickup_hu_postapont_map` (PostaPont on a Google map) and `pickup_hu_postacsomag` (parcel machines).

---

Pickup points are fetched from Magyar Posta's public PartnerExtra XML feeds (`PostInfo_PP.xml`, `PostInfo_CS.xml`) via Drupal's `http_client`, parsed with `simplexml_load_string`, sorted with Hungarian collation and stored serialized in the module's `commerce_shipping_pickup_hupost` table; a `hook_cron` interval refreshes them. The list variant renders a select; the map variant renders a `<div>` map canvas and requires a Google Maps JavaScript API key. That key is stored in `commerce_shipping_pickup_hupost.settings` (`google_maps_api_key`), set on the map shipping-method's config form, and injected into the Google Maps script URL by `hook_library_info_build`; the map library is attached only on `/checkout/*` pages.

The module exposes no routes, permissions or services and no anonymous endpoints. Outbound fetches use Drupal's `http_client` with default TLS verification (enabled). Cached point data is read with `unserialize()`; it is the module's own serialized flat `id => label` array (not request data), so there is no realistic object-injection surface. The Google Maps API key is a client-side key printed into a script URL by design — restrict it by referrer/domain in the Google console.

---
- Install `commerce_shipping_pickup_api`, then enable this module.
- Add a PostaPont list shipping method (`pickup_hu_postapont`).
- Add a PostaPont map shipping method (`pickup_hu_postapont_map`).
- Add a parcel-machine shipping method (`pickup_hu_postacsomag`).
- Enter a Google Maps JavaScript API key on the map method's config form.
- Add the `pickup_capable_shipping_information` pane to checkout.
- Or use the pre-built `pickup` checkout flow.
- Let customers pick a PostaPont from a select list at checkout.
- Let customers pick a point on the Google map at checkout.
- Populate the shipment address from the selected point (`HU`).
- Set the per-method cron refresh interval for point data.
- Let cron refresh PostaPont and parcel-machine feeds.
- Inspect the `commerce_shipping_pickup_hupost` table for cached points.
- Restrict the Google Maps key by HTTP referrer in Google Cloud.
- Review the `commerce_shipping_pickup_hupost` logger channel on feed errors.
- Ship orders to Hungarian pickup locations.
- Uninstall to remove cached point data and cron state.
