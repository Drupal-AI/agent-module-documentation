# Configuration

Redsýs is configured like any Drupal Commerce payment gateway — you add a gateway
entity and fill in the details your bank gave you.

## Before you start: store the merchant key as a secret

The Redsýs **merchant key** is a secret and must **not** live in exported,
version-controlled configuration. Keep it in an environment variable and expose
it through a **Key** entity:

1. Save the value into DDEV's env file (never commit `.ddev/.env`):
   ```bash
   ddev dotenv set .ddev/.env --redsys-merchant-key=<value>
   ddev restart
   ```
2. Make sure the Key module is available:
   ```bash
   ddev composer require drupal/key
   ddev drush en key -y
   ```
3. Create a Key that reads the environment variable:
   ```bash
   ddev drush key:save redsys_merchant_key --label='Redsys merchant key' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"REDSYS_MERCHANT_KEY","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

Where the gateway form has no Key selector, override the key from `settings.php`
so it stays out of committed config.

## Add the payment gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Give it a **Name** (for example "Card payment").
3. Choose the **Sermepa / Redsýs** plugin.

## Gateway settings, field by field

The exact labels come from your bank office; enter the values Redsýs issued you:

- **Environment / mode (Test / Live)** — Redsýs separates test and production by
  **both endpoint and key**. This matters: a mismatched environment typically
  fails as a *signature error* rather than a clear "wrong mode" message, so if
  signing suddenly fails, check the environment first. Start in **Test**.
- **Merchant code (FUC)** — your Redsýs merchant identifier.
- **Terminal number** — the terminal to route transactions through.
- **Merchant key** — the secret signing key for the selected environment. Supply
  it from the Key/secret set up above.
- **Communication method (GET / POST)** — both are supported; use whichever your
  bank specifies.
- **Currency / language** and other display options as your setup requires.

## Save and test

Click **Save**, then run a payment against the **Redsýs sandbox** before going
live. On return, the order's payment status is confirmed from the bank's
signed notification — do not weaken or bypass that signature verification, as it
is what protects payment integrity.

## Security reminder

- The **notification callback is the security-critical surface**; it is
  authenticated by HMAC signature via the `commerceredsys/sermepa` library. Any
  local change to signature verification is a payment-integrity change — avoid
  it.
- Keep the **merchant key in a secret**, never in exported configuration.
- Confirm **test vs production** carefully; the endpoint and key differ.
