# Configuration

NoFraud needs configuration before it does anything. At minimum you must provide a
valid **API key** and choose a **mode**. Because the API key is a secret and the
integration sends personal and payment data to an external service, this page also
covers how to store the key safely rather than pasting it into plain configuration.

## Store the API key as a secret first (recommended)

Your NoFraud API key should not live in exported configuration or in version
control. The safest pattern on this project is to keep it in an environment
variable and, where the field accepts one, reference it through a **Key** entity.

1. **Save the key into DDEV's environment** (never commit `.ddev/.env`):

   ```bash
   ddev dotenv set .ddev/.env --nofraud-api-key=<your-key>
   ddev restart
   ```

   The flag `--nofraud-api-key` becomes the variable `NOFRAUD_API_KEY` inside the
   web container.

2. **Confirm it is present without printing its value:**

   ```bash
   ddev exec 'test -n "$NOFRAUD_API_KEY"'   # exit status 0 means it is set
   ```

3. **Create a Key entity** backed by that variable (install the Key module first
   if it isn't enabled — `ddev composer require drupal/key` and
   `ddev drush en key -y`):

   ```bash
   ddev drush key:save nofraud_api_key \
     --label='NoFraud API Key' \
     --key-type=authentication \
     --key-provider=env \
     --key-provider-settings='{"env_variable":"NOFRAUD_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

If the NoFraud settings form offers a Key selector, choose this key. If it only
offers a plain text field, paste the value there — but keep in mind it will then
live in configuration, so restrict who can export config and prefer the
environment‑variable approach where you can.

## Open the settings form

1. Log in as a user who can administer Commerce configuration.
2. Go to **Commerce → Configuration → NoFraud** (`/admin/commerce/config/nofraud`).

## Fields on the form

- **API key** — the NoFraud API key that authenticates every request to their
  service. Use the Key entity created above where possible; otherwise paste the
  key. Without a valid key, no screening happens.
- **Mode** — choose **Sandbox** while testing so nothing is sent to NoFraud's live
  production endpoint, and switch to **Production** only when you are ready to
  screen real orders. Do not send real transactions to the production API during
  testing.
- **Debug requests** — tick this checkbox to log the requests and responses
  exchanged with NoFraud. Turn it on while setting up or troubleshooting so you can
  see what is being sent; turn it off in normal operation to avoid noisy logs.

Click **Save** to store your settings.

## Data handling and the webhook

Screening an order sends order, billing/shipping, customer email, IP address and
partial card details to NoFraud over their API. This is external egress of
personal data — make sure your privacy policy discloses it, and that all traffic
runs over HTTPS.

NoFraud pushes status changes back to your site through the webhook at
`/webhook/nofraud/update-status`, which updates the corresponding transaction
record. You can review every recorded transaction at
`/admin/commerce/config/nofraud/list`.
