<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CM.com Payment integrates the CM.com payment provider with Drupal Commerce (server-verified).

---

CM.com Payment is a payment module for the CM.com payment provider — a Drupal Commerce off-site payment gateway that redirects the shopper to CM.com to pay and reconciles the order afterwards.

At checkout the module creates a shopper and an order at CM.com and redirects the browser to CM.com's hosted payment menu (credit card, iDEAL, PayPal and so on — the choice is handled by CM.com's API). On the return/notify path the gateway **re-fetches the order status server-side from CM.com's API** (`GET merchants/{merchant_key}/orders/{order_key}`, HTTP Basic auth) and only completes the payment when CM's own API reports the order is `SAFE` — it does not trust a client-supplied status. The gateway credentials (merchant name, password, merchant key) are entered on the Commerce payment-gateway settings form. Depends on `commerce_payment`; supports Drupal 10.3 and 11.

---

- Integrate the CM.com payment provider with Drupal Commerce.
- Provide an off-site Commerce payment gateway plugin (`cm`).
- Redirect the shopper to CM.com's hosted payment menu at checkout.
- Create a shopper record at CM.com from the order billing profile.
- Create the order at CM.com and obtain its hosted payment URL.
- Reconcile the order after the shopper returns from CM.com.
- Re-fetch order status server-side from CM.com's API.
- Complete the payment only when CM.com reports the order is SAFE.
- Not trust a client-supplied payment status.
- Handle the asynchronous CM.com notify callback.
- Handle return and cancel steps of Commerce checkout.
- Support credit-card payment method type (Mastercard, Visa).
- Switch between CM.com test and live API endpoints via gateway mode.
- Optionally record CM order/payment ids on the order (if those fields exist).
- Optionally log request/response detail for debugging (off by default).
- Depend on Drupal Commerce's `commerce_payment`.
- Support Drupal 10.3 and 11.
- Configure entirely through Commerce's Payment gateways UI.
- Store gateway credentials in the payment-gateway configuration.
- Avoid building the CM.com API integration by hand.
