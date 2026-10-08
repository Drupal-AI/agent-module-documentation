# Configuration

Commerce Valitor is configured as a standard Drupal Commerce payment gateway, with
a 3‑D Secure verification flow that runs automatically during checkout.

## Store your Valitor credentials as secrets

Your Valitor **API key/credentials** are secrets. Keep them out of committed
configuration. On a DDEV project, store them in an environment variable and expose
them through a Key entity:

1. Save the credential into DDEV's environment file (never commit `.ddev/.env`):

   ```bash
   ddev dotenv set .ddev/.env --valitor-api-key=YOUR_KEY_HERE
   ddev restart
   ```

2. Confirm it is set **without printing its value**:

   ```bash
   ddev exec 'test -n "$VALITOR_API_KEY"'   # exit 0 means set
   ```

3. Install **Key** if needed and create a Key that reads the variable:

   ```bash
   ddev composer require drupal/key
   ddev drush en key -y
   ddev drush key:save valitor_api_key --label='Valitor API Key' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"VALITOR_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

If the gateway form only offers a plain text field, reference the variable from
`settings.php` via `getenv('VALITOR_API_KEY')` rather than committing it.

## Add the Valitor payment gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Choose the **Valitor** plugin (or **ValitorMock** if you are wiring up automated
   tests).
3. Enter your Valitor **API credentials** (use the Key you created where the form
   allows it).
4. Select the **mode** — test while you set up, live for production.
5. Save.

## Stored payment methods

The gateway provides plugin forms for managing stored (tokenised) cards:

- **Add** — tokenise and store a card as a reusable payment method.
- **Edit** — edit a stored method.
- **Refund** — refund a captured payment.

## The 3‑D Secure flow

You don't configure 3DS separately — it runs as part of checkout via three
controller routes:

| Route | Purpose |
|-------|---------|
| `/valitor/{payment_gateway}/verify` | Starts card verification; on success opens the 3DS window. |
| `/valitor/3ds` | Renders the intermediate 3DS redirect page. |
| `/valitor/webhook` | Receives the 3DS result (reads `mdStatus`) and renders a success or error message. |

These routes have open access because the shopper's browser and the 3DS processor
call them mid‑checkout. The webhook only renders the verification outcome — it does
not move money — and the settlement/capture amount always comes from the order's
payment entity, not from the request.

## Test vs live

Use Valitor's test credentials and the gateway's test mode (or the ValitorMock
plugin) first. Place a **test order**, run a card through the 3DS verification, and
confirm the payment is captured for the correct order amount. Then switch to live
credentials and live mode.

## Security recap

- **Capture uses the order‑derived amount** (`$payment->getAmount()`), never a
  client‑supplied amount.
- The open (`_access: 'TRUE'`) verify/3ds/webhook routes are browser/processor
  callbacks; the webhook **renders status only** and performs no money movement.
- Keep the **API credentials** in an environment variable / Key, never in committed
  config, and serve the site over HTTPS.
