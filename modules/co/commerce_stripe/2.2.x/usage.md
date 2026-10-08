<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Stripe integrates Stripe payments into Drupal Commerce, providing Stripe payment-gateway plugins (the modern Payment Element and the legacy Card Element), Strong Customer Authentication (SCA/3D Secure), express checkout (Apple Pay / Google Pay), and Stripe Connect.

---

The module ships two Commerce payment-gateway plugins: **`stripe_payment_element`** ("Stripe Payment Element", an off-site/redirect-style gateway built on Stripe's PaymentIntents + Payment Element — the recommended choice), and the legacy on-site **`stripe`** ("Stripe Card Element"). You create a gateway at *Commerce → Configuration → Payment gateways*, choosing the plugin, a **mode** (`test`/`live`), and your Stripe **publishable_key** and **secret_key** (or connect via Stripe Connect OAuth). The Payment Element gateway also stores a `webhook_signing_secret`, capture method, express-checkout settings, and styling in its plugin configuration (config entity `commerce_payment_gateway.<id>`, schema `commerce_payment.commerce_payment_gateway.plugin.stripe_payment_element`). It defines a family of Stripe payment-method-type plugins — `stripe_card`, plus `stripe_affirm`, `stripe_klarna`, `stripe_paypal`, `stripe_cashapp`, `stripe_us_bank_account` (ACH), `stripe_alipay`, `stripe_wechat_pay`, `stripe_link`, `stripe_amazon_pay` — so many local payment methods can be offered through one gateway. A small `commerce_stripe.settings` config object controls global behaviour: `load_on_every_page`, `collect_user_fraud_signals` (Stripe fraud signals), and `link_payments_remote_id` (deep-links payments to the Stripe dashboard). Order/PaymentIntent lifecycle is handled by event subscribers, and three events — `commerce_stripe.payment_intent.create`, `commerce_stripe.payment_intent.update`, and `commerce_stripe.express_checkout_shipping_profile_alter` — let you alter intent attributes/metadata and express-checkout shipping. The included Express Checkout element renders Apple Pay / Google Pay / Link buttons with their own JSON controller routes. Two permissions gate configuration and dashboard links. The bundled **commerce_stripe_webhook_event** submodule logs and processes incoming Stripe webhooks. All Stripe API calls use the `stripe/stripe-php` library.

---

- Accept credit-card payments through Stripe using the modern Payment Element.
- Configure a Stripe gateway in test mode with test publishable/secret keys for development.
- Switch a gateway to live mode with production Stripe keys for go-live.
- Support SCA / 3D Secure authentication automatically via Stripe PaymentIntents.
- Offer Apple Pay and Google Pay through Stripe Express Checkout buttons.
- Show express-checkout buttons on the shopping-cart page (`express_checkout.enable_on_cart`).
- Accept Klarna, Affirm, Cash App, Alipay, WeChat Pay, Amazon Pay, or Link via Stripe.
- Accept ACH direct-debit bank payments with the `stripe_us_bank_account` method type.
- Store card payment methods on file (setup future usage) for repeat customers.
- Capture payments manually (authorize now, capture later) via the capture method setting.
- Refund and partially refund Stripe payments from the Commerce admin.
- Connect a Stripe account with Stripe Connect OAuth instead of pasting API keys.
- Verify incoming webhooks with a `webhook_signing_secret` on the gateway.
- Log and inspect Stripe webhook events with the commerce_stripe_webhook_event submodule.
- Deep-link each payment's remote ID to the Stripe dashboard (`link_payments_remote_id`).
- Enable Stripe's advanced fraud detection signals (`collect_user_fraud_signals`).
- Load the Stripe.js script on every page for fraud/session continuity (`load_on_every_page`).
- Add or modify PaymentIntent metadata before creation via the `payment_intent.create` event.
- Update PaymentIntent metadata mid-checkout via the `payment_intent.update` event.
- Alter the shipping profile built during express checkout via the express-checkout event.
- Customise the Payment Element theme/layout and the checkout form display label.
- Collect a phone number or billing address in express checkout.
- Restrict configuration access with the `administer commerce stripe` permission.
- Let support staff open Stripe dashboard links with `view stripe dashboard links`.
- Offer multiple Stripe local payment methods through a single Payment Element gateway.
