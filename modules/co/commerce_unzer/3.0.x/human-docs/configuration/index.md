# Configuration

Commerce Unzer is configured as a standard Drupal Commerce payment gateway.

## Store your Unzer keys as secrets

Your Unzer **private key** (and, depending on the flow, the public key) is a
credential. Keep it out of committed configuration. On a DDEV project, store it in
an environment variable and expose it through a Key entity:

1. Save the key into DDEV's environment file (never commit `.ddev/.env`):

   ```bash
   ddev dotenv set .ddev/.env --unzer-private-key=YOUR_PRIVATE_KEY_HERE
   ddev restart
   ```

   The flag `--unzer-private-key` becomes the variable `UNZER_PRIVATE_KEY`.

2. Confirm it is set **without printing its value**:

   ```bash
   ddev exec 'test -n "$UNZER_PRIVATE_KEY"'   # exit 0 means set
   ```

3. Install **Key** if needed and create a Key that reads the variable:

   ```bash
   ddev composer require drupal/key
   ddev drush en key -y
   ddev drush key:save unzer_private_key --label='Unzer Private Key' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"UNZER_PRIVATE_KEY","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

If the gateway form only offers a plain text field, reference the variable from
`settings.php` via `getenv('UNZER_PRIVATE_KEY')` rather than committing the key.

## Add the Unzer payment gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Choose the Unzer plugin — the **on‑site** gateway for credit‑card payment, or
   the **off‑site** redirect gateway if you need additional methods.
3. Enter your Unzer **private** and **public** keys (use the Key you created where
   the form allows it).
4. Set the gateway **mode** to test while you set up, then switch to live for
   production.
5. Save.

## Test vs live

Use Unzer's test credentials and the gateway's test mode first. Place a **test
order**, complete payment, and confirm the order is marked paid — the module
determines this by re‑fetching the payment from Unzer's API, so a successful
confirmation reflects a genuine Unzer transaction. Then switch to your live keys and
live mode.

## Security recap

- The gateway is **server‑authoritative**: on the off‑site return `onReturn()`
  re‑fetches the paypage and payment from the Unzer API
  (`fetchPaypageV2()` → `fetchPayment()`) and records the payment only when Unzer
  reports it completed; on‑site charges run server‑side and complete only on
  success. Payment status comes from Unzer's authenticated API, not from forgeable
  request parameters.
- Keep the **Unzer private key** in an environment variable / Key, never in
  committed config, and serve the site over HTTPS.
- Remember to set `serialize_precision = -1` (see
  [Installation](../installation/index.md)) to avoid rounding‑error exceptions.
