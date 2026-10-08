# Amazon SES services & API

## Mail plugin — `amazon_ses_mail` (`src/Plugin/Mail/AmazonSes.php`)

Extends core `PhpMail`. `mail(array $message)`:
1. If `override_from` is set (or `$message['from']` is missing), sets From to `"<from_name> <from_address>"`.
2. `MessageBuilder::buildMessage($message)` → a Symfony Mime `Email`.
3. If `queue` config is on, `createItem($email)` on queue `amazon_ses_mail_queue`; else
   `AmazonSesHandler::send($email)` immediately. Returns bool success.

## `amazon_ses.message_builder` — `MessageBuilder`

`buildMessage(array $message): Symfony\Component\Mime\Email`:
- Splits `to` on `,`/`;`; parses `from` into name+address (`"Name <addr>"`).
- Adds `reply-to` when the `reply-to` key is present.
- Reads `headers['Content-Type']` to choose body handling:
  - `text/plain` → `->text($body)`; `text/html` → `->html($body)`;
  - `multipart/mixed` → parses the multipart/alternative boundary and sets both text + html parts;
  - unknown → falls back to `->text()` and logs a warning.
- Cc/Bcc parsed from `headers['Cc']` / `headers['Bcc']` (array or delimited string).
- Attachments from `$message['params']['attachments']` (`filepath` or `filecontent`, with
  `filename`/`filemime`; mime guessed when absent).

## `amazon_ses.handler` — `AmazonSesHandler`

Wraps the AWS `sesv2` client (from `aws.client_factory`). Interface `AmazonSesHandlerInterface`:

| Method | Does |
|---|---|
| `send(Email $email)` | SES `sendEmail` with `Content.Raw.Data = $email->toString()`; dispatches `MailSentEvent`; optional `usleep()` throttle; returns MessageId or FALSE (logs `CredentialsException`/`SesV2Exception`). |
| `getIdentities()` | `ListEmailIdentities` + per-identity `GetEmailIdentity` → array with status/type/DKIM. |
| `verifyIdentity($identity)` | `CreateEmailIdentity`. |
| `deleteIdentity($identity)` | `DeleteEmailIdentity`. |
| `getSendQuota()` | `GetAccount` → `SendQuota` (Max24HourSend, SentLast24Hours, MaxSendRate). |
| `verifyClient()` | Whether the SES client initialized. |

Throttle pacing: `getSleepTime()` = `ceil((1_000_000 * multiplier) / MaxSendRate)` microseconds.

## Queue worker — `amazon_ses_mail_queue`

`src/Plugin/QueueWorker/AmazonSesMailQueue.php`, `cron = {time: 60}`. `processItem($email)` calls
`AmazonSesHandler::send($email)`. Enqueued only when the `queue` setting is on; `amazon_ses.module`'s
`hook_queue_info_alter` removes the cron processor when queueing is disabled.

## Event — `MailSentEvent` (`amazon_ses.mail_sent`)

Dispatched after each successful send. `getMessageId()` (SES MessageId) and `getEmail()` (the Symfony
`Email`). Subscribe to log deliveries, store message IDs, or trigger follow-up actions:

```php
public static function getSubscribedEvents(): array {
  return [\Drupal\amazon_ses\Event\MailSentEvent::SENT => 'onSent'];
}
```
