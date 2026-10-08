<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Set up Pick Pack Pont pickup shipping

1. `composer require drupal/commerce_shipping_pickup_pickpackpont` then `drush en commerce_shipping_pickup_pickpackpont`. This pulls in `commerce_shipping_pickup_api` and Drupal Commerce.
2. In your checkout flow add the `pickup_capable_shipping_information` pane (labelled *Shipping information*, summary shows *Supports pickup*), or switch to the pre-built `pickup` flow.
3. Add a shipping method in *Commerce → Configuration → Shipping methods* using the **Pickup shipping - Pick Pack Pont** (`pickup_hu_pickpackpont`) plugin.
4. Fill the base pickup fields inherited from `PickupShippingMethodBase`: **Rate label** (required), **Rate description** (optional), **Rate amount** (required `commerce_price`). There are no Pick Pack Pont-specific settings.

## How selection works
- `buildFormElement()` embeds a fixed `<iframe src="https://online.sprinter.hu/terkep/#/">` (the Sprinter/PickPackPont map) plus a hidden `id` and readonly `name`/`address` textfields. No API key, no server-side request.
- `commerce_shipping_pickup_pickpackpont_page_attachments_alter()` attaches library `commerce_shipping_pickup_pickpackpont/pickpackpont` on any path starting `/checkout/`.
- `js/pickpackpont.js`: on a `window` `message`/`onmessage` event it does `JSON.parse(e.originalEvent.data)` and sets the `pickup_dealer[id]`, `[name]`, `[address]` inputs from `data.shopCode`, `data.shopName`, `data.address`.
- `populateProfile()` writes the captured values into the shipment profile address (`country_code = HU`, `organization = name`, `address_line1 = address`).

## Notes
- No routes, permissions, services, cron, or database tables of its own — everything runs at checkout time.
- The rate is taken from the shipping-method configuration server-side; it is not read from the client.
- Full Hungarian UI localization installs automatically (`translations/hu.po`).
