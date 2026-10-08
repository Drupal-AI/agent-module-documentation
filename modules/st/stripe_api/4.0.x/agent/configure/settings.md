# Settings form + configuration (configure)

Route `stripe_api.admin` → `/admin/config/services/stripe_api`, form
`Drupal\stripe_api\Form\StripeApiAdminForm` (id `stripe_api_admin_form`), permission
`administer stripe api`. Menu link `stripe_api.admin` sits under **Configuration → Web services**
(`system.admin_config_services`). All values are written to the `stripe_api.settings` config object;
the form uses `#config_target`, so fields map straight to config keys.

## Config object — `stripe_api.settings`

| Key | Type | Form widget | Meaning / default |
|---|---|---|---|
| `mode` | string | radios `test` / `live` | Active mode. `getMode()` falls back to `'test'` when empty. Install default `test`. |
| `test_secret_key` | string | `key_select` | Key entity **id** holding the Stripe secret key (test). |
| `test_public_key` | string | `key_select` | Key entity id for the publishable key (test). |
| `live_secret_key` | string | `key_select` | Key entity id for the secret key (live). |
| `live_public_key` | string | `key_select` | Key entity id for the publishable key (live). |
| `api_version` | string | select `account` / `custom` | `account` = use the Stripe account default; `custom` = send `api_version_custom`. Default `account`. |
| `api_version_custom` | string | textfield (`YYYY-MM-DD`) | Pinned Stripe API version, only used/required when `api_version === 'custom'`. |
| `enable_webhooks` | boolean | checkbox | Master switch for the incoming webhook handler. Install default `TRUE`. |
| `test_webhook_signing_secret` | string | `key_select` | Key entity id for the endpoint signing secret (test). |
| `live_webhook_signing_secret` | string | `key_select` | Key entity id for the endpoint signing secret (live). |
| `log_webhooks` | boolean | checkbox | Log received/processed webhook events to the `stripe_api` channel. Install default `TRUE`. |

Config schema: `config/schema/stripe_api.schema.yml`. Install defaults: `config/install/stripe_api.settings.yml`.

## Keys are stored through the Key module

Every credential field is a Key `key_select`, so the config value is a Key entity **id**, not the secret
itself; `StripeApiService` resolves the id to a value via `key.repository`. Create the Key entities
first (recommended: Key's **env** provider reading an environment variable), then pick them here. This
keeps raw secrets out of `stripe_api.settings` and out of exported configuration.

## Webhook fields

- The **Webhook URL** field on the form is read-only and shows
  `Url::fromRoute('stripe_api.webhook', [], ['absolute' => TRUE])` (i.e. `https://<site>/stripe/webhook`).
  Register that URL as an endpoint in the Stripe Dashboard → Developers → Webhooks.
- Copy the endpoint's **signing secret** from Stripe into the matching `key_select`
  (`test_webhook_signing_secret` / `live_webhook_signing_secret`) — this is what the POST handler uses to
  verify each event (see [../api/service.md](../api/service.md)).
- **Environment override:** `getWebhookSigningSecret()` returns `getenv('STRIPE_WEBHOOK_SIGNING_SECRET')`
  first when that variable is set, before consulting config. Handy with the `dotenv` module.
- `enable_webhooks`, the signing-secret fields and `log_webhooks` are inside a "Webhooks" fieldset that
  is only visible (via `#states`) when **Accept incoming webhooks** is checked.

## Test the connection

When a secret key is resolvable (`getApiKey()` truthy), the form shows a **Test Stripe Connection**
button. Its AJAX callback `testStripeConnection()` calls `getStripeClient()->accounts->retrieve()` and
reports success (with the account display name) or an error (logged to the `stripe_api` channel).

## Set config from code / drush

```bash
drush config:set stripe_api.settings mode live -y
drush config:set stripe_api.settings enable_webhooks true -y
# Point a key field at an existing Key entity id:
drush config:set stripe_api.settings live_secret_key my_stripe_secret_key -y
```

While `mode` is `test`, `stripe_api_preprocess_page()` adds a site-wide warning message
("Stripe API is running in test mode.") on every page.
