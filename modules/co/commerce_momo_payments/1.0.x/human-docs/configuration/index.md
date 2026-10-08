# Configuration

Configuring Commerce MoMo Payments means adding one gateway per MoMo payment type
you want to offer and entering the credentials from your MoMo merchant account.

## Add the payment gateway(s)

1. Log in as a user who can administer Commerce.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
3. Click **Add payment gateway**.
4. Give it a **Name** and choose one of the MoMo plugins — **MoMo Wallet**,
   **MoMo Pay with ATM**, or **MoMo Credit Card**. Repeat to offer more than one.

## The settings, field by field

- **Partner code** — your MoMo partner code.
- **Access key** — your MoMo access key.
- **Secret key** — the key used to **sign** outbound requests and **verify** the
  HMAC-SHA256 signature on responses. This is the sole signing key, so it must be
  kept confidential.
- **API endpoint / mode** — set the MoMo API endpoint to match the mode you are
  using (MoMo's sandbox endpoint for testing, the live endpoint for production).
  Make sure the endpoint matches the selected mode.

Save the gateway. Provide MoMo with your **IPN URL** (the server-to-server
notification endpoint); the return URL is the standard Commerce checkout return.

## Keep your secret key secret

The MoMo secret key signs and verifies every payment message — treat it like a
password:

- Don't commit it to version control.
- Prefer storing it in an environment variable rather than hard-coding it. With
  DDEV you can set it once with the built-in dotenv command:

  ```bash
  ddev dotenv set .ddev/.env --momo-secret-key='<your secret key>'
  ddev restart
  ```

  Keep `.ddev/.env` out of version control.
- Always serve checkout over **HTTPS**.

## Test before going live

With the sandbox endpoint and test credentials, run a full checkout for each MoMo
type you offer and confirm the payment records against the order. Switch to the
live endpoint and credentials only once the sandbox flow works cleanly.
