<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Ingenico (commerce_ingenico) — agent index

**Two Drupal Commerce payment gateways for Ingenico/Ogone: on-site DirectLink and off-site e-Commerce, with SHA-signed requests and feedback.**

- **Version:** 1.x
- **Core:** ^9 || ^10 || ^11
- **Dependencies:** commerce, commerce_price (plus the `marlon-be/marlon-ogone` + `mobiledetect` libraries).
- **Gateways:** `ingenico_directlink` (`DirectLink`, on-site, Guzzle DirectLink API + Alias Gateway) and `ingenico_ecommerce` (`ECommerce`, off-site redirect POST via `ECommerceOffsiteForm`).
- **Shared traits:** `ConfigurationTrait` (PSPID, API user/pass, SHA-IN/SHA-OUT, algorithm, 3DS, white-label URLs), `OperationsTrait` (capture/void/refund/renew).
- **Feedback:** `onReturn()`/`onNotify()` → `processFeedback()` validates `SHASign` via `EcommercePaymentResponse::isValid()`; state advanced only from `onNotify()`.

**Security:** Callback integrity enforced — feedback rejected (`InvalidResponseException`, payment set `failed`) unless the SHA-OUT signature validates; outbound signed with SHA-IN; HTTP via default Guzzle client (TLS verification enabled). No disabled-TLS or unverified-callback finding.

See [configure/gateways.md](configure/gateways.md).