# API — sending & queueing mail

Source: `simple_mail.module`, `src/Plugin/Mail/SimpleMail.php`,
`src/Plugin/QueueWorker/SimpleMailSendQueuedMail.php`.

## `simple_mail_send($from, $to, $subject, $body)`

Sends an HTML email immediately through `plugin.manager.mail`->`mail('simple_mail', 'simple_mail', …)`.

```php
simple_mail_send(
  'site@example.com',      // $from — empty string falls back to system.site 'mail'
  'user@example.com',      // $to
  'Welcome',               // $subject
  '<p>Hello <strong>there</strong></p>' // $body — HTML or plaintext
);
```

Returns the message array from the mail manager; check `$result['result'] === TRUE` to confirm PHP
accepted it. Langcode defaults to the site default language.

## `simple_mail_queue($from, $to, $subject, $body)`

Queues a message on the `simple_mail_queue` (Queue API) for cron delivery.

```php
$queued = simple_mail_queue('site@example.com', 'user@example.com', 'Digest', $html);
// Returns FALSE immediately if simple_mail.settings:queue_enabled is off.
// Returns TRUE after createItem() otherwise.
```

Same signature as `simple_mail_send`; use it for bulk/batch sends so the request isn't blocked.

## Queue worker

`SimpleMailSendQueuedMail` (`@QueueWorker id="simple_mail_queue"`, `cron = {"time" = 60}`) processes each
item by calling `simple_mail_send($item['from'], $item['to'], $item['subject'], $item['body'])` on cron
(up to ~60s per run).

## Notes

- `$body` is emitted as HTML (Content-Type set in `hook_mail`); the module does not sanitize it — the
  caller is responsible for the body content it passes.
- The global `override` setting (see [../configure/settings.md](../configure/settings.md)) still applies
  to messages sent by these functions.
