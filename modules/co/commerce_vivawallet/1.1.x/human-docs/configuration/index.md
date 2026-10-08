# Configuration

Commerce Viva Wallet is configured as a standard Drupal Commerce payment gateway.

## Store your Viva credentials as secrets

Your Viva Wallet **client ID/secret**, **merchant ID**, and **API key** are
credentials. This gateway stores them directly in its **payment-gateway
configuration** as plain text fields — it does **not** integrate with the Key
module, so there is no Key selector on the form and no `getenv()` hook into the
gateway settings. Because Drupal exports payment-gateway config, those credentials
land in exported/committed config by default.

The module's README recommends keeping them out of version control by **excluding
the gateway config from export** with
[Config Ignore](https://www.drupal.org/project/config_ignore) (or a similar
module):

1. Install and enable Config Ignore:

   ```bash
   ddev composer require drupal/config_ignore
   ddev drush en config_ignore -y
   ```

2. Add the gateway config entity to its ignore list, e.g.
   `commerce_payment.commerce_payment_gateway.<your gateway id>`, so its credential
   values are not overwritten or exported on config import/export.

3. Enter the live credentials **only in the environment that uses them** and keep
   the exported config free of real secrets.

## Add the Viva Wallet payment gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Choose the **Viva Wallet** plugin.
3. Enter your Viva **merchant ID**, **API key**, **client ID**, **client secret**,
   and **source code** for each mode (test and live) as the form asks. All are
   plain text fields.
4. Set the gateway **mode** — Viva's demo/sandbox while you set up, live for
   production.
5. Save.

## Set up the webhook

Viva confirms payments to your site via a webhook.

1. In the Viva.com portal, configure the webhook to point at your site's Viva
   notification URL for this gateway.
2. Viva validates the endpoint by calling the module's **`verify_hook`** endpoint,
   which returns Viva's verification key — this is a standard part of Viva webhook
   setup.

The module verifies real payments by **re‑fetching the transaction from Viva's
API** using the transaction id in the webhook, so the payment status always comes
from Viva's authenticated API rather than the webhook payload.

## Test vs live

Use Viva's demo credentials and the gateway's test mode first. Place a **test
order**, complete payment, and confirm the order is marked paid after the webhook
fires and the transaction is re‑fetched. Then switch to live credentials and live
mode.

## Security recap

- The webhook is **authoritative by re‑fetch**: it carries only a transaction id,
  and the module fetches the real transaction from Viva's API before setting the
  payment state — so a forged webhook cannot mark an order paid.
- The **`verify_hook`** GET endpoint implements Viva's standard webhook-registration
  handshake so Viva can confirm the callback URL.
- Keep the **client credentials** out of committed/exported config (use Config
  Ignore, as the README recommends), and serve the site over HTTPS.
