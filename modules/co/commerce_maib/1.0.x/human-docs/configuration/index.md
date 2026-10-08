# Configuration

Commerce MAIB is configured the same way as any Drupal Commerce payment gateway:
you add a gateway and fill in a settings form. The one thing that makes MAIB
different is that it authenticates with a **client certificate** rather than a
plain API key, so part of setup is loading the certificate files the bank gave
you and keeping them safe.

## Add the payment gateway

1. Log in as a user who can administer Commerce.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
3. Click **Add payment gateway**.
4. Give it a **Name** your customers won't see (for example, "MAIB card
   payment") and choose the **MAIB** plugin.

## The settings, field by field

The exact labels come from the gateway plugin, but you will be setting:

- **Mode** — choose **Test** while you are developing and testing, and switch to
  **Live** only when you are ready to accept real payments. The bank issues
  different certificates/credentials for test and live, so make sure the mode
  matches the certificate you load.
- **Transaction type** — pick how money is taken:
  - **Capture** *(recommended)* — the customer's funds transfer to your merchant
    account immediately when they pay.
  - **Authorize** — the funds are held (blocked) on the customer's account and
    only captured when you later confirm the transaction. This is mainly for
    stores with long shipping/fulfilment times.
- **Certificate / private key and PFX password** — MAIB gives you a **PFX**
  bundle; you extract the certificate and private key from it, and the gateway
  needs the paths to those files (plus the PFX password) so it can authenticate
  to the bank's server.

Save the gateway. Because MAIB confirms every transaction by querying its own API
after the customer returns, the recorded payment reflects the bank's authoritative
answer rather than anything the browser reported.

## Handling the certificate, key, and password securely

These files are the keys to your merchant account — treat them like passwords:

- **Keep the private key file outside the web root** so it can never be served
  over HTTP, and make it readable only by the web server user.
- **Never commit** the certificate, private key, or PFX password to version
  control.
- Store the **PFX password** in an environment variable rather than hard-coding
  it. With DDEV you can set it once with the built-in dotenv command and read it
  back from Drupal:

  ```bash
  ddev dotenv set .ddev/.env --maib-pfx-password='<the password>'
  ddev restart
  ```

  Keep `.ddev/.env` out of version control.
- Always serve the site over **HTTPS** so the redirect to and from MAIB is
  protected.

## Test before going live

With **Mode = Test** and your test certificate, run a full checkout end to end and
confirm the payment shows up against the order and in your MAIB test account. Only
switch to **Live** (and the live certificate) once the test flow works cleanly.
