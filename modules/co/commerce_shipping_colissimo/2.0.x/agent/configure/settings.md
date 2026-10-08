<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Colissimo shipping

## Credentials & API
Edit at `/admin/commerce/config/colissimo` (perm `administer site configuration`), stored in config `commerce_shipping_colissimo.settings`:
- `user` / `password` — Colissimo account login and password.
- `base_url` — API base, defaults to `https://ws.colissimo.fr`.
- `debug_mode` — logs full request/response (incl. credentials) to channel `commerce_shipping_colissimo`. Non-prod only.

## Label generation
- `label_size` (A4/A5), `label_format` (PDF…), `default_parcel_weight_in_kg`, `average_preparation_delay_in_days`, `label_sender_parcel_id_source`.
- Labels are produced by the La Poste label web service (`Api\LabelApi` + `Labels`) and saved as files via `file.repository`.

## Shipping method
Add a shipping method whose plugin is `commerce_shipping_colissimo`. The plugin config exposes a Colissimo shipping type (`radios`: home delivery / with signature / relay) and a rate label. For relay, `WidgetApi::getWidgetAuthenticationToken()` authenticates against the widget REST endpoint (token cached 5 min) to render the pickup-point map.

## Checkout
Add the Colissimo checkout pane (`ColissimoShippingInformation`) to the checkout flow; relay selection uses the `ColissimoRelayProfile` inline form and copies the chosen point into the shipping profile.

## Security notes
- All HTTP via core `http_client` (Guzzle) — TLS verification is on; no `verify => false` anywhere.
- Credentials are stored plaintext in config; to avoid committing them, override `commerce_shipping_colissimo.settings` `user`/`password` from `settings.php`.
