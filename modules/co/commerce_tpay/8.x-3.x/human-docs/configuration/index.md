# Configuration

Commerce Tpay is configured as a standard Drupal Commerce payment gateway.

## Store your merchant secret as a secret

Your Tpay **Merchant secret** is a credential used to verify Tpay's notifications.
Keep it out of committed configuration. On a DDEV project, store it in an
environment variable and expose it through a Key entity:

1. Save the secret into DDEV's environment file (never commit `.ddev/.env`):

   ```bash
   ddev dotenv set .ddev/.env --tpay-merchant-secret=YOUR_SECRET_HERE
   ddev restart
   ```

   The flag `--tpay-merchant-secret` becomes the variable `TPAY_MERCHANT_SECRET`.

2. Confirm it is set **without printing its value**:

   ```bash
   ddev exec 'test -n "$TPAY_MERCHANT_SECRET"'   # exit 0 means set
   ```

3. Install **Key** if needed and create a Key that reads the variable:

   ```bash
   ddev composer require drupal/key
   ddev drush en key -y
   ddev drush key:save tpay_merchant_secret --label='Tpay Merchant Secret' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"TPAY_MERCHANT_SECRET","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

If the gateway form only offers a plain text field for the secret, reference the
environment variable from `settings.php` via `getenv('TPAY_MERCHANT_SECRET')`
rather than committing the raw value.

## Add the Tpay payment gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. For the plugin, choose **Tpay Redirect**.
3. Enter your credentials:
   - **Merchant ID** — from your Tpay panel.
   - **Merchant secret** — from **Tpay panel → Settings → Notifications →
     Security**. Use the Key you created above where the form allows it.
4. Optionally enable the **on‑site bank selection** step and choose a
   bank‑selection plugin, if you want customers to pick their bank before being
   redirected.
5. Set the gateway **mode** to test/sandbox while you set up, then switch to live
   for production.
6. Save.

## Notification (IPN) URL

The module uses Commerce's standard notification route for this gateway
(`commerce_payment.notify`). Tpay calls it after payment to confirm the result; the
module verifies the checksum and the signed CRC before recording the payment. Make
sure your site is reachable over HTTPS so Tpay can reach this URL.

## Test vs live

Run the full **redirect + notify loop in Tpay's sandbox** before going live —
place a test order, complete payment on Tpay, and confirm the order is marked paid
by the returning notification. Then switch the gateway to live mode.

## Security recap

- The notification handler **verifies Tpay's checksum** against your merchant
  secret and binds the confirmation to the order via the signed **CRC** field, and
  **de‑duplicates** repeated notifications — so a forged notification cannot mark an
  order paid.
- Keep the **merchant secret** in an environment variable / Key, never in committed
  config, and serve the site over HTTPS.
- The handler does not compare the paid amount to the order total; if partial
  payments are a concern for your Tpay configuration, verify that behavior with a
  test.
