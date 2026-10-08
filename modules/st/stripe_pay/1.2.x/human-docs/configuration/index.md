# Configuration

Setting up Stripe Pay has two parts: entering your Stripe keys on the settings
form, and adding the payment field to the content you want to sell. Please read
the security section at the end before using it in production.

## Enter your Stripe keys

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **`/admin/stripe-configurations`**.
3. Fill in:
   - **Publishable and secret keys** for **test** mode and for **live** mode —
     Stripe issues both sets in your dashboard.
   - **Currency code** — the three-letter currency for your charges (for example
     `usd`).
   - **Test mode** — the toggle that decides whether the test or live keys are
     used. Keep this on while building and switch it off only when you are ready
     for real payments.

These values are stored in the `stripe_pay.settings` configuration object.

## Add the payment field to your content

1. On the content type (or other entity) you want to sell, go to **Manage
   fields** and add a **Stripe Payment** field.
2. On **Manage form display**, place the field's widget so editors can enter the
   price value when creating or editing content.
3. On **Manage display**, configure how the pay button renders — you can set the
   **button text**, the **price format**, and whether a **quantity** field is
   shown.
4. Create or edit an entity of that type and set its price. The field renders as a
   pay button; clicking it creates a Stripe Checkout session and sends the visitor
   to Stripe.

## Customizing the button and the return behavior

You can copy `templates/stripe-payment.html.twig` from the module into your theme
and adjust the markup and CSS; the template receives a `stripe_payment_data`
array with values such as `price`, `currency_sign`, `currency_code`,
`show_quantity`, `title`, `button_text`, and `current_url`.

A developer can also change what happens after checkout with four hooks:
`hook_stripe_pay_success_message()`, `hook_stripe_pay_cancel_message()`,
`hook_stripe_pay_success_redirect()`, and `hook_stripe_pay_cancel_redirect()`.

## Security — read this before going live

This is a **recorded finding**: the payment flow is **not safe as shipped** for
anything where money or access actually matters. Three specific problems:

- **The price is set by the browser.** The charge amount comes straight from the
  client's request when the Checkout session is created (only clamped to a
  minimum of 1), so a visitor can manipulate what they are charged.
- **"Success" is not verified with Stripe.** The success page trusts the
  visitor's return — it shows a success message and redirects based on
  `session_id` and `redirect` values from the query string, **without retrieving
  the Checkout Session from Stripe or validating any webhook signature**. Any
  plain GET to `/stripe-pay/success?session_id=x` will display "payment success".
- **Open-redirect surface.** The `redirect` query value is reflected into the
  checkout success/cancel URLs and used as the post-payment redirect target.

All three payment routes (`/stripe-payment-init`, `/stripe-pay/success`,
`/stripe-pay/cancel`) are publicly accessible by design.

**What to do about it:** do not use this flow as the authoritative record that a
payment happened. If you need to grant a product, membership, or download on
payment, verify the payment **server-side** against Stripe — a signature-verified
webhook plus a Checkout Session retrieval — before granting anything of value,
and validate any redirect target against a safe list. Treat the browser-facing
flow as untrusted.

## Save

Save the settings form to store your keys and currency. Test the full flow in
test mode first, and confirm your server-side verification is in place before
switching off test mode.
