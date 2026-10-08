AlternativeCommerce PayPal Checkout adds PayPal as a payment method for the Basket (AlternativeCommerce) store, using PayPal's server-side Orders API together with the client-side JS SDK Smart Buttons.

---

The module registers two Basket payment plugins — `basket_paypal` (redirect/approve flow rendered by a Drupal `PaymentForm`) and `basket_paypal_js` (in-page JS SDK Smart Buttons) — both backed by PayPal's official `paypal/paypal-server-sdk` PHP client. Orders are created server-side from the cart total and currency (`PayPalJs::createOrder()` / `PaymentForm::basketPaymentFormAlter()`), buyers approve them on PayPal, and payment records are tracked in a dedicated `payments_basket_paypal` table. A JSON-API controller (`/paypal-api/{page_type}`) drives the JS SDK create/capture calls, a pages controller (`/basket_paypal/{page_type}`) renders result/cancel screens and receives PayPal webhooks, and two admin settings forms hold live/sandbox client credentials and Smart-Button styling. Currency is auto-mapped to PayPal's supported set (falling back to USD). Requires the contrib `basket` module and a PayPal REST app client ID/secret.

---

- Accept PayPal payments in a Basket (AlternativeCommerce) storefront.
- Offer in-page PayPal Smart Buttons (JS SDK) on the order form without a full redirect.
- Offer a classic "Pay" button that redirects the buyer to PayPal's approve page.
- Create PayPal orders server-side with the exact cart amount and currency (no client-set price).
- Toggle PayPal Sandbox vs. Production from a single settings checkbox.
- Store separate live and sandbox REST app client ID / client secret pairs.
- Customize Smart-Button layout (vertical/horizontal), color (gold/blue/silver/white/black) and shape (rect/pill/sharp).
- Preview the configured Smart Button live in the admin JS SDK settings form.
- Optionally run the Basket order form's validation before creating a PayPal order (JS SDK "Enable form validation").
- Pass buyer name, surname, email and phone into PayPal's payment source when form validation is enabled.
- Auto-convert the cart total into a PayPal-supported currency (falls back to USD for unsupported ISO codes).
- Configure a localized "Payment was successful" message per site language (text format aware).
- Change a Basket order's finished status automatically after a successful PayPal payment (per payment point).
- Receive PayPal webhooks (`CHECKOUT.ORDER.APPROVED`, `PAYMENT.CAPTURE.COMPLETED`, `CHECKOUT.ORDER.COMPLETED`) at a dedicated endpoint.
- Capture an approved order server-side via `ordersCapture()` from the webhook handler.
- Reconcile a completed capture by re-fetching the order status from PayPal (`ordersGet()`) before marking a payment complete.
- Track each payment attempt (amount, currency, status, PayPal response JSON, pay time) in the `payments_basket_paypal` table.
- Extend or alter the outbound PayPal order request via the `hook_basket_paypal_order_params_alter()` / `hook_basket_paypal_payment_params_alter()` hooks.
- Localize the checkout UI (ships Ukrainian and Russian translations).
- Restrict access to the gateway configuration pages with the `access basket_paypal settings` permission.
- Attach the PayPal JS SDK `<script>` site-wide (with the configured client ID and currency) when the JS SDK is enabled.
