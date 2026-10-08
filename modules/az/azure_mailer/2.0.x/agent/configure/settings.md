# Configure Azure Mailer

Two settings live in the `azure_mailer.settings` config object (default-installed empty by
`config/install/azure_mailer.settings.yml`):

| Key | Set where | Notes |
|---|---|---|
| `endpoint` | Admin form **or** `settings.php` | ACS host only, no scheme — e.g. `yoursite.communication.azure.com`. The plugin prepends `https://` and appends `/emails:send?api-version=2023-03-31`. |
| `secret` | `settings.php` / Drush **only** | ACS access key used for HMAC signing. The admin form field is `#disabled` and its `#default_value` is blank, so it is never editable or shown in the UI. |

There is **no config schema** for this module.

## 1. Endpoint (UI)

Go to `/admin/config/config/azure_mailer` (route `azure_mailer.config`, permission
`administer site configuration`), enter the ACS endpoint host, and save
(`AzureMailerSettingsForm`). The submit handler also writes `secret` from the form value, but
since that field is disabled the effective secret comes from your `settings.php` override.

## 2. Secret (out-of-band, recommended)

Set the secret (and optionally the endpoint) in `settings.php` so it stays out of the UI and
config export — pull it from the environment:

```php
$config['azure_mailer.settings']['secret']   = getenv('AZURE_COMM_SECRET');
$config['azure_mailer.settings']['endpoint'] = getenv('AZURE_COMM_ENDPOINT');
```

Or set it once with Drush:

```bash
drush config:set azure_mailer.settings secret '<acs-access-key>' -y
```

## 3. Make it the active mailer (Mailsystem)

Azure Mailer only sends when Drupal's mail system routes to it. Install/enable
`drupal/mailsystem` (a hard dependency) and at `/admin/config/system/mailsystem` set the
**Formatter** and/or **Sender** to *Azure Communication Service* — site-wide, or per module/key.
Nothing is sent through ACS until this is done.

## Verify

```bash
drush config:get azure_mailer.settings          # endpoint present; secret comes from settings.php
```

Send a test mail (e.g. trigger a password reset) and watch for a Drupal error message — a
Guzzle/transport failure is reported via the messenger and `mail()` returns FALSE.
