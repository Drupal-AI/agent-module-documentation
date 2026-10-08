<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Return / notify handling and 3-D Secure Payer Authentication

How each gateway validates data coming back from CyberSource, and how the Flex/Unified Checkout 3DS
(Payer Authentication) flow works. All three gateways verify the authenticity of inbound data before
recording a payment.

## SAHC reply verification (`CyberSourceSahc`)

`onReturn(OrderInterface $order, Request $request)` handles the browser POST back from the hosted
page:
1. Confirms `req_reference_number` equals `$order->id()`.
2. Loads the `commerce_payment` by `req_transaction_uuid` and confirms it belongs to the order.
3. `validateResponse()` recomputes the signature: it explodes `signed_field_names`, gathers those
   fields, calls `signData()` (base64 HMAC-SHA256 over `key=value,…` using `secret_key`), and
   compares with `hash_equals($signed_string, $signature)` — constant-time, no type juggling. A
   well-formed reply with a bad signature is logged at `warning` level unconditionally (possible
   tampering) and rejected; a missing signature / missing signed-field-names / unset secret key also
   fail closed.
4. Only on a valid signature does `updatePayment()` run: `ACCEPT` sets AVS code/label, remote id =
   payment token, amount, and state `pending` (auth+token) or `completed` (sale+token); `CANCEL` /
   `DECLINE` / `REVIEW` / `ERROR` delete the payment, write a `commerce_cybersource.order_comment`
   log entry, and throw `PaymentGatewayException`.

## Unified Checkout return verification (`UnifiedCheckout::onReturn`)

The customer returns to `commerce_payment.checkout.return` / `commerce_payment.order.merchant_return`
with `response` (a signed capture-context response JWT) and `jti` query params:
1. `CaptureContextParser::parseCaptureContextResponse($response, merchantConfig)` verifies the JWT
   against the merchant config; failure logs and throws `HardDeclineException`.
2. Requires decoded `status === 'AUTHORIZED'`, else `InvalidResponseException`.
3. **Replay guard:** `payment_storage->loadByRemoteId($id)` — if the transaction id is already
   recorded on another order, logs and throws `HardDeclineException` (no reuse across orders).
4. Fetches the transaction via `TransientTokenDataV2Api::getTransactionForTransientTokenJTI($jti)`.
5. **Amount guard (checkout return):** the JWT-reported `authorizedAmount` must cover the order
   balance, else `HardDeclineException` — a short authorization cannot complete the order.
6. Creates the payment method (`createPaymentMethodFromPayment` — syncs billing profile from the
   verified remote billTo, maps card type/masked number/expiry, stores TMS paymentInstrument id) and
   the payment (`createPaymentFromTransaction`), then places the order.

## Flex Payer Authentication (3DS) flow

Enabled per-gateway with `enable_payer_authentication`; optional `require_3ds_challenge` forces a
step-up (challengeCode `04`, needed for EU SCA). Requires adding the **`cybersource_flex_review`**
checkout pane (`FlexReview`) to the `review` step.

1. **Setup** — on the Flex add-payment-method form, `FlexForm` attaches
   `payerAuthenticationSetupUrl` (route `commerce_cybersource.payer_authentication.setup`). The
   client posts the transient token; `PayerAuthenticationController::setup()` (access gated by
   `_entity_access: commerce_order.update`) calls `PayerAuthenticationApi::payerAuthSetup` and stores
   the returned `referenceId` in the order's `cybersource_payer_auth` data.
2. **Enrollment check** — `FlexReview::buildPaneForm()` calls
   `PayerAuthenticationApi::checkPayerAuthEnrollment`. `AUTHENTICATION_SUCCESSFUL` (frictionless)
   marks the pane passable (and may skip the review step); `PENDING_AUTHENTICATION` renders the
   step-up iframe via the `commerce_cybersource_stepup_iframe` theme (access token + step-up URL) and
   can auto-submit; `AUTHENTICATION_FAILED`/non-201 redirects back with a generic error.
3. **Step-up result** — the iframe's returnUrl is `commerce_payment.notify?order_id=…`, handled by
   `Flex::onNotify(Request $request)`. It loads the order **for update** (lock), asserts a
   `flex_credit_card` payment method with a transient token, requires a `TransactionId` in the POST,
   then **independently confirms the result server-side** via
   `PayerAuthenticationApi::validateAuthenticationResults` — it does not trust the posted status. It
   stores `authentication_successful` = (`getStatus() === 'AUTHENTICATION_SUCCESSFUL'`) on the order
   and returns an HTML page that `postMessage`s `cybersource_pa_return` to the parent window (origin =
   the site's own scheme+host).
4. **Gate** — `FlexReview::validatePaneForm()` blocks the review step unless
   `cybersource_payer_auth_successful` (frictionless) or the stored `authentication_successful` flag
   is set, otherwise it redirects to the previous step with an error.
5. **Payment** — `Flex::createPayment()` attaches the order's stored
   `cybersource_payer_auth` (`transactionId`/`referenceId`) to the CyberSource payment request as
   `consumerAuthenticationInformation`.

Unified Checkout drives 3DS inside its hosted widget (`completeMandate.consumerAuthentication` set
from `enable_payer_authentication` in `generateCaptureContext()`), so it needs no separate review
pane.

## Transient token trust (Flex `createPaymentMethod`)

Before storing any card metadata, the Flex transient token JWT is verified:
`JWTUtility::parse()` reads the `kid`, `PublicKeyApiController::fetchPublicKey($kid, $runEnvironment)`
retrieves the RSA public key, and `JWTUtility::verifyJwt()` checks the signature. Any parse/verify
failure logs and throws `InvalidRequestException` — an unverifiable token is rejected, so a tampered
payload cannot store a misleading card identity. Only after verification is the payload decoded
(base64url-aware) and the masked card number / expiry read.
