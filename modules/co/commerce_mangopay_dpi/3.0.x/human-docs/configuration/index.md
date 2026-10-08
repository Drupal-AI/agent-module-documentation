# Configuration

Configuring Commerce MANGOPAY DPI means adding a payment gateway and entering your
MANGOPAY credentials. Make sure you have already installed the
**cardregistration-js-kit** library (see [Installation](../installation/index.md))
— the on-site card form depends on it.

## Add the payment gateway

1. Log in as a user who can administer Commerce.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
3. Click **Add payment gateway**.
4. Give it a **Name** and choose the **Mangopay** plugin (this is an *on-site*
   gateway, so the card form appears inside your checkout).

## The settings, field by field

- **MANGOPAY credentials** — enter your MANGOPAY **client id** and **API key**.
  These identify your MANGOPAY account when the module creates users/wallets and
  processes pay-ins.
- **Mode** — choose **sandbox** while testing and **production** to accept real
  payments. Use the matching sandbox or production credentials.
- **Payment method types** — enable the method types you want to offer:
  **Credit card** and/or **Apple Pay**. Apple Pay requires the usual Apple Pay
  merchant setup on the MANGOPAY side.

Save the gateway.

## Keep your API credentials secret

Your MANGOPAY API key is a secret — treat it like a password:

- Don't commit it to version control.
- Store it in an environment variable rather than hard-coding it. With DDEV you
  can set it once with the built-in dotenv command:

  ```bash
  ddev dotenv set .ddev/.env --mangopay-api-key='<your API key>'
  ddev restart
  ```

  Keep `.ddev/.env` out of version control.
- Always serve checkout over **HTTPS**.

## How the payment is confirmed (why it's safe)

During checkout the gateway uses several AJAX/callback endpoints — pre-registering
the card, processing the 3-D Secure "secure mode" return, and validating the
Apple Pay merchant session. These endpoints are intentionally reachable during
checkout, but the **payment outcome is not taken from them**: the module reads the
result from the server-side Commerce payment record and MANGOPAY's API (the
secure-mode / pay-in status), so a forged client response cannot mark an order
paid. Card data is tokenized in the browser and never transits your server.

## Test before going live

With sandbox credentials, run a full checkout end to end — including a 3-D Secure
card and (if you offer it) Apple Pay — and confirm the payment records against the
order. Switch to production credentials only once the sandbox flow works cleanly.
