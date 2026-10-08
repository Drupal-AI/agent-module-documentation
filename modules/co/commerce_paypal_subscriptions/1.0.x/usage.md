<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Paypal Subscriptions turns a Drupal Commerce order into a recurring PayPal subscription
using PayPal's modern REST Subscriptions API.

---

Commerce Paypal Subscriptions adds an off-site Drupal Commerce payment gateway
(`paypal_checkout_subscriptions`, "PayPal Checkout Subscriptions") that lets a customer approve a
recurring subscription with PayPal's Smart Payment Buttons at checkout — PayPal then manages the
subscription lifecycle. It extends the `commerce_paypal` module (its Checkout gateway, REST SDK,
controller and off-site form), so it depends on Drupal Commerce and commerce_paypal, in the
Commerce package.

Use it for PayPal-based recurring billing. PayPal products and plans can be generated dynamically
(the plan price is derived from the Commerce order total), or you can point the gateway at a
pre-created default subscription plan. At approval the module re-fetches the subscription from
PayPal's merchant-authenticated API server-side and binds its plan id to the order before recording
a completed Commerce payment, using the server-side order total as the amount. Store the PayPal
**client id / client secret as secrets**, operate over HTTPS, restrict who may administer payment
gateways, and confirm whether the gateway points at **sandbox** or **live** before go-live. It is an
e-commerce / subscriptions feature configured as a Commerce payment gateway.

---

- Enable PayPal recurring payments (subscriptions).
- Add the `paypal_checkout_subscriptions` Commerce payment gateway.
- Approve subscriptions via PayPal Smart Payment Buttons at checkout.
- Generate PayPal products and plans dynamically from the order total.
- Or reference a pre-created default subscription plan.
- Bind the subscription plan id to the order at approval.
- Re-fetch the subscription from PayPal's authenticated API server-side.
- Record a completed Commerce payment using the server-side order total.
- Depend on Drupal Commerce and commerce_paypal.
- Store PayPal client id / secret as secrets.
- Operate over HTTPS.
- Restrict who may administer payment gateways.
- Confirm sandbox vs live.
- Set the billing frequency (day / week / month / year).
- Extend plan selection via the SUBSCRIPTION_CREATE event.
- Configure the gateway under Commerce payment gateways.
- Have no permissions of its own beyond the gateway plugin.
- Handle PayPal credentials securely.
- Integrate PayPal subscriptions.
- Process recurring billing.
