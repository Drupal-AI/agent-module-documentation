# Configuration

You configure this module by adding a Stripe Alipay payment gateway and entering your Stripe
credentials.

## Add the payment gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
2. Click **Add payment gateway** and choose **Stripe Alipay**.
3. Enter your Stripe **secret key** and **publishable key**.
4. Choose the **mode** — **Test** while you are setting up, **Live** for real payments. Use
   your test keys in test mode and your live keys in live mode.
5. Save the gateway. The module validates the key/mode combination against the Stripe
   Balance API, so a mismatched key or wrong live/test setting is caught early.

## Handle the Stripe secret key securely

The Stripe **secret key** is a credential that must never end up in a public repository or a
committed configuration export. The recommended pattern is to keep the value in an
environment variable. With DDEV:

```bash
ddev dotenv set .ddev/.env --stripe-secret-key=<sk_...>
ddev restart
```

Keep `.ddev/.env` out of version control. Where the field supports referencing a value
indirectly, use a [Key](https://www.drupal.org/project/key) entity backed by that
environment variable rather than pasting the raw secret into the form. The publishable key
is not secret, but the secret key must be protected.

## How payment is confirmed (why it is safe)

When the shopper returns from Stripe's Alipay flow, the module does **not** trust the return
request to decide whether the order is paid. Instead it retrieves the PaymentIntent directly
from Stripe's API, matches it to the stored payment by intent ID and client secret, and
completes the Commerce payment only when Stripe reports the intent **succeeded**. On failure
or cancellation the payment is voided, and the module guards against double-charging an
order that is already paid. This means a shopper (or attacker) cannot forge a "paid" result
by manipulating the redirect back to your site.

## Test before going live

With the gateway in **Test** mode and your Stripe test keys, place a test order and complete
the Alipay flow to confirm the order is marked paid only after Stripe confirms it. When you
are satisfied, switch the gateway to **Live** mode with your live keys.
