# Configuration

Konnect is set up as a Drupal Commerce **payment gateway** — there is no separate
global settings page. You add one gateway and configure it there.

## Before you start: store your Konnect credentials safely

Konnect issues an **API key**, an **API secret**, and a **receiver wallet ID**.
The API secret is a secret — never paste it into committed code or a configuration
export that lands in version control.

On a DDEV site, keep the value in an environment variable and expose it to Drupal
through a **Key** entity:

1. Save the secret into DDEV's dotenv file:

   ```bash
   ddev dotenv set .ddev/.env --konnect-api-secret=<your-secret>
   ddev restart
   ```

   The flag `--konnect-api-secret` becomes the environment variable
   `KONNECT_API_SECRET`. Keep `.ddev/.env` out of version control.

2. Install the **Key** module if you don't already use it:

   ```bash
   ddev composer require drupal/key
   ddev drush en key -y
   ```

3. Create a Key that reads the environment variable and reference it from the
   gateway form rather than typing the raw secret.

## Add the Konnect gateway

1. Log in as a user who can **administer commerce payment gateways** (an
   administrator by default).
2. Go to **Administration → Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
3. Click **Add payment gateway** and give it a customer‑friendly **Name**.
4. Choose the **Konnect** plugin.

## Fill in the gateway settings

- **API key** — the public API key from your Konnect dashboard.
- **API secret** — enter this (or reference the Key you created above). It
  authenticates the server‑side calls the module makes to Konnect to verify each
  transaction.
- **Receiver wallet ID** — the Konnect wallet that receives the payments.
- **API environment (sandbox vs live)** — start in **sandbox** while you set things
  up and switch to **live** only after confirming a real end‑to‑end payment. Using
  the wrong environment either fails against the live service or produces orders
  that were never really charged.
- **Send payment confirmation email** — when checked, Konnect sends the payment
  receipt to the customer.
- **Webhook URL** — optional. If you supply a URL here, the module forwards it to
  Konnect (as `webhookUrl`) when it creates each payment. Leave it empty unless
  Konnect has told you exactly what to enter.

## How an order is confirmed

You do not need to add your own signature check. When the shopper returns from
Konnect, the module **re‑fetches the transaction from Konnect's authenticated API**,
confirms the transaction's order ID matches this order, and completes the order only
when the API reports `CAPTURED` — and it does so idempotently. Authenticity comes
from the authenticated API lookup, not from the returning request, so a forged
return cannot mark an order paid.

## Save and test end to end

Click **Save**, then place a test order. Choose Konnect at checkout; you should be
redirected to Konnect's hosted page to pay, and on returning the order should be
completed only after the module confirms a `CAPTURED` status server‑side. Confirm
the whole flow works in **sandbox** before switching to **live**.
