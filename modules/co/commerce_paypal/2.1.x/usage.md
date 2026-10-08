<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce PayPal adds PayPal payment gateways to Drupal Commerce, letting a store accept PayPal, credit-card, and pay-later payments through several PayPal products (PayPal Checkout / Smart Payment Buttons, Fastlane, the legacy Express Checkout, and Payflow / Payflow Link).

---

The module ships a set of `commerce_payment_gateway` plugins — `paypal_checkout`, `paypal_fastlane`, `paypal_express_checkout`, `paypal_payflow`, and `paypal_payflow_link` — that plug into Commerce Payment's gateway framework. Each is configured as a Payment gateway config entity (`commerce_payment.commerce_payment_gateway.*`) with a `mode` of `test` (Sandbox) or `live`, plus product-specific credentials: REST client ID / secret for Checkout and Fastlane, API username / password / signature for Express Checkout, and partner / vendor / user / password for Payflow. The preferred, actively developed gateway is `paypal_checkout`, which renders PayPal's Smart Payment Buttons (and optional custom card fields), supports authorize or capture intent, webhooks for asynchronous updates, and refunds/captures/voids from the order admin. Fastlane accelerates guest checkout with a branded card form, while Express Checkout and both Payflow gateways remain for legacy stores. The module also provides dedicated checkout flows and panes, a PayPal Credit messaging block/Views area, and an SDK layer (`CheckoutSdk`, `FastlaneSdk`) that wraps PayPal's REST APIs. Live transactions require real PayPal credentials and outbound network access; without them the gateways can still be configured and inspected as config entities but cannot process a payment.

---

- Accept PayPal payments on a Drupal Commerce store using the modern PayPal Checkout (Smart Payment Buttons) gateway.
- Offer a "Pay with PayPal" button on the cart page as well as at checkout.
- Take credit-card payments through PayPal's hosted custom card fields without handling raw card data on your server.
- Speed up guest checkout with Fastlane by PayPal's branded card entry form.
- Run a store in PayPal Sandbox mode first (`mode: test`) with sandbox REST credentials, then flip to `live` for production.
- Authorize payments at checkout and capture them later from the order admin (intent `authorize` vs `capture`).
- Capture, refund, or void PayPal payments directly from a Commerce order's Payments tab.
- Configure separate gateways for different stores or currencies, each with its own PayPal credentials.
- Receive asynchronous payment updates via PayPal webhooks (configure a webhook ID and enable request logging).
- Show PayPal Credit / Pay Later messaging to shoppers using the credit messaging block or Views area.
- Restrict which funding sources (Venmo, Pay Later, card, etc.) or card brands appear on the buttons.
- Customize the Smart Payment Buttons' layout, color, shape, and label to match the storefront.
- Collect or skip billing information at checkout depending on the gateway's `collect_billing_information` setting.
- Keep a legacy Express Checkout integration running for stores that still rely on the classic NVP/SOAP API.
- Integrate a Payflow or Payflow Link merchant account for stores using PayPal's Payflow gateway.
- Use the Payflow Link iframe (embedded hosted checkout) so shoppers pay without leaving the site.
- Log Payflow API request/response messages for debugging failed transactions.
- Enable reference transactions on Payflow Link for subsequent (recurring-style) charges.
- Drive the PayPal REST API programmatically through the module's `CheckoutSdk` / `FastlaneSdk` service factories.
- Subscribe to checkout order request events to alter the order data sent to PayPal before a payment is created.
- Display credit-card brand icons next to the PayPal payment option at checkout.
- Choose a shipping-preference strategy (get address from PayPal vs. use the order's address) for Checkout.
- Update the customer's billing/shipping profile in Commerce from the address PayPal returns.
- Provide multiple payment options (PayPal button + card fields) from a single Checkout gateway configuration.
- Test gateway configuration and introspect stored credentials/mode via Drush without contacting PayPal.
