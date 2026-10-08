<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Stripe Pay integrates Stripe Checkout: it provides a Stripe payment field (type/widget/formatter) and controller routes that create a Stripe Checkout session and handle success/cancel redirects.

---

The module lets a site take Stripe payments without Drupal Commerce. It defines a `StripePayment` field type with a widget and default formatter (used to render a pay button/config on an entity) and a settings form at `/admin/stripe-configurations` (permission `administer site configuration`) holding the publishable/secret keys for test and live modes and the currency. The front-end posts to `/stripe-payment-init`, which reads a JSON body (`amount`, `title`, `url`, `id`, `quantity`), creates a Stripe Checkout Session via the Stripe PHP SDK, and returns the session id as JSON; `/stripe-pay/success` and `/stripe-pay/cancel` handle the return, display a message, and redirect. Success/cancel behaviour is extensible through `hook_stripe_pay_success_redirect`, `_success_message`, `_cancel_redirect`, `_cancel_message`.

Security (RECORDED finding — Danger 3, not re-investigated here): all three payment routes use `_access: 'TRUE'` (fully public). `StripeController::paymentInit()` takes the charge **amount** directly from the request body (`$payload['amount']`, `StripeController.php:78`, only floored to a minimum of 1) so the client controls the price, and `paymentSuccess()` (`:204`) treats the visitor's return as success — it shows a success message and redirects using the request-supplied `redirect`/`session_id` query values **without verifying the payment with Stripe** (no webhook signature / session retrieval check). This allows price manipulation and success-flow bypass. The `redirect` query value is also reflected into the checkout `success_url`/`cancel_url` and used as a redirect target. Document accordingly; treat the payment flow as untrusted.

---

- Add a Stripe payment field to a content type.
- Configure Stripe publishable/secret keys at /admin/stripe-configurations.
- Toggle between Stripe test and live mode.
- Set the payment currency code.
- Create a Stripe Checkout session from the front end.
- Render a pay button via the field formatter.
- Handle the Stripe success return at /stripe-pay/success.
- Handle payment cancellation at /stripe-pay/cancel.
- Customize the success redirect via hook_stripe_pay_success_redirect.
- Customize the success message via hook_stripe_pay_success_message.
- Customize the cancel redirect via hook_stripe_pay_cancel_redirect.
- Customize the cancel message via hook_stripe_pay_cancel_message.
- Return a Checkout session id as JSON to the browser.
- Accept one-off payments without Drupal Commerce.
- Set product name/quantity for the checkout line item.
- Review the recorded security caveats before production use.
