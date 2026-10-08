<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Shipping Pickup Pick Pack Pont (commerce_shipping_pickup_pickpackpont) — agent index

**Pick Pack Pont (Hungary) pickup-point shipping method on the commerce_shipping_pickup_api framework.**

- **Version:** 2.0.x  **Core:** ^8.7.7 || ^9 || ^10 || ^11
- **Depends:** commerce_shipping_pickup_api (which requires drupal/commerce)
- **Shipping plugin:** `pickup_hu_pickpackpont` — `PickPackPontShipping extends PickupShippingMethodBase` (`@CommerceShippingMethod`, label "Pickup shipping - Pick Pack Pont").
- **Point selection:** `buildFormElement()` renders a fixed `<iframe src="https://online.sprinter.hu/terkep/#/">` map (the Sprinter/PickPackPont point picker) plus a hidden `id` field and readonly `name`/`address` textfields. There is **no server-side API call and no HTTP client** in this module — the map is a third-party browser widget.
- **Client glue:** `js/pickpackpont.js` (attached on any `/checkout/*` path via `hook_page_attachments_alter`) listens for `window` `message` events, `JSON.parse`s the payload, and copies `data.shopCode`/`shopName`/`address` into the checkout `pickup_dealer[id|name|address]` inputs.
- **Profile write:** `populateProfile()` sets the shipment address to `country_code = HU`, `organization = name`, `address_line1 = address` from `pickup_location_data` (the values captured above).
- **Rate:** from the shipping-method config (`rate_amount`/`rate_label`/`rate_description`) via the base class `calculateRates()` — server-side, not client-supplied. Config schema: `commerce_shipping_pickup_pickpackpont.schema.yml`.
- **Routes / permissions / services / config form of its own:** none — checkout-time plugin only. Ships full Hungarian translation (`translations/hu.po`, wired via `hook_locale_translation_projects_alter`).
- **Security:** no routes and no anonymous/mutating endpoints. The iframe host is a hardcoded constant (no request-supplied URL → no SSRF). No API keys, tokens, or account credentials exist anywhere in the source. The selected point's name/address are captured from the map widget into the buyer's own shipment profile address; the rate is config-driven server-side.

See [configure/setup.md](configure/setup.md).
