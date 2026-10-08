<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Easy lets you pay with Nets Easy.

---

Commerce Easy provides a **Drupal Commerce payment gateway for Nets Easy** (Nexi's hosted checkout, common
in the Nordics) — customers pay through the Nets Easy flow. It depends on Commerce Payment, in the Commerce
package.

Use it to accept Nets Easy payments. It is an e-commerce/payment feature. As with any offsite/hosted gateway,
the trust boundary is the **payment confirmation** — ensure the module confirms payment **server-side** with
Nets Easy's API (retrieve the payment/charge status from Nets rather than trusting a client return) before
fulfilling; handle the Nets **API keys** as secrets and use HTTPS. (This is a dev release — review the gateway's
confirmation flow for your version.) It has no access-control role. Configure the Nets Easy credentials.

---

- Accept Nets Easy payments.
- Use the Nets Easy hosted checkout.
- Serve Nordic payments.
- Depend on Commerce Payment.
- Confirm payment server-side with Nets.
- Retrieve status from the Nets API.
- NOT trust a client return to fulfil.
- Store Nets API keys as secrets.
- Use HTTPS.
- Have no access-control role.
- Configure the Nets Easy credentials.
- Handle Nets Easy payments.
- Verify payments.
- Configure the gateway.
- Process payments.
- Confirm via API.
- Handle the integration.
- Take payments.
- Secure the credentials.
- Provide Nets Easy payment.
