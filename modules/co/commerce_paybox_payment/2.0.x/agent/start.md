<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Paybox Payment (commerce_paybox_payment) — agent index

**Drupal Commerce payment gateway for Paybox/Verifone; the customer return is signature-verified before any payment is recorded.**

- **Version:** 2.0.x
- **Core:** ^10.1 || ^11
- **Dependency:** commerce_payment
- **Gateway:** `Plugin/Commerce/PaymentGateway/Paybox`; forms `RedirectPayboxForm`, `PayboxPaymentAddForm`.
- **Routes:** `payment_api_return` `/checkout/{commerce_order}/payment/api-return` (req `_payment_return_access_check`); admin add-payment redirect/return/cancel routes (req `_entity_create_any_access: 'commerce_payment'`).
- **Services:** `payment_return.access_checker` (`PaymentReturnAccessCheck`), `commerce_paybox_payment.pbx_cmd_ref_helper` (`PbxCmdRefHelper`), `commerce_paybox_payment.paybox_direct_api` (`PayboxDirectApiService`); `SignatureChecker::checkSignature()` = `openssl_verify()`.

**Security:** SOUND — `PaymentReturnAccessCheck::access()` forbids authenticated users, requires Ref/Mt/Signature/Error, forbids already-`completed` payments, and requires `SignatureChecker::checkSignature() === 1` (openssl_verify) before the return controller runs. No bypass. Admin routes gated by commerce_payment create access.

See [configure/gateway.md](configure/gateway.md).