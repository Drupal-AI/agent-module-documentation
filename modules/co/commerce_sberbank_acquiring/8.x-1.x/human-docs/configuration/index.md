# Configuration

Sberbank Acquiring is configured like any Drupal Commerce payment gateway — you
add a gateway entity and fill in its settings.

## Before you start: store your API credentials as secrets

The Sberbank API **username and password** are secrets. Keep them out of
version-controlled configuration by holding the value in an environment variable
and exposing it through a **Key** entity:

1. Save the value into DDEV's env file (never commit `.ddev/.env`):
   ```bash
   ddev dotenv set .ddev/.env --sberbank-api-password=<value>
   ddev restart
   ```
2. Make sure the Key module is available:
   ```bash
   ddev composer require drupal/key
   ddev drush en key -y
   ```
3. Create a Key that reads the environment variable:
   ```bash
   ddev drush key:save sberbank_api_password --label='Sberbank API password' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"SBERBANK_API_PASSWORD","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

Where the gateway form has no Key selector, override the secret from
`settings.php` rather than committing it.

## Add the payment gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Give it a **Name** (for example "Card payment (Sberbank)").
3. Choose the **Sberbank Acquiring** plugin.

## Gateway settings, field by field

- **Payment mode (Test / Live)** — Sberbank provides separate test and live REST
  APIs, each with its own username and password. Start in **Test** and only move
  to **Live** once test transactions reconcile cleanly. The credentials are
  *different* per mode, so switching mode means switching credentials too.
- **Username** — the Sberbank API username for the selected mode.
- **Password** — the Sberbank API password for the selected mode. Supply this
  from the Key/secret you created above rather than pasting a production secret
  into the form. On a later edit, leave the Password field **empty** to keep the
  currently saved password unchanged.
- **Order ID prefix / suffix** (under *Order ID prefix and suffix*) — optional.
  Leave both empty in normal use. They only change the order identifier sent to
  Sberbank (the Drupal order id is unaffected) and exist to keep that identifier
  unique if you have previously used the same ids — for example across several
  development environments.

## Save and test

Click **Save**, then place a test order. The module registers the order with
Sberbank and confirms the payment status back through Sberbank's API. Sberbank
publishes test card numbers you can use — check their documentation for the
current list.

## Security reminder

- Serve checkout over **HTTPS** and keep credentials in secrets, not in exported
  config.
- Payment status is confirmed **server-side** against Sberbank's authenticated
  API — that is the correct model; don't replace it with anything that trusts a
  client-supplied return.
- Remember this project is **not covered by the security advisory policy**, so
  monitor it and apply updates yourself.
