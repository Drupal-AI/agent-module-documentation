<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Stripe Pay — routes & integration

## Configuration
`/admin/stripe-configurations` (`StripeConfig`, perm `administer site configuration`): `secret_key_test`, `secret_key_live`, publishable keys, `currency_code`, `test_mode`. Keys are stored in the `stripe_pay.settings` config object.

## Routes (all payment routes are `_access: 'TRUE'` — public)
- `POST /stripe-payment-init` → `StripeController::paymentInit()`. Reads JSON body: `amount`, `title`, `url`, `id`, `quantity`. Creates a Stripe Checkout Session (`\$stripe->checkout->sessions->create`) with `unit_amount = amount * 100`, returns `{status, sessionId}` JSON. The JS then redirects to Stripe with the publishable key.
- `GET /stripe-pay/success` → `paymentSuccess()`. Reads `session_id` and `redirect` from the query, shows a success message, redirects to `redirect`.
- `GET /stripe-pay/cancel` → `paymentCancel()`. Redirects to `redirect` with a cancellation message.

## Extension hooks
`hook_stripe_pay_success_redirect(&$url)`, `hook_stripe_pay_success_message(&$msg)`, `hook_stripe_pay_cancel_redirect(&$url)`, `hook_stripe_pay_cancel_message(&$msg)`.

## Security caveats (RECORDED Danger 3)
This flow is **not safe as shipped**:
- **Price manipulation:** the charged `amount` comes straight from the client POST body (`StripeController.php:78`), only clamped to a minimum of 1.
- **Unverified success:** `paymentSuccess()` (`:204`) does not retrieve/verify the Checkout Session or validate any webhook signature — it trusts the browser's return and the `session_id`/`redirect` query values. Any GET to `/stripe-pay/success?session_id=x` shows "payment success".
- **Reflected redirect:** the `redirect` query value is echoed into `success_url`/`cancel_url` (`:158-159`) and used as the post-payment redirect target (`:225`, `:263`).

Do not rely on this module for authoritative order fulfilment; verify payments server-side against Stripe (webhook signature + session retrieval) before granting anything of value.
