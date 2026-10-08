# Configuration

Configuring Commerce Merchant Warrior means adding a payment gateway and entering
the credentials from your Merchant Warrior merchant account.

## Add the payment gateway

1. Log in as a user who can administer Commerce.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
3. Click **Add payment gateway**.
4. Give it a **Name** and choose the **Merchant Warrior** plugin.

## The settings, field by field

- **Merchant UUID** — your Merchant Warrior merchant identifier.
- **API key** — your Merchant Warrior API key.
- **API passphrase** — the passphrase used to **sign** every request to Merchant
  Warrior (an md5 transaction hash for transaction operations, and an HMAC-SHA256
  message hash for card verification). This is the value that proves requests come
  from you, so guard it carefully.
- **Mode** — choose **test** while integrating and **live** for real payments.
- **Transaction type** — depending on your setup, the gateway can **authorize**
  only, or **authorize and capture** the order total in one step.

Save the gateway. On the standard Drupal checkout, the customer enters their card
in the Payframe, continues to review, and completes the order — which authorizes
(and optionally captures) the payment on Merchant Warrior.

## Keep your credentials secret

The merchant UUID, API key, and especially the API passphrase are secrets — treat
them like passwords:

- Don't commit them to version control.
- Prefer storing them in environment variables rather than hard-coding them. With
  DDEV you can set one once with the built-in dotenv command:

  ```bash
  ddev dotenv set .ddev/.env --mw-api-passphrase='<your passphrase>'
  ddev restart
  ```

  Keep `.ddev/.env` out of version control.
- Always serve checkout over **HTTPS**.

## How the payment is confirmed (why it's safe)

Every outbound request to Merchant Warrior is **signed** using your API passphrase
(an md5 transaction hash for transaction operations, and an HMAC-SHA256 message
hash for card verification), and cards/payment methods are **verified server-side** via
the Direct API (`verifyCard`) rather than trusting a browser-supplied status. Card
data is tokenized by the Payframe iframe and never reaches your server. As a
result, payment outcomes are derived from authenticated Merchant Warrior API
responses, not from a forgeable callback.

## Test before going live

With the gateway in **test** mode, run a full checkout and confirm the
authorization (and capture, if enabled) records against the order. Switch to
**live** mode only once the test flow works cleanly.
