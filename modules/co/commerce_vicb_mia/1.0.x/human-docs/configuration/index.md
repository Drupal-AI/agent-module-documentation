# Configuration

Commerce Victoria Bank MIA is configured as a standard Drupal Commerce payment
gateway.

## Store your credentials as secrets

Your Victoria Bank MIA **username** and **password** are credentials. Keep them out
of committed configuration. On a DDEV project, store them in environment variables
and expose them through Key entities:

1. Save the credentials into DDEV's environment file (never commit `.ddev/.env`):

   ```bash
   ddev dotenv set .ddev/.env --vicb-mia-username=YOUR_USER --vicb-mia-password=YOUR_PASS
   ddev restart
   ```

2. Confirm they are set **without printing their values**:

   ```bash
   ddev exec 'test -n "$VICB_MIA_USERNAME" && test -n "$VICB_MIA_PASSWORD"'   # exit 0 means both set
   ```

3. Install **Key** if needed and create Keys that read the variables:

   ```bash
   ddev composer require drupal/key
   ddev drush en key -y
   ddev drush key:save vicb_mia_password --label='Victoria Bank MIA Password' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"VICB_MIA_PASSWORD","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

If the gateway form only offers plain text fields, reference the variables from
`settings.php` via `getenv('VICB_MIA_PASSWORD')` rather than committing them.

## Add the payment gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Choose the **Victoria Bank MIA** plugin.
3. Enter:
   - **Username** and **password** (use the Keys above where the form allows).
   - **Company IBAN** and **company name**.
   - **QR code timeout** — set to **5 minutes** as the bank recommends.
4. Set the gateway **mode** to test while you set up, then switch to live for
   production.
5. Save.

## Callback URL

Give Victoria Bank this callback (notification) URL for your site:

```
https://yourdomain.com/commerce-vbmd-mia/callback
```

The bank posts to this URL after payment. The module then re‑fetches the QR status
directly from the bank to decide the outcome (see the security recap).

## Test vs live

Complete a **test payment** end to end — generate the QR, pay it, and confirm the
order is marked paid once the status re‑fetch returns `STATUS_PAID`. Then switch to
live mode.

## Security recap

- The callback is handled safely: the module **re‑fetches the QR status
  server‑side** from the bank over an authenticated request, keyed on a QR
  identifier stored in its own database (not on the payload), and completes the
  order only on `STATUS_PAID`, using the **order's own total** — so a forged
  callback cannot mark an order paid.
- **Caveat:** the module's JWT signature verification is effectively **dead code**
  (empty secret, inverted guard), so the JWT is not actually validated. The
  server‑side re‑fetch is what protects you; fixing the JWT check would add
  defense‑in‑depth.
- Keep credentials in environment variables / Keys, never in committed config, and
  serve the site over HTTPS.
