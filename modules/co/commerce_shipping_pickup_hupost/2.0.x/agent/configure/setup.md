<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Set up Magyar Posta pickup shipping

## Plugins
- `pickup_hu_postapont` — PostaPont pickup points as a select list.
- `pickup_hu_postapont_map` — PostaPont points on a Google map (requires an API key).
- `pickup_hu_postacsomag` — parcel machines (Csomagautomaták).

## Steps
1. Install `commerce_shipping_pickup_api`; enable this module.
2. Add the `pickup_capable_shipping_information` pane to your checkout flow (or use the `pickup` flow).
3. Add shipping methods for the plugin(s) you need in *Commerce → Configuration → Shipping methods*.
4. For the **map** method, fill in *Google Maps JavaScript API key*. It is saved to `commerce_shipping_pickup_hupost.settings:google_maps_api_key` and `library_info` cache is invalidated.

## Data refresh
- `commerce_shipping_pickup_hupost_point_update()` / `_parcel_update()` GET `https://httpmegosztas.posta.hu/PartnerExtra/Out/PostInfo_PP.xml` and `PostInfo_CS.xml`, `simplexml_load_string` them, and `serialize()` an `id => label` map into the `commerce_shipping_pickup_hupost` table.
- `hook_cron` refreshes on the per-method interval (state key `commerce_shipping_pickup_hupost.next_run`).

## Map integration
- `hook_library_info_build` builds a `hupost_map` library whose external JS is `https://maps.googleapis.com/maps/api/js?...&key=$api_key` — only when a key is set.
- `hook_page_attachments_alter` attaches the map library on `/checkout/*` only.
- The key is a client-side Google Maps key by nature; restrict it by referrer/domain in Google Cloud.
