# Configuration

Setup has two halves: add the payment gateway in Commerce (with a specific machine name),
and configure the matching webhook in your Stripe Dashboard.

## Add the payment gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Choose **Stripe Sofort**.
3. **Set the machine name (payment gateway ID) to `commerce_sofort_stripe`.** The module
   expects this specific ID — set it deliberately when you create the gateway.
4. Enter your Stripe **publishable key**, **secret key**, and **signing secret**.
5. Set the **available countries** to Sofort's supported markets: Austria, Belgium, Germany,
   Italy, the Netherlands, and Spain.
6. Save the gateway.

## Handle the Stripe secrets securely

The Stripe **secret key** and **signing secret** are credentials — keep them out of committed
configuration by storing the values in environment variables. With DDEV:

```bash
ddev dotenv set .ddev/.env --stripe-secret-key=<sk_...> --stripe-sofort-signing-secret=<whsec_...>
ddev restart
```

Keep `.ddev/.env` out of version control. Where the field supports it, reference the value
through a [Key](https://www.drupal.org/project/key) entity. As an alternative for
multi-environment setups, the module also lets you place the signing secret in your
`settings.php`:

```php
$settings['stripe.sofort']['signing_secret'] = getenv('STRIPE_SOFORT_SIGNING_SECRET');
```

Reading it from an environment variable (rather than hard-coding the literal secret) keeps it
out of your repository.

## Set up the Stripe webhook

1. In your Stripe Dashboard, add a webhook endpoint pointing at:

   ```
   https://your-site.example/stripe-sofort-webhook
   ```

2. Under event types, select the charge events (Stripe selects the full set — 13 events).
   The module specifically acts on `payment_intent.payment_failed`,
   `payment_intent.canceled`, and the payment-success event.
3. Copy the endpoint's **signing secret** for this environment into the gateway (or into
   `settings.php` as above).
4. Make sure **Sofort** is enabled as a payment method in your Stripe Dashboard.

## How orders are completed

When Stripe sends a webhook, the module reads only the **charge ID** from the body and then
**re-fetches that charge from Stripe** with `Charge::retrieve()`. It derives the order from
the re-fetched charge's `source.metadata.order_id` and completes the order **only when
Stripe's own record shows `paid == TRUE`**.

Configure the signing secret and keep the endpoint on HTTPS.

## Test before going live

Using an internet-reachable URL (see the tunnel note in
[Installation](../installation/index.md)) and Stripe test keys, place a test order, complete
the Sofort flow, and confirm the order only completes after Stripe's webhook and the
server-side charge re-fetch report it paid.
