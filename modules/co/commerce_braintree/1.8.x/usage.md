Commerce Braintree integrates Braintree Payments with Drupal Commerce, providing an on-site "Hosted Fields" payment gateway for credit cards, PayPal, and PayPal Credit, with optional 3D Secure 2 authentication.

---

The module defines one Commerce payment gateway plugin, `braintree_hostedfields` (`HostedFields extends OnsitePaymentGatewayBase`), that talks to Braintree via the official `braintree/braintree_php` SDK (v6). Card data never touches Drupal: the browser tokenizes it with Braintree's JS (Hosted Fields / PayPal / 3-D Secure libraries, loaded from `js.braintreegateway.com` with SRI hashes) into a payment-method nonce, and the server exchanges that nonce for transactions and vaulted payment methods. The gateway implements the standard Commerce onsite operations — `createPayment` (transaction sale, with optional auth-only via `submitForSettlement`), `capturePayment`, `voidPayment`, `refundPayment` (falling back to void for unsettled transactions), plus `createPaymentMethod`/`deletePaymentMethod` (creating a Braintree customer + vaulted payment method with `verifyCard`). It supports multiple currencies by mapping each Commerce currency to a Braintree **merchant account ID**. 3-D Secure is added by the `braintree_3ds_review` checkout pane (placed on the checkout `review` step), which performs client-side authentication before the final submit for vaulted cards. Payment method types include `credit_card`, `paypal`, and a dedicated `paypal_credit` type. A `TransactionDataEvent` (`commerce_braintree.transaction_data`) lets other modules add data/metadata to the sale request. Configuration (merchant id, public/private keys, per-currency merchant account IDs, 3DS mode, card-icons toggle) lives on the payment gateway config entity — there is no module settings page. This 1.8.x release is the legacy `8.x-1.x` branch; it has **no webhook/IPN endpoint** (no notify route), so there is no server-to-server callback to secure.

---

- Accept credit card payments on-site with Braintree Hosted Fields (PCI-friendly, card data tokenized in-browser).
- Add Braintree as a Commerce payment gateway without redirecting customers off-site for cards.
- Offer PayPal as a checkout payment method through Braintree.
- Offer PayPal Credit as its own distinct checkout option.
- Enable 3-D Secure 2 (SCA) authentication, either optional ("enabled") or "required".
- Vault (store) a customer's card or PayPal account for reuse on future orders and subscriptions.
- Authorize now and capture later (`submitForSettlement = false`), then capture from the order UI.
- Void an authorization before settlement.
- Refund a captured payment fully or partially (auto-voiding if not yet settled).
- Support multiple store currencies by mapping each to a Braintree merchant account ID.
- Charge recurring/subscription payments using stored Braintree payment methods (with Commerce Recurring).
- Display credit card brand icons during checkout (toggle).
- Add custom transaction metadata (order channel, custom fields) via the `commerce_braintree.transaction_data` event.
- Test against a Braintree sandbox by setting the gateway mode to "Test" before going live.
- Map Braintree card types to Commerce card types (Visa, Mastercard, Amex, Discover, etc.).
- Create a Braintree customer record automatically for authenticated buyers who save a payment method.
- Send shipping and billing address data to Braintree with the transaction for risk/AVS.
- Run 3DS authentication as the last checkout step via the Braintree 3DS review pane.
- Integrate a Commerce store with an existing Braintree merchant account and API keys.
