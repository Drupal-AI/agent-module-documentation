# Configuration

Commerce N-Genius is configured as a **Commerce payment gateway**. There is no
separate global settings page.

## Store your API key securely

Your N-Genius API key is a secret — never hard‑code or commit it. With DDEV, keep it
in an environment variable and load it through a Key entity:

```bash
ddev dotenv set .ddev/.env --ngenius-api-key=<value>
ddev restart
```

Install the Key module if it isn't enabled, then reference the variable from a Key
entity so the credential never lives in exported configuration.

## Add the N-Genius payment gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Choose the **N-Genius** plugin.
3. Fill in the fields:
   - **Outlet reference** — the Outlet identifier from your N-Genius dashboard.
   - **API key** — your N-Genius API key (reference the Key entity above).
   - **Mode** — **Test** (UAT endpoints) while validating, or **Live** for real
     transactions.
4. Save. Only trusted roles should be able to administer payment gateways.

## How the payment flow works

This is an **offsite** gateway. At checkout the shopper is redirected to the
N-Genius hosted page to enter their card. On return, the module uses your
credentials to obtain an OAuth client-credentials access token, then fetches the
order's 3‑D Secure status from N-Genius over HTTPS. Checkout completes when the
status is *SUCCESS* and is aborted on *FAILED* or a missing status. Successes and
failures are logged.

## Payment records

This version does not create a Commerce payment entity when a payment succeeds
(it only logs). Reconcile N-Genius transactions against orders out of band (for
example against your N-Genius dashboard). Always run in **test** mode first and
confirm a full checkout end to end.
