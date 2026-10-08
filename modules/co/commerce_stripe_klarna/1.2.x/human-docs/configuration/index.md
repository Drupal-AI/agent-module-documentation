# Configuration

You configure this module by setting up the Stripe Klarna payment gateway with your Stripe
credentials.

## Edit (or add) the payment gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
2. The module ships a default **Commerce Klarna Stripe** gateway — click to edit it. (If it
   is not present, click **Add payment gateway** and choose the Stripe Klarna plugin.)
3. Enter your Stripe **secret key** and **publishable key**.
4. Choose the **mode** — **Test** while setting up, **Live** for real payments — with the
   matching keys. The module validates the key/mode against the Stripe Balance API.
5. Save the gateway.

## Confirm supported countries and currencies

Klarna through Stripe only works for specific markets, so check these before going live:

- For a **US** implementation, the Stripe account must be in the US and the currency must be
  **USD**.
- Otherwise the supported countries include AT, BE, DE, DK, ES, FI, GB, IE, IT, NL, NO, SE,
  FR, EE, GR, LV, LT, SK, SI, and the supported currencies are **EUR, GBP, DKK, SEK, or
  NOK**.
- **Billing-address countries** must be within the supported list above, or Klarna will not
  be offered.

## Handle the Stripe secret key securely

The Stripe **secret key** is a credential that must never end up in a public repository or a
committed configuration export. Keep the value in an environment variable. With DDEV:

```bash
ddev dotenv set .ddev/.env --stripe-secret-key=<sk_...>
ddev restart
```

Keep `.ddev/.env` out of version control. Where the field supports it, reference the value
through a [Key](https://www.drupal.org/project/key) entity rather than pasting the raw secret
into the form. The publishable key is not secret. Note too that the shipped default gateway
config should not carry a real key into version control — set the key on the running site,
not in committed config.

## How payment is confirmed (why it is safe)

When the shopper returns from Stripe's Klarna flow, the module retrieves the PaymentIntent
directly from Stripe's API, matches it to the stored payment, and completes the Commerce
payment only when Stripe reports the intent **succeeded**. Failed or cancelled payments are
voided, and an already-paid order is not marked paid again. Request data is never trusted to
decide payment state.

## Test before going live

In **Test** mode with your Stripe test keys, place a test order in a supported
country/currency and complete the Klarna flow to confirm the order is marked paid only after
Stripe confirms it. Then switch to **Live** mode with your live keys.
