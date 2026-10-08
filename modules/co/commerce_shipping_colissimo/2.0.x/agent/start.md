<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Shipping Colissimo (commerce_shipping_colissimo) — agent index

**Adds a Colissimo (La Poste) Commerce shipping method: home delivery, relay pickup-point map, tracking and PDF label generation.**

- **Version:** 2.0.x  **Core:** ^11
- **Depends:** commerce_shipping, commerce_shipping_label, file
- **Config route:** `commerce_shipping_colissimo.settings` → `/admin/commerce/config/colissimo` (perm `administer site configuration`)
- **Config object:** `commerce_shipping_colissimo.settings` (login, password, base_url, label_size/format, weights, phone field)
- **Shipping plugin:** `commerce_shipping_colissimo` (`@CommerceShippingMethod`); Colissimo checkout pane + relay inline form
- **API clients:** `Api\UrlEncodedClient`, `Api\MultipartRestClient`, `Api\WidgetApi`, `Api\LabelApi` — all use core `http_client`
- **Security:** single admin config route gated by `administer site configuration`; no anonymous or mutating endpoints. Outbound API calls use Drupal `http_client` with **TLS verification on** (no `verify => false`). Credentials live in config as plaintext (standard for carrier modules); `debug_mode` logs request bodies incl. credentials — keep off in production. `CONF_PASSWORD='password'` is a config key name, not a hardcoded secret.

See [configure/settings.md](configure/settings.md).
