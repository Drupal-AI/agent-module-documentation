<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mail handler service, plugins & send queue

## Service `sendgrid.mail_handler`

`Drupal\sendgrid\SendgridHandler` implements `Drupal\sendgrid\SendgridHandlerInterface`.

```php
$handler = \Drupal::service('sendgrid.mail_handler');
$ok = $handler->sendMail($sendgrid_message); // bool
```

`sendMail(array $message): bool` builds a `SendGrid\Mail\Mail`, instantiates the SendGrid client with
the resolved API key, dispatches the `sendgrid.send` event (see [events/send.md](../events/send.md)),
then calls the API. Returns TRUE only when the API responds with a 2xx status; otherwise it logs to
channel `sendgrid` and returns FALSE. Constant `SendgridHandlerInterface::CONFIG_NAME` =
`'sendgrid.settings'`.

### `$message` array consumed by `sendMail()`

| Key | Type | Notes |
|---|---|---|
| `from_email` | string | Required (with `to`), else logs and returns FALSE. |
| `from_name` | string | Sender display name. |
| `to` | string[] | Filtered through `email.validator`; if none valid, logs and returns FALSE. |
| `subject` | string | |
| `text` | string | Added as `text/plain` content. |
| `html` | string | Added as `text/html` content. |
| `cc` / `bcc` | string[] | Added as recipients. |
| `reply-to` | string | |
| `headers` | array | Each `key => value` added via `addHeader()`. |
| `attachments` | array[] | Items with `filecontent` (+ `filemime`, `filename`) become `SendGrid\Mail\Attachment` (base64/content id auto-set). |

You normally do not build this array by hand — the Mail plugins do it in `buildMessage()` from a
standard Drupal `$message`.

## Mail plugins (core `@Mail`)

| Plugin id | Class | Behavior |
|---|---|---|
| `sendgrid_mail` | `Plugin\Mail\SendgridMail` | `mail()` builds the message and calls `sendgrid.mail_handler->sendMail()` synchronously. |
| `sendgrid_queue_mail` | `Plugin\Mail\SendgridQueueMail` (extends `SendgridMail`) | `mail()` builds the message and enqueues it (`queueMessage()`) into queue `sendgrid_send_mail`; returns TRUE if queued. |

`SendgridMail::format()` joins the body, optionally runs `check_markup` with `format_filter`, and
optionally wraps the body via the theme (see [theme/theme.md](../theme/theme.md)). `buildMessage()`
sets `from_email` from `system.site` mail, converts HTML to text with `html2text/html2text` when no
plain part is given, maps `Cc`/`Bcc`/`Reply-To` headers, forwards any `X-*` headers, and reads
attachments from `params['attachments']` (`filecontent`, or `filepath` read from disk with a guessed
MIME type). Select the plugin through the `mailsystem` module.

## Send queue & cron worker

- Queue name: `sendgrid_send_mail` (filled by `sendgrid_queue_mail`).
- QueueWorker plugin `sendgrid_send_mail` — `Plugin\QueueWorker\CronSendMail` extends
  `SendMailBase`; annotation `cron = {"time" = 10}`, so it drains on cron for up to 10s/run.
- `SendMailBase::processItem()` calls `sendgrid.mail_handler->sendMail($data->message)`; on failure it
  throws `\Exception('Sendgrid: email did not pass through API.')` so the item is retried.
- Process on demand: `drush queue:run sendgrid_send_mail`. The `queue_ui` module is recommended for a
  UI over this queue.
