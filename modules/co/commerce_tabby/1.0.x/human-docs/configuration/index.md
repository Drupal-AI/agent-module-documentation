# Configuration

You configure this module by adding a Tabby payment gateway and entering your Tabby API
credentials.

## Add the payment gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Choose the **Tabby** plugin.
3. Enter your Tabby **secret API key** and **public API key**.
4. Choose the **mode** (test/live) as offered, with the matching keys, and save the gateway.

## Handle the Tabby API keys securely

Your Tabby **secret key** is a credential that must never end up in a public repository or a
committed configuration export. Keep the values in environment variables. With DDEV:

```bash
ddev dotenv set .ddev/.env --tabby-secret-key=<value> --tabby-public-key=<value>
ddev restart
```

Keep `.ddev/.env` out of version control. Where the field supports it, reference the values
through [Key](https://www.drupal.org/project/key) entities rather than pasting the raw secrets
into the form. Always serve the site over HTTPS.

## How payment is confirmed

The customer is redirected to Tabby to pay and is returned to your store, and Tabby also
notifies your site via a webhook. On both the return leg and the webhook the module reads the
Tabby **payment ID** from the request and re-fetches that payment from Tabby's API server-side
(`GET v2/payments/{id}` as an authenticated request with your secret key). The order is
authorized or completed only when that authenticated API response reports the payment as
**`CLOSED`** or **`AUTHORIZED`**. The local payment is matched via `meta.payment_id`, order
transitions are lock-guarded, and repeat deliveries do nothing once the payment has moved past
its initial state. The webhook URL is registered with Tabby automatically when you save the
gateway.

## Test before going live

In test mode with your Tabby test keys, place a test order and complete the Tabby flow to
confirm the order is authorized/completed only after the server-side API check reports the
payment `CLOSED`/`AUTHORIZED`. Then switch to live mode with your live keys.
