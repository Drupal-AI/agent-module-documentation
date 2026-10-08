# Configuration

GNU Taler is configured as a standard Drupal Commerce payment gateway.

## Add the gateway

1. Log in as a user who can **administer commerce payment gateways**.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
3. Give it a **Name** and select the **GNU Taler** plugin.

## Fields

- **Backend URL** — the base URL of your Taler merchant backend, for example
  `https://backend.example.com/instances/sandbox/`. Include the trailing slash;
  the module resolves its API calls relative to this URL.
- **API Key** — sent to the backend as an `Authorization: Bearer <key>` header,
  typically in the RFC 8959 form `secret-token:...`. Obtain it from the backend's
  `/token` endpoint.
- **Refund Delay** — the number of days a customer may request a refund (minimum
  1).

When you **save**, the module instantiates its Taler client and calls the
backend's verification endpoint to confirm protocol compatibility. If the backend
cannot be contacted or is incompatible, the save is blocked — so make sure the
backend is reachable and your URL and key are correct.

## Replace the demo defaults before going live

The module ships with the **public demo backend**
(`backend.demo.taler.net/instances/sandbox/`) and a demo `secret-token:sandbox`
token pre-filled. These are for trying the module out only — **override both** with
your own production backend URL and API token before accepting real payments.

## Store the API key securely

The API key is a credential. Keep it out of version control by storing it in an
environment variable and referencing it through a **Key** entity where supported:

```bash
ddev dotenv set .ddev/.env --taler-api-key=<secret-token:your-token>
ddev restart
```

If the [Key module](https://www.drupal.org/project/key) is not enabled yet, add it
with `ddev composer require drupal/key && ddev drush en key -y`, then create a Key
that reads the environment variable.

## How payments and refunds behave

- **At checkout** the module creates a redirect order on the backend and sends the
  shopper to their Taler wallet.
- **On return** it re-fetches the order status from the backend and records a
  **completed** payment only when the backend reports `paid`, using the amount from
  the backend's contract terms — never a client-supplied value. This is the correct
  defensive pattern, so a forged return cannot complete an unpaid order.
- **Refunds** issued from the Commerce order admin send a refund request to the
  backend and email the customer a Taler refund URI to confirm.

## Currency note

The demo currency `KUD` is mapped to Taler's `KUDOS` key, so you can sell products
priced in KUDOS against the sandbox backend while testing.
