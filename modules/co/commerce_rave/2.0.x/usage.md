<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Rave provides Drupal Commerce integration for Flutterwave Rave.

---

Commerce Rave provides a **Drupal Commerce payment gateway for Flutterwave Rave** — accepting card/mobile
payments through Flutterwave's Rave platform (popular in Africa). It depends on Commerce Payment, in the
Commerce package.

Use it to accept Flutterwave Rave payments. It is an e-commerce/payment feature and it follows the correct
pattern: on the return leg it **verifies the transaction server-side** against Rave's API
(`verifyTransaction($reference)`) and completes the payment based on that authoritative result rather than
trusting the client redirect. Store the Rave **public/secret API keys** as secrets over HTTPS. (Note the code
marks a webhook as a `@todo` — it relies on the verified return flow.) It has no access-control role. Configure
the Rave credentials.

---

- Accept Flutterwave Rave payments.
- Take card/mobile payments.
- Use the Rave platform.
- Depend on Commerce Payment.
- VERIFY the transaction server-side (verifyTransaction).
- Complete payment on the authoritative result.
- Not trust the client redirect.
- Store the Rave API keys as secrets.
- Use HTTPS.
- Rely on the verified return flow.
- Have no access-control role.
- Configure the Rave credentials.
- Handle Rave payments.
- Verify payments.
- Configure the gateway.
- Process payments.
- Handle the integration.
- Take payments.
- Secure the keys.
- Provide Rave payment.
