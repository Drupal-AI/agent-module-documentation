<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Valitor provides a Drupal Commerce payment gateway for the Valitor payment platform, including tokenised cards and 3-D Secure verification.

---

The `Valitor` gateway plugin talks to `ValitorPayApi` to create virtual (tokenised) cards and take payments; a `ValitorMock` plugin is included for testing. Card verification uses a 3-D Secure flow driven by the `ValitorPay` controller: `createVirtualCardWithVerification` opens the issuer's 3DS window, `redirect3ds` renders the intermediate redirect page, and `webhook` receives the 3DS result and renders the verification outcome (it inspects `mdStatus` and only surfaces status/error markup — it does not itself move money). Captures use the order-derived `$payment->getAmount()`, so the settlement amount is not taken from client input.

The three controller routes (`/valitor/{commerce_payment_gateway}/verify`, `/valitor/3ds`, `/valitor/webhook`) are declared `_access: 'TRUE'` because they are hit by the customer's browser and the 3DS processor during checkout; the webhook path renders the card-verification result rather than performing an authenticated state change. Configure the gateway (API key/credentials, mode) on the standard Commerce payment-gateway form (`configure: commerce_payment.configuration`); add/edit/refund plugin forms are provided for stored payment methods.

---

- Add a Valitor payment gateway under Commerce payment gateways.
- Enter Valitor API credentials and select test/live mode.
- Let customers pay by card during Commerce checkout.
- Tokenise a card into a reusable virtual card / payment method.
- Run 3-D Secure verification in a popup window before charging.
- Render the 3DS redirect page during verification.
- Receive the 3DS result on the `/valitor/webhook` endpoint.
- Show a success or "problem validating your card" message after 3DS.
- Capture an authorised payment for the order amount.
- Refund a captured payment via the refund plugin form.
- Store and reuse customer payment methods (add/edit forms).
- Use the ValitorMock gateway for automated tests.
- Log 3DS errors (mdErrorMsg / iReqCode) to the commerce_valitor channel.
- Attach 3DS parameters (cavv, eci, xid, dsTransId) to the verification form.
- Open/close the verification window via custom AJAX commands.
- Support multiple currencies through Commerce.
- Theme the 3DS pages with the bundled templates.
- Integrate card verification into a custom checkout pane.
- Handle OPTIONS health-check requests on the webhook.
