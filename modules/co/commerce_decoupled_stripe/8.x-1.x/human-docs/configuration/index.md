# Configuration

Decoupled Stripe is configured like any Drupal Commerce payment gateway: you add a
gateway, choose the one‑off or recurring Stripe type, and enter your Stripe keys.
The rest of the flow is driven by your front end and the Commerce Decoupled
Checkout endpoints.

## Store your Stripe secret key safely

Your Stripe **secret key** is a credential — and it is exactly what the gateway
uses to verify payments authoritatively against Stripe, so protect it. Keep it in
an environment variable and reference it through a **Key** entity.

With DDEV, set the secret and restart so the container picks it up:

```bash
ddev dotenv set .ddev/.env --stripe-secret-key=sk_test_xxxxxxxx
ddev restart
```

Then enable the **Key** module and create a Key that reads the environment
variable:

```bash
ddev composer require drupal/key
ddev drush en key -y
ddev drush key:save stripe_secret_key --label='Stripe Secret Key' \
  --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"STRIPE_SECRET_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

Never commit `.ddev/.env` to version control.

## Add the payment gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Give it a **Name** and choose the Stripe type:
   - **Decoupled Stripe** — for one‑off payments.
   - **Decoupled Stripe Recurring** — for recurring/monthly payments (uses Stripe
     SetupIntents).
3. Enter your Stripe **publishable key** and **secret key** (reference the Key you
   created above where the form allows it).
4. Choose the **mode** — use Stripe **test** keys while integrating and switch to
   **live** keys only after a successful end‑to‑end test.
5. Enable the gateway and save.

## How the client flow uses it

Once the gateway exists, your headless front end:

1. Creates an order via a Commerce Decoupled Checkout endpoint.
2. Creates a payment — the response carries the Stripe PaymentIntent's
   `clientSecret` in the payment's remote‑ID field.
3. Completes the payment in the browser with the Stripe.js API (for example
   `handleCardPayment` / `handleCardSetup`).
4. Calls the Decoupled Checkout **capture** endpoint to finalize the order.

## Test before you go live

Use Stripe test keys and test cards to run the full flow — order creation, payment
creation, client‑side confirmation, and capture — before switching to live keys.

## Security notes

The module's review notes record that the trust boundary is implemented correctly:

- **The gateway does not trust a client‑supplied "paid" status.** When recording
  the payment it calls Stripe's **`PaymentIntent::retrieve()`** with your secret
  key to read the intent's real status from Stripe server‑side, and sets the
  Commerce payment state from that authoritative status only.
- **Amount tampering is not a vector**, because the PaymentIntent amount is set
  server‑side when the intent is created.
- Your responsibilities: keep the Stripe **secret key** private (store it via the
  Key/env pattern above), and operate over **HTTPS**.
