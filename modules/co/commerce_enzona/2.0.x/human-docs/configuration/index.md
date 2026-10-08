# Configuration

Commerce Enzona is configured on the Commerce payment-gateway form — there is no
separate settings page.

## Add the gateway

1. Log in as a user who can administer Commerce.
2. Go to **Administration → Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
3. Give it a name and choose the **Enzona Redirect Checkout** plugin.
4. Fill in the plugin settings (below) and **Save**.

## Gateway settings

| Field | What to enter |
|-------|----------------|
| **Consumer Key** | Your EnZona API consumer key. |
| **Consumer Secret** | Your EnZona API consumer secret. |
| **Merchant ID** | Your numeric EnZona merchant id. |
| **Merchant UUID** | Your EnZona merchant UUID, if your account requires one. |
| **Grant Type** | `Client Credentials` (recommended) or `Password`. |
| **Username / Password** | Only shown and required when grant type is `Password`. |
| **API Base URL** | Production: `https://api.enzona.net/payment/v1.0.0`. Sandbox: `https://sandbox.enzona.net/payment/v1.0.0`. |
| **Test mode** | Enable while testing against the sandbox. |
| **Terminal ID** | Your EnZona terminal id (default `12121`). |

Point the **API Base URL** at the sandbox and turn on **Test mode** while you are
setting up, then switch both to your production values when you go live. Use
separate credentials for your test and live environments, and always operate over
HTTPS.

## How checkout works

Once the gateway is enabled and configured, EnZona appears as a payment option at
checkout. When the shopper chooses it and continues, the module creates a payment
order at EnZona and redirects them to EnZona's hosted checkout to pay. After paying
they are returned to your site, the module confirms the transaction's status with
EnZona, and — when EnZona reports it paid — records the payment and places the
order. A cancelled payment returns the shopper to the checkout payment step.

## Credentials are secrets

Your EnZona consumer key and secret are sensitive. Restrict who can administer
payment gateways, avoid committing exported gateway configuration that contains
live credentials to version control, and keep production credentials out of your
test environments.
