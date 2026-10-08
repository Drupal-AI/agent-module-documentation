<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Modular Finance (modular_finance) — agent index

**Embeds Modular Finance (modularfinance.se) investor-relations widgets as blocks by emitting widget/client tokens into drupalSettings for a client-side JS library.**

- **Version:** 3.0.x
- **Core:** ^10 || ^11 · **Package:** Modular Finance
- **Configuration:** `entity.modular_finance_type.collection` (type CRUD) and `/admin/config/modular_finance/settings` (global `client_token`, `_permission: access administration pages`).
- **Entities:** `modular_finance_type` config entity (`getWidgetToken()`, `getWidgetType()`).
- **Block:** `modular_finance_block` — attaches library `modular_finance/modular-finance` and pushes `{query, widget, token, locale, c: client_token}` into `drupalSettings.modularFinance`.
- **Security:** no server-side HTTP/API call — data is fetched in-browser by the vendor JS, so there is no server-side TLS to verify. `client_token` is stored in plain config (`modular_finance.settings`) and rendered into client-side `drupalSettings` by design (publishable widget token, not a secret). No untrusted request-data sinks.

See [configure/setup.md](configure/setup.md)
