# Configuration

RagaPay is configured as a Drupal Commerce payment gateway. Go to **Commerce →
Configuration → Payment gateways** (`/admin/commerce/config/payment-gateways`) and
add a new gateway of type **RagaPay (Off‑site redirect)**.

## Gateway settings

- **Merchant key** — your RagaPay merchant identifier.
- **Password** — the shared secret from your RagaPay account. The module uses this to
  build the signed hash sent with the outbound redirect, so it must match exactly.
- **Notification URL** — the settings form shows the notification endpoint
  (`/ragapay/notification`) as read‑only. Copy it and register it in your RagaPay
  account so RagaPay knows where to POST payment results.

Save the gateway, and it becomes available as a payment option at checkout. At
checkout the customer is redirected to RagaPay to pay; on return, Commerce records a
payment for the order, and RagaPay's server‑to‑server notification updates the
payment state (`success` → completed, `fail` → canceled, `waiting` → pending).

## Keep the merchant credentials as secrets

The merchant key and especially the password are credentials that let requests be
signed on your behalf. Handle them like any other secret:

- Do not commit them to version control. Store them in environment variables. On
  DDEV, the built‑in dotenv helper keeps them out of the repo:

  ```bash
  ddev dotenv set .ddev/.env --ragapay-merchant-key='your-key' --ragapay-password='your-password'
  ddev restart
  ```

  (`.ddev/.env` must stay out of version control.)
- Where you can, reference the secret through a **Key** entity backed by that
  environment variable rather than storing the raw value in exported configuration.
- Make sure the site runs over **HTTPS** so credentials and payment data are never
  sent in the clear.
