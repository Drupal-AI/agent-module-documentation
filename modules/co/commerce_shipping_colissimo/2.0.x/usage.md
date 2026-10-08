<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Shipping Colissimo adds a Colissimo (La Poste, France) shipping method to Drupal Commerce, supporting home delivery, relay pickup points on a map, tracking links and PDF label generation.

---

It plugs into `commerce_shipping` as a `@CommerceShippingMethod` plugin (`commerce_shipping_colissimo`) and into checkout through a Colissimo checkout pane and a relay-profile inline form. Store credentials (Colissimo `login`/`password`, base URL, defaults) are held in `commerce_shipping_colissimo.settings` and edited at `/admin/commerce/config/colissimo` (route `commerce_shipping_colissimo.settings`, permission `administer site configuration`). At checkout the shipping type is chosen per shipping method (home delivery with/without signature, or relay); for relay the module authenticates against the Colissimo widget API to render a pickup-point map centred on the customer's geolocation. Labels are generated through the La Poste label web service and stored as files.

Outbound API calls use Drupal's shared `http_client` (Guzzle) with default TLS verification — there is no `verify => false`. Credentials are read from config and injected into each request body by `UrlEncodedClient`/`MultipartRestClient`. Note the class constant `Settings::CONF_PASSWORD = 'password'` is a config *key name*, not a secret; the real password is stored in the `commerce_shipping_colissimo.settings` config object (plaintext, like most carrier modules). Enable `debug_mode` only in non-production: it logs full request/response bodies, which include the credentials.

---
- Install `commerce_shipping` + `commerce_shipping_label`, then enable this module.
- Enter Colissimo `login` and `password` at `/admin/commerce/config/colissimo`.
- Set the API base URL (defaults to `https://ws.colissimo.fr`).
- Add a Colissimo shipping method to a store's shipping configuration.
- Choose the Colissimo shipping type (home delivery / with signature / relay).
- Enable relay pickup and let customers select a point on the map at checkout.
- Add the Colissimo checkout pane to your checkout flow.
- Configure the default parcel weight (kg) used when items lack a weight.
- Set the average preparation delay in days for delivery estimates.
- Pick the generated label size (A4/A5) and format (PDF/others).
- Map which customer-profile field supplies the recipient phone number.
- Optionally source the phone number from the billing profile.
- Generate and download a shipping label for a shipment.
- Provide the parcel tracking link to customers.
- Toggle `debug_mode` to log raw API traffic while troubleshooting.
- Rotate Colissimo credentials by editing the settings form.
- Store the API password in config (or override via settings.php for secrets).
- Choose the label sender parcel-id source strategy.
- Restrict access to the settings form via `administer site configuration`.
- Review the logger channel `commerce_shipping_colissimo` for API errors.
