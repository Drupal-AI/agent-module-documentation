# Configure Amazon SES

## Prerequisites

1. Configure the **`aws`** module with your AWS credentials + region (an `aws_profile`). This module
   reads the `sesv2` client from `aws.client_factory`; it does not store AWS keys itself.
2. Enable `amazon_ses`. A status-report error appears until a From address is set (`hook_requirements`).
3. Verify at least one sending identity (below) — SES only sends from verified addresses/domains.
4. Select Amazon SES as the mailer (below).

## Admin pages (all require `administer amazon ses`)

| Route | Path | Purpose |
|---|---|---|
| `amazon_ses.settings_form` | `/admin/config/system/amazon_ses/settings` | Main settings (below). |
| `amazon_ses.identities` | `…/settings/identities` | List verified identities + DKIM/verification status. |
| `amazon_ses.verify_identity` | `…/settings/verify-identity` | Verify a new email or domain identity (SES `CreateEmailIdentity`). |
| `amazon_ses.test_form` | `…/settings/test` | Send a test email. |
| `amazon_ses.statistics` | `…/settings/statistics` | Show 24h send quota / sent / max send rate. |

## Settings (`amazon_ses.settings`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `from_address` | email | — (required) | The verified address mail is sent from. |
| `from_name` | string | site name | Display name for the From header. |
| `override_from` | bool | FALSE | If TRUE, force `from_name`/`from_address` on every message, overriding the sending module. |
| `throttle` | bool | FALSE | Pace sends to stay under the SES rate limit. |
| `multiplier` | int | 1 | Throttle multiplier — set to your number of parallel PHP workers. |
| `queue` | bool | FALSE | Queue mail and send on cron (`amazon_ses_mail_queue`, cron time 60s) instead of immediately. |

Set via Drush:

```php
// drush php:eval
\Drupal::configFactory()->getEditable('amazon_ses.settings')
  ->set('from_address', 'noreply@example.com')
  ->set('from_name', 'Example')
  ->set('override_from', TRUE)
  ->set('queue', TRUE)
  ->save();
```

## Selecting SES as the mailer

- Simplest (all mail): set the `amazon_ses_mail` plugin as the default mail plugin, e.g. in
  `settings.php`: `$config['system.mail']['interface']['default'] = 'amazon_ses_mail';`
- Recommended (per module/key): install **Mail System** (`drupal/mailsystem`) and choose
  *Amazon SES mailer* for the formatter/sender globally or per module.

## Update hooks (migration)

`amazon_ses.install` includes `amazon_ses_update_3000x` routines that: install the `aws` module,
migrate legacy AWS Secrets Manager credentials into an `aws_profile` named `amazon_ses`, set the `sesv2`
service config, clear the old in-config `credentials`, default the throttle multiplier to 1, and set
`from_name`/`override_from` defaults. Run `drush updatedb` after upgrading from a 2.x/early-3.x release.
