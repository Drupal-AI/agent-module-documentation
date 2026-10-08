<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Viva Wallet provides Commerce integration for Viva Wallet.

---

Commerce Viva Wallet provides a **Viva Wallet payment gateway for Drupal Commerce** — accepting card
payments through the Viva Wallet (Viva.com) smart-checkout platform. It depends on Commerce and Commerce
Payment, in the Commerce (contrib) package.

Use it to accept Viva Wallet payments. It is an e-commerce/payment feature and its webhook handling follows the
**authoritative pattern**: the webhook carries only a **transaction id**, and the controller **re-fetches the
transaction from Viva's API** (`$transaction_service->get($transaction_id)`) with the gateway credentials, then
sets the payment state based on that authoritative transaction — so a forged webhook can't mark an order paid
(the fetched transaction won't be genuine/completed). It also exposes a Viva **webhook-verification (`verify_hook`)**
GET endpoint (returns Viva's verification key — standard setup). Store the Viva **client credentials** as secrets
over HTTPS. It has no access-control role. Configure the Viva Wallet credentials.

---

- Accept Viva Wallet payments.
- Use the smart-checkout flow.
- Serve card payments.
- Depend on Commerce and Commerce Payment.
- RE-FETCH the transaction from Viva's API.
- Set state from the authoritative transaction.
- Not trust the webhook payload for status.
- Expose the verify_hook verification endpoint (standard).
- Store the Viva credentials as secrets over HTTPS.
- Prevent forged-webhook fulfillment.
- Have no access-control role.
- Configure the Viva credentials.
- Handle Viva payments.
- Verify payments.
- Configure the gateway.
- Process payments.
- Handle the integration.
- Take payments.
- Secure the credentials.
- Provide Viva Wallet payment.
