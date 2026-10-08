<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Trinion Cart Tinkoff Payment (trinion_cart_tinkoff_payment) — agent index
**Adds the Tinkoff (T-Bank) payment gateway to Trinion Cart; a SHA-256 token-verified callback confirms orders.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 || ^11 · **Package:** Trinion · **Depends:** trinion_cart
- **Config route:** `trinion_cart_tinkoff_payment.settings_form` → `/admin/config/system/trinion-tinkoff` (perm `administer trinion_cart_tinkoff_payment configuration`)
- **Callback:** `trinion_cart_tinkoff_payment.complete` → `tinkoff/complete` (perm `access content`) — `TinkoffController::complete`
- **Return pages:** `payment/success`, `payment/error` (perm `access checkout`)
- **Service class:** `TinkoffMerchantAPI` (Tinkoff v2 REST, `https://securepay.tinkoff.ru/v2/`)

**Security:** The `tinkoff/complete` callback is `access content` (anonymous-reachable) but fulfilment is gated by a SHA-256 token check (`get_tinkoff_token()` with the merchant `secret_key`), so unsigned callbacks are rejected.

See [configure/settings.md](configure/settings.md)
