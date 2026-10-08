<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Shipping Pickup GLS CsomagPont (commerce_shipping_pickup_gls_csomagpont) — agent index

**GLS CsomagPont (Hungary) parcel-point pickup shipping methods, built on the commerce_shipping_pickup_api framework.**

- **Version:** 2.0.x  **Core:** ^8.7.7 || ^9 || ^10 || ^11
- **Depends:** commerce_shipping_pickup_api (which pulls in drupal/commerce ^2.11 || ^3.0)
- **Package:** Commerce (contrib). Full Hungarian localization ships in `translations/hu.po`.
- **Routes / permissions / services / Drush:** none — checkout-time shipping-method plugins only.

## Two shipping-method plugins

Both extend `PickupShippingMethodBase` from commerce_shipping_pickup_api.

1. **`pickup_hu_gls_csomagpont`** — `GlsCsomagPontShipping` (dropdown selector).
   - `buildFormElement()`: two selects — **locality** then **point/address**. Changing locality
     fires a Form API `#ajax` callback `getStreetValues()` that rebuilds the address `<option>` list
     from the already-loaded catalogue.
   - Config form adds `cron_interval` select (Disabled / Hourly / Daily / Weekly); stored and read
     back via `state` key `commerce_shipping_pickup_gls_csomagpont.next_run`.
   - `populateProfile()`: looks the selected point id up in the server-side catalogue
     (`array_key_exists`) and writes `country_code=HU` + `organization` from that record.

2. **`pickup_hu_gls_csomagpont_map`** — `GlsCsomagPontMapShipping` (map selector).
   - `buildFormElement()`: renders GLS's own web component `<gls-dpm>` in
     `#pickup-gls-csomagpont-map-canvas`, plus hidden `id` and readonly `name`/`address` fields.
   - Config form adds required `map_api_key` textfield, persisted to config
     `commerce_shipping_pickup_gls_csomagpont.settings:google_maps_api_key`; save invalidates the
     `library_info` cache tag.
   - `populateProfile()`: writes `country_code=HU` + `organization`/`address_line1` from the
     selected point's `pickup_location_data`.

## Pickup-point catalogue (dropdown plugin)

- `_commerce_shipping_pickup_gls_csomagpont_load()` (.module) GETs the fixed HTTPS URL
  `https://map.gls-hungary.com/data/deliveryPoints/hu.json` via `\Drupal::httpClient()` and maps
  each item to id/name/organization/locality/postal_code/address_line1.
- `_commerce_shipping_pickup_gls_csomagpont_save()` sorts with a Hungarian `Collator` (numeric
  collation on) and `merge()`s a `serialize()`d `id => record` map into the custom table
  `commerce_shipping_pickup_gls_csomagpont` (`hook_schema` in the `.install`).
- `GlsCsomagPontShipping::getPickups()` reads and `unserialize()`s that blob; if empty it refreshes
  on demand. `hook_cron` re-runs the fetch when `next_run` is due and reschedules by the method's
  `cron_interval`.
- On fetch failure it logs to channel `commerce_shipping_pickup_gls_csomagpont` and returns `[]`.

## Front-end wiring

- `hook_page_attachments_alter` attaches the module libraries on any `/checkout/*` path.
- Library `gls_csomagpont`: GLS widget `https://map.gls-hungary.com/widget/gls-dpm.js` (external ES
  module) + `js/gls_csomagpont.js` + `css/gls_csomagpont.css`; depends on `core/jquery`.
- `hook_library_info_build` defines `gls_csomagpont_map` only when `google_maps_api_key` is set,
  loading `https://maps.googleapis.com/maps/api/js?v=3&key=<key>`. The Google Maps JS key is a
  browser (client-side) key — restrict it by HTTP referrer / API in the Google Cloud console.
- `js/gls_csomagpont.js`: on the `<gls-dpm>` `change` event, copies the selected point's
  `id`/`name`/`contact` into the `pickup_dealer[id|name|address]` inputs (jQuery `.val()`).

## Setup (from README / hook_help)

Add the `pickup_capable_shipping_information` checkout pane (label *Shipping information*, summary
*Supports pickup*) or use the pre-built `pickup` checkout flow, then add a shipping method using one
of the two GLS plugins. See [usage.md](../usage.md) and [human-docs](../human-docs/index.md).
