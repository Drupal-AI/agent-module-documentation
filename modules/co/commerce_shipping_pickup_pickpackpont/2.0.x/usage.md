<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Shipping Pickup Pick Pack Pont provides a Pick Pack Pont (Hungary) pickup-point shipping service as a `@CommerceShippingMethod` plugin (`pickup_hu_pickpackpont`) on top of the `commerce_shipping_pickup_api` framework.

---

At checkout the customer picks a Pick Pack Pont collection point from an embedded map. The plugin's `buildFormElement()` renders a fixed `<iframe src="https://online.sprinter.hu/terkep/#/">` (the Sprinter/PickPackPont point picker) alongside a hidden `id` field and readonly `name`/`address` textfields. There is no server-side API call and no HTTP client in this module — the map is a third-party browser widget. When the shopper picks a point, `js/pickpackpont.js` (attached on any `/checkout/*` path) receives a `window` `message` event, `JSON.parse`s it, and copies `data.shopCode`/`shopName`/`address` into the checkout `pickup_dealer[id|name|address]` inputs. `populateProfile()` then writes the chosen point into the shipment profile address as `country_code = HU`, `organization = name`, `address_line1 = address`.

The module exposes no routes, permissions, services, cron jobs, or database tables — it is entirely a checkout-time shipping plugin. There are no API keys, tokens, or account credentials anywhere in the source; the map widget is a public browser page loaded from a fixed HTTPS host. The rate comes from the shipping-method configuration (`rate_label`/`rate_description`/`rate_amount`) via the base class `calculateRates()`, server-side, not from the client. Full Hungarian UI localization installs automatically from `translations/hu.po`.

---
- Install `commerce_shipping_pickup_api` and Drupal Commerce, then enable this module.
- Add the `pickup_capable_shipping_information` checkout pane (labelled *Shipping information*).
- Or use the pre-built `pickup` checkout flow.
- Add a shipping method using the `pickup_hu_pickpackpont` plugin to your store.
- Set the Rate label, Rate description, and Rate amount on the shipping method.
- Let customers pick a Pick Pack Pont point from the embedded map at checkout.
- Populate the shipment profile address from the selected point.
- Ship orders to Hungarian (`HU`) Pick Pack Pont locations.
- Combine with other pickup providers (e.g. foxpost, hupost, gls_csomagpont) in one store.
- Rely on the base pickup framework for the pickup service and rate calculation.
- Serve the Pick Pack Pont point picker inside a fixed-host iframe (no API key).
- Localize the interface to Hungarian automatically on install.
- Restrict the method with the standard Commerce shipping conditions.
- Present the pickup point name and address as readonly checkout fields.
- Uninstall cleanly — no tables or state to remove.
