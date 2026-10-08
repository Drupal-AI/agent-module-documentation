<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Graph Mail

Settings form: `\Drupal\graph_mail\Form\MailSettingsForm` at `/admin/config/services/graph_mail`
(route `graph_mail.mail_service.settings`, permission `administer graph mail configuration`).
All values persist to the `graph_mail.settings` config object (schema `graph_mail.schema.yml`).

## Config object `graph_mail.settings`

| Key | Type | Form field | Meaning |
|---|---|---|---|
| `tenant_id` | string (required) | Tenant ID | Azure directory (tenant) GUID used in the token URL. |
| `client_id` | string (required) | Client ID | App (client) ID from the Azure app registration. |
| `client_secret` | string (required) | Client secret | App secret (URL-encoded) for client-credentials. |
| `user_id` | string (required) | User ID | Mailbox object id / UPN that `sendMail` is called as. |
| `version` | string | API version | `v1.0` (default) or `beta`. Legacy value `1.0` is auto-corrected to `v1.0`. |
| `default_mail` | string | Default mail | From address; empty falls back to `system.site` mail. |
| `save_to_sent_items` | bool (default `false`) | Save to sent items | Whether Graph keeps a copy in Sent Items. |

Install defaults ship empty (`config/install/graph_mail.settings.yml`); the site operator enters
real credentials via the form. Set programmatically:

```php
\Drupal::configFactory()->getEditable('graph_mail.settings')
  ->set('tenant_id', '00000000-0000-0000-0000-000000000000')
  ->set('client_id', '...')->set('client_secret', '...')
  ->set('user_id', 'noreply@example.com')
  ->set('version', 'v1.0')->set('save_to_sent_items', FALSE)
  ->save();
```

## Azure side (prerequisite)

Register an app in Azure AD, add the **Mail.Send** *application* (not delegated) Graph
permission with admin consent, create a client secret. `sendMail` sends as `user_id`, so that
mailbox must be reachable by the app (optionally scoped with an Exchange application access policy).

## Selecting Graph Mail as the mail backend

The module registers the `graphmail` Mail plugin but does **not** force itself as the site
default. Choose it one of two ways:

- **Mailsystem module (recommended):** at `/admin/config/system/mailsystem` set *Graph Mail*
  as the default formatter/sender (globally or per module/key).
- **settings.php:** `$config['system.mail']['interface']['default'] = 'graphmail';`

## Retry queue

Failed sends that return HTTP 429 are queued to `graph_mail_retry_queue` (QueueWorker, `cron` time 30s)
and retried on cron once the `Retry-After` delay elapses (default 600s). Ensure cron runs.
Other send errors are logged to the `graph_mail` channel and the message is dropped (returns FALSE).
