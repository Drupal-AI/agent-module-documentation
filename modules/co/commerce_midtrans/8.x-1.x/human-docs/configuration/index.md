# Configuration

Configuring Commerce Midtrans means adding a payment gateway and entering the keys
from your Midtrans account.

## Add the payment gateway

1. Log in as a user who can administer Commerce.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
3. Click **Add payment gateway**.
4. Give it a **Name** and choose the **Midtrans** plugin.

## The settings, field by field

- **Mode** — choose **test/sandbox** while integrating and **production** to
  accept real payments. Use the matching Midtrans keys for the mode you select.
- **Client key** — your Midtrans client key, used by the Snap front-end flow.
- **Server key** — your Midtrans server key. This is the credential the module
  uses to fetch the authoritative transaction status from Midtrans, so it must be
  kept secret.

Save the gateway.

## Connect the notification (webhook) URL

Midtrans confirms payments by posting a notification to your site. In your
Midtrans dashboard, set the notification/payment URL to your site's Midtrans
notify endpoint so Midtrans can reach it. Because the module re-fetches the real
transaction status from Midtrans when a notification arrives, the confirmation is
trustworthy — but Midtrans still needs a reachable URL to trigger it.

## Keep your server key secret

Your Midtrans **server key** is a secret — treat it like a password:

- Don't commit it to version control.
- Prefer storing it in an environment variable rather than hard-coding it. With
  DDEV you can set it once with the built-in dotenv command:

  ```bash
  ddev dotenv set .ddev/.env --midtrans-server-key='<your server key>'
  ddev restart
  ```

  Keep `.ddev/.env` out of version control.
- Always serve checkout over **HTTPS**.

## How the payment is confirmed (why it's safe)

The notification route is publicly reachable (Midtrans has to be able to call it),
but the module does **not** trust the posted body. Instead, the Midtrans SDK
re-queries the transaction status directly from Midtrans server-side using your
server key, and only then completes the order. This means a forged notification
cannot complete an unpaid order.

## Test before going live

With the gateway in test/sandbox mode and your sandbox keys, run a full checkout
and confirm the payment records against the order. Switch to production keys only
once the sandbox flow works cleanly.
