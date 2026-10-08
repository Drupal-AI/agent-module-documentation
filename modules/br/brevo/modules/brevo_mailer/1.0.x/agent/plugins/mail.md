# Brevo Mailer — mail plugins, message building, queue

## `@Mail` plugins

| Plugin id | Class | Behaviour |
|---|---|---|
| `brevo_mail` | `BrevoMail` | Formats + builds the Brevo message; sends immediately, or queues if `use_queue` is on. |
| `brevo_queue_mail` | `BrevoQueueMail extends BrevoMail` | Always queues (ignores `use_queue`). |

Select them per Drupal mail key via the Mail System module.

## `format(array $message)` (`BrevoMail`)

1. Joins a body array into a string.
2. Detects HTML via `Content-Type: text/html` or `params['html']`.
3. For **non-HTML** bodies, if `format_filter` is set, runs `check_markup($body, $format, $langcode)`.
4. If `params['html'] === false`, returns early (no theme).
5. If `use_theme`, renders `#theme => params['theme'] ?? 'brevo'` in isolation.

## `buildMessage(array $message)` → Brevo array

Produces the array passed to `BrevoMailerHandler::sendMail()` → SDK `SendSmtpEmail` → `sendTransacEmail()`:

- `subject`, `htmlContent` (from body; removed if `params['html'] === false`).
- `sender` from `headers['From']` or `from`; `to` parsed from comma-separated string/array.
- `replyTo` from `reply-to` header, else falls back to sender.
- `cc` / `bcc` from `Cc`/`Bcc` headers or `params`.
- `"Name <email>"` forms are split into `{name, email}` (name truncated to 70 chars) for
  sender/replyTo/to/cc/bcc.
- `textContent` from `message['plain']` or auto-generated via `Html2Text`.
- Extra `headers` passed through except the standard ones (content-type, from, to, subject, cc, bcc,
  reply-to, mime-version).
- Allowed params copied through: `templateId`, `params`, `tags`, `scheduledAt`, `batchId`,
  `messageVersions`.
- `test_mode` → adds header `X-Sib-Sandbox: drop`.
- Attachments: for each `params['attachments']` entry, base64-encodes the file (from `filepath` if it
  exists, else `filecontent`+`filename`) into `attachment[]`.

## Handler service `brevo_mailer.mail_handler` (`BrevoMailerHandler`)

- `sendMail(array $brevoMessage)` — builds `SendSmtpEmail` and calls `sendTransacEmail()`; logs on
  debug/error; returns the SDK response or FALSE.
- `getRecipients()`, `validateDrupalMailerLibrary()`, `validateDrupalMailerConfiguration()`.

## Queue

`BrevoMail::queueMessage()` puts `{message: <brevo array>}` on the **`brevo_send_mail`** queue.
`CronSendMail` (`@QueueWorker id="brevo_send_mail"`, `cron time 10`, extends `SendMailBase`) drains it on
cron: `processItem()` calls `sendMail()` and **throws** on failure so the item is retried.
