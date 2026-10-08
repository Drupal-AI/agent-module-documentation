<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mailgun Mail plugins & queue worker

Mailgun provides Mail plugins (core `@Mail` plugin type — you *select* them via Mailsystem, you
don't normally implement new ones). No custom plugin type is defined by this module.

## Mail plugins

| Plugin id | Class | Behavior |
|---|---|---|
| `mailgun_mail` | `Plugin/Mail/MailgunMail` | Builds the Mailgun message and sends it immediately via the API on `mail()`. |
| `mailgun_queue_mail` | `Plugin/Mail/MailgunQueueMail` | Builds the message and **enqueues** it (`queueMessage()`) into the `mailgun_send_mail` queue instead of sending inline. |

Both are chosen through Mailsystem as sender/formatter (see
[../configure/settings.md](../configure/settings.md)). `mailgun_queue_mail` is the plugin to use
when `use_queue`-style background delivery is wanted.

## Cron queue worker

- `@QueueWorker(id = "mailgun_send_mail", cron = {time = 10})` —
  `Plugin/QueueWorker/CronSendMail` (extends `SendMailBase`).
- On each cron run it processes up to ~10 seconds of queued Mailgun messages and sends them via
  the `MailgunHandler`. Run manually with `drush queue:run mailgun_send_mail` or `drush cron`.

## Message building

Both plugins share `SendMailBase`/`MailgunMail` logic that maps the Drupal `$message` array into
a Mailgun message (from/to/subject/body, tracking, tags, working domain) using the settings in
`mailgun.settings`, then hands it to `MailgunHandler::sendMail()` (immediate) or the queue
(deferred). See [../api/handler.md](../api/handler.md).
