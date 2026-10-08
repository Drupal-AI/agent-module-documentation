<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Payson Checkout implements the Payson Checkout 2.0 API for Commerce.

---

Payson Checkout implements the **Payson Checkout 2.0 API** as a Drupal Commerce payment gateway — accepting
payments through Payson's hosted checkout (popular in the Nordics). It depends on Commerce Payment and Commerce
Tax, in the Commerce (contrib) package.

Use it to accept Payson payments. It is an e-commerce/payment feature: it communicates with the **Payson API
server-to-server** (creating/reading the checkout and checking the API response status codes) to determine
payment state, rather than trusting a client value — the authoritative status comes from Payson's API. Store the
Payson **agent/API credentials** as secrets over HTTPS, and (as always) verify the return/confirmation flow for
your version. It has no access-control role. Configure the Payson credentials.

---

- Accept Payson payments.
- Use Payson Checkout 2.0.
- Communicate with the Payson API server-to-server.
- Depend on Commerce Payment/Tax.
- Determine state from the API status.
- Not trust a client value.
- Store the Payson credentials as secrets.
- Use HTTPS.
- Verify the confirmation flow per version.
- Have no access-control role.
- Configure the Payson credentials.
- Handle Payson payments.
- Verify payments.
- Configure the gateway.
- Process payments.
- Read API status.
- Handle the integration.
- Take payments.
- Secure the credentials.
- Provide Payson payment.
