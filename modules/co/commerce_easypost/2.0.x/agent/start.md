<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce EasyPost (commerce_easypost) — agent index

**A Commerce Shipping method plugin bridging Commerce to the EasyPost API for rates, labels, tracking and pickups.**

- **Version:** 2.0.x (2.0.2)
- **Core:** ^10 || ^11
- **Depends:** telephone, commerce_shipping, commerce_shipping_label
- **Shipping method:** `easypost` (`src/Plugin/Commerce/ShippingMethod/EasyPost.php`) — implements remote shipments, label import, tracking, pickup scheduling.
- **Service:** `commerce_easypost.manager` (`EasyPostManager`) wrapping `EasyPost\EasyPostClient`; also service descriptions, early order processor, shipment & label-list subscribers.
- **Checkout panes:** `CustomerCarrierAccount`, `CustomerPhoneNumber`.
- **No routes / no permissions.yml / no webhooks.**

**Security:**
- API key stored as a plaintext textfield in the shipping-method config (`EasyPost.php:185-186`, saved at `:357`) — standard Commerce pattern, but not encrypted / not a Key entity; readable by anyone who can edit shipping methods.
- TLS not disabled — all calls use the official EasyPost SDK over HTTPS (`EasyPostManager.php:88`, `new EasyPostClient($api_key)`); no `verify => false`, no raw HTTP client. (The `'verify' => ['delivery','zip4']` at `EasyPostManager.php:191` is an EasyPost address-verification option, not TLS.)
- No anonymous callback surface — no routing.yml, no controllers, no webhook; label buy/refund/pickup run from authenticated Commerce admin flows.

See [configure/shipping-method.md](configure/shipping-method.md)