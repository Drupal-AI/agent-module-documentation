# Configuration

Commerce Eurobank is configured on the payment‑gateway form — there is no separate
settings page.

## Add the gateway

1. Log in as a user who can administer Commerce.
2. Go to **Administration → Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
3. Choose the **Eurobank Payment Redirect** plugin.

## Fill in the fields

The values come from your Eurobank / Modirum vPOS agreement:

- **Spec version** — the Modirum vPOS specification version for your account.
- **Merchant ID** — your Eurobank merchant identifier.
- **Currency** — the transaction currency.
- **Confirm URL** and **Cancel URL** — where Eurobank sends the shopper on
  success/cancel. Point these at the module's callback route,
  `/commerce_eurobank_redirect/callback`.
- **vPOS post URL** — the Eurobank endpoint the shopper is redirected to.
- **Shared secret** — see the warning below.

Save the gateway.

## ⚠️ Change the default shared secret

The gateway ships with the shared secret set to the literal string **`SECRET`**.
This is the single key used to validate every callback digest — **you must replace
it** with the value Eurobank issues to you, and keep it unique and confidential.
Leaving it at the default would defeat the callback verification entirely.

Prefer keeping the secret out of exported configuration by storing it in an
environment variable and referencing it:

```bash
ddev dotenv set .ddev/.env --eurobank-shared-secret=<value>
ddev restart
```

## Wire up the callback

In your Eurobank vPOS configuration, set the confirm and cancel URLs to the
module's callback route (`/commerce_eurobank_redirect/callback`) so Eurobank can
post the transaction result back to your site.

## How a payment completes

When Eurobank posts a callback, the module recomputes the digest as
`base64(sha256(response fields + shared secret))` and compares it strictly — a
wrong or absent digest is rejected. A completed payment is only created when the
digest matches **and** the status is CAPTURED or AUTHORIZED, and the amount is
taken server‑side from the order balance (not from the raw callback amount). A
CANCELED status returns the shopper to the checkout cancel step; a mismatched
digest records an "Unvalidated" payment and logs an alert. All callback data is
also logged to the order for auditing.
