<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MailgunHandler service API

Service id: **`mailgun.mail_handler`** (`Drupal\mailgun\MailgunHandler`,
interface `MailgunHandlerInterface`). It wraps the `mailgun.mailgun_client` (a
`Mailgun\Mailgun` instance built by `MailgunFactory` from `mailgun.settings`).

```php
$handler = \Drupal::service('mailgun.mail_handler');
```

## Methods (`MailgunHandlerInterface`)

| Method | Purpose |
|---|---|
| `sendMail(array $mailgunMessage)` | Send a fully-built Mailgun message array via the API; returns success/response. |
| `getDomains()` | List the Mailgun domains available for the configured API key. |
| `getDomain($from)` | Resolve the working/sending domain for a given From address (honors `working_domain`, `_sender`). |
| `moduleStatus($showMessage = FALSE)` | Whether the module is correctly configured/ready to send. |
| `validateMailgunApiKey($key)` | Validate an API key against Mailgun. |
| `validateMailgunApiSettings($showMessage = FALSE)` | Validate the configured API settings. |
| `validateMailgunLibrary($showMessage = FALSE)` | Check the `mailgun/mailgun-php` library is present. |

## Related services

- `mailgun.mailgun_client_factory` (`MailgunFactory`) — `create()` builds the
  `Mailgun\Mailgun` client from `mailgun.settings` (api_key, api_endpoint).
- `mailgun.mailgun_client` — the shared `Mailgun\Mailgun` client instance.
- `logger.channel.mailgun` — logger channel used for `debug_mode` output.

Normally you don't call `sendMail()` directly — you route mail through Mailsystem so Drupal's
`MailManager` invokes the `mailgun_mail` / `mailgun_queue_mail` plugin, which uses this handler.
Use the `validate*`/`getDomains` methods for building setup/health checks.
