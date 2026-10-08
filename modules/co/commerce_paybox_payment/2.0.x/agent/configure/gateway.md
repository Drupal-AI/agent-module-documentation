<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Commerce Paybox Payment

## Prerequisites
- `commerce_payment` enabled.
- A Paybox/Verifone merchant account (site, rank, identifier) and the Paybox public key used to verify return signatures.

## Add the gateway
`admin/commerce/config/payment-gateways` → Add → Paybox. Supply the Paybox credentials (site / rank / identifier), the secret/HMAC material for request signing, the Paybox public key for return verification, and test vs production mode. Attach it to your checkout flow.

## Routes
- Customer return: `GET /checkout/{commerce_order}/payment/api-return` → `PaymentController::return`, access `_payment_return_access_check`.
- Admin, all requiring `create commerce_payment` access:
  - `/admin/commerce/orders/{commerce_order}/payments/{commerce_payment}/paybox-redirect-form` → `buildAdminPayboxRedirectForm`
  - `.../add-payment-return` → `addPaymentReturn`
  - `.../add-payment-cancel` → `addPaymentCancel`

## Return access / signature verification (`PaymentReturnAccessCheck::access`)
Order of checks (any failure → `AccessResult::forbidden()`):
1. `$account->isAuthenticated()` → forbidden (return route is for the anonymous redirect back).
2. Each of `Ref`, `Mt`, `Signature`, `Error` query params must be non-empty.
3. Load payment via `PbxCmdRefHelper::extractPaymentIdFromRef()`; must be a `PaymentInterface`.
4. If payment state is already `completed` → forbidden (no reprocessing).
5. `SignatureChecker::checkSignature($request) === 1` — `openssl_verify($data, $sig, $key)` against the Paybox public key.

Only when all pass does the controller run and record the payment, so forged/missing signatures cannot trigger fulfilment.

## Services
- `PbxCmdRefHelper` — builds/parses Paybox command references and extracts the payment id.
- `PayboxDirectApiService` — direct (server-to-server) API operations.