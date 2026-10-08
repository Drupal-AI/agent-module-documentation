<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Payment flow and server-side verification

Files: `src/PluginForm/OffsiteRedirect/PaymentOffsiteForm.php`, `src/Plugin/Commerce/PaymentGateway/Rave.php`, `js/commerce_rave.form.js`.

## 1. Build (off-site form)
`PaymentOffsiteForm::buildConfigurationForm` builds the Rave payload from the order/payment:
- `PBFPubKey` (public key), `amount` (`payment->getAmount()->getNumber() + 0` to drop trailing zeros), `currency`, `country` and `customer_email`/`customer_firstname`/`customer_lastname` from the order and its billing profile.
- `txref = {txref_prefix}-{orderId}`, `redirect_url = $form['#return_url']`, `custom_title`/`custom_description`/`custom_logo` from site config, `pay_button_text`.
- If `payment_flow == hosted_payment_page`, adds `hosted_payment => 1`.

It then computes the Rave **integrity hash** (`calculateChecksum`): `ksort` the payload, concatenate all values, append the **secret key**, `hash('sha256', ...)`. The payload plus `integrity_hash` is passed to the browser via `drupalSettings.rave.transactionData`, and the mode-specific `flwpbf-inline.js` library is attached.

`js/commerce_rave.form.js` auto-submits the `.payment-redirect-form` and calls Rave's `getpaidSetup()` to open the iframe (or the hosted page).

## 2. Return + verify
`Rave::onReturn(OrderInterface $order, Request $request)`:
1. Reads and JSON-decodes the `resp` query parameter Rave appends to the return URL; extracts `flwRef` (Rave's transaction reference) and `txRef` (the merchant reference).
2. Calls `verifyTransaction($flwRef)`.
3. `verifyTransaction()` POSTs `{flw_ref, SECKEY, normalize:1}` to `{baseUrl}/flwv3-pug/getpaidx/api/verify` with a fresh Guzzle client (authenticated with the merchant secret key). It treats the transaction as verified only when `response.status === "success"` **and** `response.data.status === "successful"`; `failed`/error responses return `status => FALSE`, and an inconclusive status triggers a bounded requery loop (up to 5 attempts, 3s apart).
4. On a verified result, `onReturn` compares the verified `charged_amount` against `$order->getTotalPrice()->getNumber()`; on a match it creates a `commerce_payment`:
   - `state => 'authorization'`, `amount => $order->getTotalPrice()`, `remote_id => flw_ref`, `remote_state => status`.
   - On amount mismatch it throws `PaymentGatewayException('Charged amount not equal to order amount.')`; a non-successful verify throws `Payment was not successful.`; a missing reference throws `Cannot find Transaction Reference in request.`

## Key point
Fulfilment is decided by the **authenticated server-side verify call**, not by any status value in the browser redirect, and the verified amount is checked against the order total before a payment is recorded. There is no inbound webhook — verification is pull-based, so there is no unauthenticated callback to secure. The created payment is in the `authorization` state; the store's payment/order workflow governs capture and completion.
