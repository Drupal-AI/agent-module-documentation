<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Vipps MobilePay Commerce integrates Vipps MobilePay Merchant with Commerce.

---

Vipps MobilePay Commerce integrates **Vipps MobilePay as a Drupal Commerce payment gateway** — accepting
Vipps/MobilePay payments at checkout, using the base Vipps MobilePay module's SDK and Commerce Payment. It
depends on Vipps MobilePay and Commerce Payment, provides its own permissions, in the Commerce (contrib)
package.

Use it to accept Vipps MobilePay payments. It is an e-commerce/payment feature: it registers a **webhook with
Vipps** (via the SDK, from an admin form) and receives payment notifications through Commerce's standard
`commerce_payment.notify` flow, where the gateway confirms payment state with Vipps. As always for payments,
ensure the notification/return path **confirms status server-side with Vipps** (the SDK handles webhook auth),
store the **merchant credentials** as secrets over HTTPS, and verify the flow for your (beta) version. It has no
access-control role beyond its permission. Configure the Vipps gateway.

---

- Accept Vipps MobilePay payments.
- Register a Vipps webhook (via SDK).
- Use Commerce's notify flow.
- Depend on Vipps MobilePay and Commerce Payment.
- Provide its own permissions.
- Confirm payment with Vipps.
- Confirm status server-side with Vipps.
- Let the SDK handle webhook auth.
- Store merchant credentials as secrets over HTTPS.
- Verify the flow for your (beta) version.
- Have no access-control role beyond permission.
- Configure the Vipps gateway.
- Handle Vipps payments.
- Verify payments.
- Configure the gateway.
- Process payments.
- Handle the integration.
- Take payments.
- Secure the credentials.
- Provide Vipps payment.
