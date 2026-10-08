<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce GMO LinkTypePlus (commerce_gmo_linktypeplus) — agent index

**Drupal Commerce off-site payment gateway for GMO Payment Gateway (Mul-Pay) LinkTypePlus.**

- **Version:** 1.1.x (dev-1.1.x checkout)
- **Core:** ^10.1 || ^11 · requires `commerce_payment`
- **Gateway:** `src/Plugin/Commerce/PaymentGateway/LinkTypePlus.php` (off-site redirect); checkout panes `GmoPaymentInformation` / `GmoPaymentProcess`; off-site form `LinkTypePlusOffsiteForm`.
- **Order workflow:** `order_linktypeplus_validation` (draft→pending→completed/canceled) — assign at `/admin/commerce/config/order-types`.
- **Routes** (`src/Controller/GmoLinkTypePlusController.php`):
  - `/payment/success/order` → `responseProcessor` (`_custom_access` callback)
  - `/payment/response/save` → `responseSaver` (`_custom_access` callback)
  - `/reccuringcredit/response` → `recurringCreditWebhook` (`_permission: 'access content'`)
- Config at `/admin/commerce/config/payment-gateways`.

**Security:** response/webhook routes have a permissive access posture — the `_custom_access` callback returns `AccessResult::allowed()` unconditionally and the recurring route is gated only by `access content` (effectively anonymous); success handling trusts a base64 `result` POST for payment status with no signature/HMAC verification. Payment amount is derived from the loaded order (not the request). See the caller's security report — not documented here.

See [configure/gateway.md](configure/gateway.md)