# Configuration

SagePay is configured like any Drupal Commerce payment gateway — you add a
gateway entity and fill in its settings.

## Before you start: store your integration credentials as secrets

Your SagePay **integration key** and **password** are secrets. Keep them out of
version-controlled configuration by holding the value in an environment variable
and exposing it through a **Key** entity:

1. Save the value into DDEV's env file (never commit `.ddev/.env`):
   ```bash
   ddev dotenv set .ddev/.env --sagepay-integration-password=<value>
   ddev restart
   ```
2. Make sure the Key module is available:
   ```bash
   ddev composer require drupal/key
   ddev drush en key -y
   ```
3. Create a Key that reads the environment variable:
   ```bash
   ddev drush key:save sagepay_integration_password --label='SagePay integration password' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"SAGEPAY_INTEGRATION_PASSWORD","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

Where the gateway form has no Key selector, override the secret from
`settings.php` rather than committing it.

## Add the payment gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Give it a **Name** (for example "Credit card").
3. Choose the **SagePay (On-site)** plugin.

## Gateway settings, field by field

- **Mode (Test / Live)** — SagePay uses different integration keys and passwords
  for test and live. Start in **Test** and switch to **Live** only after a clean
  test run.
- **Vendor name** — your SagePay/Opayo vendor account name.
- **Integration key** and **Integration password** — the API credentials for the
  selected mode. Supply the password from the Key/secret you created above rather
  than pasting a production secret into the form. Test and live have *different*
  credentials.
- **Order description** — the text sent to SagePay to describe the transaction on
  their side.
- **AVS / CV2 security checks** — configure how address- and card-verification
  results are applied. Tightening these reduces fraud but can decline legitimate
  cards, so match them to your risk appetite.
- **Payment method type** — this gateway serves the standard **credit card**
  payment method type and collects card details on your checkout page.

## Save and test

Click **Save**, then place a test order. The customer enters card details on your
site, completes the 3-D Secure challenge, and is returned to checkout; on success
the order gets a Commerce payment for the order total.

## Good practice

- Keep **payment-gateway administration limited to trusted roles**.
- Serve the entire checkout over **HTTPS**.
