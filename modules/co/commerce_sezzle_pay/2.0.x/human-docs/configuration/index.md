# Configuration

Sezzle Pay is configured like any Drupal Commerce payment gateway — you add a
gateway entity and fill in its settings.

## Before you start: store your API keys as secrets

Your Sezzle **private key** (and public key) are secrets. Keep them out of
version-controlled configuration by holding the value in an environment variable
and exposing it through a **Key** entity:

1. Save the value into DDEV's env file (never commit `.ddev/.env`):
   ```bash
   ddev dotenv set .ddev/.env --sezzle-private-key=<value>
   ddev restart
   ```
2. Make sure the Key module is available:
   ```bash
   ddev composer require drupal/key
   ddev drush en key -y
   ```
3. Create a Key that reads the environment variable:
   ```bash
   ddev drush key:save sezzle_private_key --label='Sezzle private key' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"SEZZLE_PRIVATE_KEY","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

Where the gateway form has no Key selector, override the secret from
`settings.php` so it stays out of committed config.

## Add the payment gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Give it a **Name** (for example "Pay in instalments (Sezzle)").
3. Choose the **Sezzle Pay** plugin.

## Gateway settings, field by field

- **Mode (Live / Sandbox)** — Sezzle has separate live and sandbox environments,
  each with its own keys. Start in **Sandbox** and switch to **Live** only after
  a clean test run.
- **Public key** and **Private key** — the API credentials from your Sezzle
  dashboard for the selected mode. Supply the private key from the Key/secret set
  up above. Saving the gateway **registers the Sezzle webhook** for you.
- **Sync shipping information** — optionally copy the shipping address Sezzle
  captured back onto the Commerce order.
- **Merchant-completes mode** — controls whether the merchant, rather than the
  automatic flow, finalises the captured order.
- **Skip review** — enables the optional checkout pane that skips the review step.
- **Logging** — logs API and webhook messages, useful while debugging; turn it
  down in production.

## Decoupled (headless) mode

If you run a headless front-end, tick the **decoupled (headless)** flag on the
gateway (this switches the API to V2), use the Sezzle SDK on your front-end, and
when the customer returns append a `session` query parameter carrying the order
UUID. The plugin then resumes your flow.

## Save and test

Click **Save**, then place a sandbox order end to end. On return, the module
re-fetches the order from Sezzle and completes payment only if Sezzle reports it
captured/approved. Use Sezzle's published test data for sandbox runs.

## Security reminder

- Keep the **API keys in secrets**, and serve checkout over HTTPS.
- Completion depends on the module **re-fetching the order from Sezzle** with a
  merchant token — that is the correct model.
