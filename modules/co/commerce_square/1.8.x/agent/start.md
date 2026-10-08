<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Square — agent index

Adds a Drupal Commerce **on-site credit-card payment gateway** (`square`) backed by Square's
Connect APIs, in Sandbox (`test`) and Production (`live`) modes. Depends on `commerce` and
`commerce_payment`; requires the `square/square` PHP SDK. No plugin types, no Drush.

- **Application credentials & the settings form, per-gateway config, where tokens live** →
  [configure/settings.md](configure/settings.md)
- **The `square` payment gateway plugin & the OAuth production flow** →
  [plugins/gateway.md](plugins/gateway.md)
- **The `commerce_square.connect` service / building a Square API client** →
  [api/connect.md](api/connect.md)

Key facts:
- App settings config object: `commerce_square.settings` (keys `app_name`, `app_secret`,
  `sandbox_app_id`, `sandbox_access_token`, `production_app_id`). Form at
  `/admin/commerce/config/square` (route `commerce_square.settings`,
  permission `administer commerce square`).
- Per-gateway settings on the `commerce_payment_gateway` entity: `test_location_id`,
  `live_location_id`, `enable_credit_card_icons`.
- Production access/refresh tokens live in **state**, not config
  (`commerce_square.production_access_token`, `…_refresh_token`, `…_access_token_expiry`).
- Live/sandbox charges call Square's API over the network — ground local work in config/state,
  not in real API calls.
