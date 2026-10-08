# Configure SendGrid Integration

## Routes / permission

| Route | Path | Purpose |
|---|---|---|
| `sendgrid_integration.settings_form` | `/admin/config/services/sendgrid` | Settings form (API key, tracking, test defaults) |
| `sendgrid_integration.test_form` | `/admin/config/services/sendgrid/test` | Send a test email |

Both require the `administer sendgrid settings` permission.

## Config object — `sendgrid_integration.settings`

Schema: `config/schema/sendgrid_integration.schema.yml`. Keys:

| Key | Type | Meaning |
|---|---|---|
| `apikey` | string | SendGrid API secret **or** the machine id of a Key entity (see below) |
| `trackopens` | integer | Enable SendGrid open tracking (truthy = on) |
| `trackclicks` | integer | Enable SendGrid click tracking (truthy = on) |
| `test_defaults` | mapping | Prefill values for the test form (`to`, `subject`, `body.value`, `body.format`, `from_name`, `to_name`, `reply_to`) |

`drush cset sendgrid_integration.settings apikey <value>`; exports/deploys as normal config.

## Setting the API key

Three supported ways (resolved in `SendGridMail::doMail()`):

1. **Plain config** (no Key module): paste the SendGrid secret into the "API Secret Key" field;
   it is stored raw in `apikey`.
2. **Key module** (if `key` is enabled): create a Key (type *Authentication*, provider
   *Configuration* or *Environment*), then select it in the settings form. The `apikey` value is
   then a Key **id**; the plugin resolves it via `\Drupal::service('key.repository')->getKey()`.
   When the Key module is enabled you *must* use a Key — the raw-value path is skipped.
3. **settings.php** (keep secret out of the repo): with plain config,
   `$config['sendgrid_integration.settings']['apikey'] = 'THEAPIKEY';`
   With the Key module,
   `$config['key.key.MYKEY']['key_provider_settings']['key_value'] = 'THEAPIKEY';`

## Activating SendGrid as the mail system (Mailsystem)

This module only *provides* the `sendgrid_integration` Mail plugin — it does not auto-hijack mail.
Use the required **Mailsystem** module (`/admin/config/system/mailsystem`) to select
**Sendgrid Integration** as the system-wide default formatter/sender, or per-module. To send HTML,
set the *formatter* to Mimemail (the plugin's own `format()` only concatenates body parts).

## Test send

`/admin/config/services/sendgrid/test` sends a trial message (key
`sengrid_integration_troubleshooting_test`) using the configured key; success is logged at info level.
