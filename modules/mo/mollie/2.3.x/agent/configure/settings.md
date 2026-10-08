# Configure Mollie for Drupal

## Credentials (settings.php, not the UI)

API credentials are **not** editable in the admin UI or stored in config. Add them to
`settings.php` under `$settings['mollie.settings']`; the module reads them with
`\Drupal\Core\Site\Settings::get('mollie.settings')`:

```php
$settings['mollie.settings'] = [
  'live_key' => 'live_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
  'test_key' => 'test_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', // optional
  'access_token' => 'org_access_token',                // optional, not yet used by features
];
```

You may populate these from environment variables in `settings.php`, e.g.
`'live_key' => getenv('MOLLIE_LIVE_KEY')`. At least a `live_key` is required to take real payments.

`Drupal\mollie\MollieConfigValidator` (service `mollie.config_validator`) reports which are set:
`hasLiveApiKey()`, `hasTestApiKey()`, `hasOrganisationAccessToken()`. `hook_requirements`
(`mollie.install`) surfaces the Mollie API client version plus live/test-key presence on the
status report.

## Settings form

- Route: `mollie.configuration` → `/admin/config/services/mollie` (form
  `Drupal\mollie\Form\MollieConfigForm`, permission `administer mollie`).
- The form only shows a read-only checklist of which credentials are present plus the settings.php
  snippet. The `test_mode` checkbox and `webhook_base_url` field render **only when a `test_key`
  is configured**.

## Config object `mollie.config`

| Key | Type | Default | Meaning |
|---|---|---|---|
| `test_mode` | boolean | `false` | Use the Mollie **test** API key instead of the live key. |
| `webhook_base_url` | string | *(unset)* | Test-mode only: base URL Mollie should call for webhooks (e.g. an ngrok tunnel) when the site is not publicly reachable. Empty → use the site's own domain. |

Test mode is only effective when a test key exists:
`Mollie::useTestMode()` = `hasTestApiKey()` **and** `mollie.config:test_mode`. The
`mollie.mollie` service then calls `MollieApiClient::setApiKey()` with the `test_key`, otherwise the
`live_key`.

Set via Drush / PHP:

```php
\Drupal::configFactory()->getEditable('mollie.config')
  ->set('test_mode', TRUE)
  ->set('webhook_base_url', 'https://your-tunnel.ngrok.io')
  ->save();
```

```bash
drush config:set mollie.config test_mode true
```

Schema: `config/schema/mollie.schema.yml` defines `mollie.config` with `test_mode` and
`webhook_base_url`. Install default (`config/install/mollie.config.yml`): `test_mode: false`.
When set, `webhook_base_url` rewrites the base of the redirect/webhook URLs sent to Mollie so a
non-public dev site can still receive callbacks.
