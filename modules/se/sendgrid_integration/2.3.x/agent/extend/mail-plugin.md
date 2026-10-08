# The SendGrid Mail plugin & sending programmatically

## Plugin

`Drupal\sendgrid_integration\Plugin\Mail\SendGridMail` — a `@Mail` plugin
(`id = "sendgrid_integration"`) implementing `MailInterface`. You select it as a mail system via
the Mailsystem module; you rarely instantiate it directly. It reads config from
`sendgrid_integration.settings` and `system.site` (for default From address + name → SendGrid
categories). No plugin *type* is defined by this module.

## Sending mail — standard Drupal API

Send through the normal mail manager; whichever module/key you use must be mapped to the
`sendgrid_integration` plugin in Mailsystem:

```php
\Drupal::service('plugin.manager.mail')
  ->mail('my_module', 'my_key', 'to@example.com', 'en', $params, $reply = NULL, $send = TRUE);
```

## Message-array keys the plugin understands

Set these on `$message` (e.g. in `hook_mail()` or a mail plugin `format()`), or as `$params`:

| Key | Effect |
|---|---|
| `$message['headers']['From']` | From address/name (`"Name" <addr>` parsed); falls back to `system.site` mail + name |
| `$message['headers']['Reply-To']` | Reply-To (also settable via `$params['Reply-To']` or `$params['reply_to']`) |
| `$message['headers']['Cc']` / `['Bcc']` | Comma-separated Cc / Bcc recipients |
| `$message['to']` | To; comma-separated string is exploded into multiple recipients |
| `$message['headers']['Content-Type']` | Drives body handling: `text/plain`, `text/html`, `multipart/alternative`, `multipart/mixed` |
| `$message['attachments'][]` | Absolute file paths to attach |
| `$message['params']['attachments'][]` | Mimemail-style attachments (`filepath`+`filename`, or `filecontent`+`filename`+`filemime`) |
| `$message['params']['apikey']` | Override the configured API key for this one message |
| `$message['params']['account']` | If a user entity, its `uid` is added as a SendGrid custom arg |
| `$message['sendgrid']['template_id']` | Send using a SendGrid dynamic/transactional template |
| `$message['sendgrid']['substitutions']` | Key/value substitutions applied to the template |

HTML bodies automatically get a plain-text alternative generated with `Html2Text`. Attachment MIME
types are restricted to image/*, text/*, application/pdf, application/x-zip, application/xml
(extend via `hook_sendgrid_integration_valid_attachment_types_alter()`).

## Categories, tracking, spam

Every message is tagged with SendGrid categories `[site name, module, message id]`. Click/open
tracking follow `trackclicks` / `trackopens` config. Messages whose `id` contains `password` or
`commerce` bypass SendGrid spam checking.

## Failure handling — resend queue

On a SendGrid exception with code in `[-110, 404, 408, 500, 502, 503, 504]` the message is queued to
`SendGridResendQueue` (`Plugin/QueueWorker/SendGridQueue`, `cron = {"time" = 60}`), which re-invokes
`MailManager::mail()` on the next cron run. Other errors are logged and the send returns FALSE.
