<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Perfect Money (perfectmoney) — agent index

**Perfect Money payment method for the AlternativeCommerce (Basket) module, with a signed status callback.**

- **Version:** 1.0.x
- **Core:** `^9 || ^10 || ^11`  •  Requires the Basket (AlternativeCommerce) module.
- **Config route:** `perfectmoney.settings` → `/admin/config/development/perfectmoney` (`access perfectmoney settings`, restricted).
- **Payment/callback route:** `/perfectmoney/{page_type}` → `Pages::pages` (permission `access content`, so the gateway callback is reachable).

**Security:** Sound (per prior review). The payment/status callback is signature-verified — the module recomputes `md5(...:ALTERNATE_PHRASE_HASH)` (passphrase + amount) and compares it to the gateway's `V2_HASH` before completing the payment, so an unauthenticated caller cannot forge order fulfilment without the secret passphrase. The public `access content` on the callback route is expected for an off-site gateway return and is backed by the hash check. Settings route is permission-restricted.

See [configure/perfectmoney.md](configure/perfectmoney.md).
