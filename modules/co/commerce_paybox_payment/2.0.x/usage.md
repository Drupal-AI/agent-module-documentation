<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides a Paybox (Verifone) payment gateway for Drupal Commerce, redirecting shoppers to Paybox and verifying the signed return before recording the payment.

---
The module registers a `Paybox` Commerce payment gateway plugin and a redirect form (`RedirectPayboxForm`) that posts the order to Paybox's hosted payment page. Command references are built/parsed by `PbxCmdRefHelper` (which also extracts the payment id from the `Ref` parameter), and a `PayboxDirectApiService` supports direct API operations. Admin routes under `/admin/commerce/orders/{commerce_order}/payments/...` let staff drive a redirect form, return and cancel flows, each guarded by `_entity_create_any_access: 'commerce_payment'`.

The customer return route `/checkout/{commerce_order}/payment/api-return` is protected by a custom access checker, `PaymentReturnAccessCheck` (`_payment_return_access_check`). Before the controller runs it: rejects authenticated sessions, requires the `Ref`, `Mt`, `Signature` and `Error` query parameters to be present, loads the payment referenced by `Ref`, forbids if the payment is already `completed`, and — critically — calls `SignatureChecker::checkSignature()` which runs `openssl_verify()` against Paybox's public key and only allows when it returns `1`. This means the fulfilment path cannot be reached with a forged or missing signature.

Setup: add the Paybox gateway in Commerce, supply the Paybox site/rank/identifier and HMAC/key material and the Paybox public key used for return verification, then configure the checkout flow to use it.
---
- Accept payments via Paybox/Verifone in Drupal Commerce.
- Redirect shoppers to Paybox's hosted payment page.
- Verify the signed Paybox return with `openssl_verify()` before recording payment.
- Reject return callbacks missing `Ref`/`Mt`/`Signature`/`Error` params.
- Prevent double-processing of an already-completed payment.
- Extract the payment id from the Paybox `Ref` parameter.
- Add a payment to an order from the admin UI (redirect form).
- Handle admin add-payment return and cancel flows.
- Use the direct API service for server-side operations.
- Restrict admin payment routes to `create commerce_payment` access.
- Log gateway activity to the `commerce_paybox_payment` channel.
- Configure Paybox site, rank and identifier credentials.
- Provide the Paybox public key for return-signature checking.
- Run in test then production Paybox environments.
- Map order totals to Paybox amount/currency.
- Integrate Paybox into a Commerce checkout flow.
- Forbid authenticated users on the anonymous return route.
- Build/parse Paybox command references via the helper service.
- Handle Paybox error codes on return.
- Finalise the order only after signature verification passes.