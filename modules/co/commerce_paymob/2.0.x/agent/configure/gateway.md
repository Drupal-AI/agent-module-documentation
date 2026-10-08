<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the Paymob gateway

1. Enable the module (requires Commerce + Commerce Payment).
2. Go to **Commerce → Configuration → Payment gateways → Add payment gateway**.
3. Choose a plugin:
   - **Paymob Redirect** (`paymob_redirect`) — offsite; customer pays on Paymob and is redirected back.
   - **Paymob Pixel** (`paymob_pixel`) — onsite tokenized payment; supports reusable stored cards.
4. Fill in the settings:
   - **Server** — region base URL: Egypt/Oman/Saudi Arabia/UAE (all HTTPS).
   - **Public Key**, **Secret Key** (used as `Token` bearer for API calls), **Api Key**.
   - **Payment Integration** — comma-separated Paymob integration IDs.
   - **HMAC** — Paymob HMAC secret used to verify callbacks. Required.
   - **Customer profile telephone field** — profile field supplying the phone number.
   - **Allow reusing payment method** — enables stored card tokens (Pixel).

## Payment flow & verification
- `createIntention()` posts the order total (minor units), billing data, `special_reference` and a `notification_url` to `v1/intention/`.
- `onReturn()` verifies the return query with `Paymob::verifyHmac()` and applies `authorize`/`authorize_capture` transitions; failure throws `PaymentGatewayException`.
- `onNotify()` handles the server webhook: for `TRANSACTION` events it verifies the HMAC before fulfilling; for `TOKEN` events it briefly caches the token payload (keyvalue, 3600s) to build a stored payment method.
- `paymob_pixel::createPayment()` re-checks that the charged amount equals the expected amount before completing.
- `refundPayment()` calls `api/acceptance/void_refund/refund` and sets partial/full refunded state.

## Notes
- Secret/api/HMAC keys are stored as plain gateway configuration — protect config export/access accordingly.
- Only card **tokens** (and last-4 / card subtype) are stored, never full PANs.
