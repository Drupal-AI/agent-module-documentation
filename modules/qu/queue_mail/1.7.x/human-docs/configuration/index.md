# Configuration

Queue Mail does nothing until you tell it **which mails to queue**. Everything is set on
one form and stored in the `queue_mail.settings` config object.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Queue Mail**
   (`/admin/config/system/queue_mail`).

The top of the form shows how many mails are currently queued and a link to run cron.
Below that is a table listing every module on your site that sends mail, together with
its mail‑ID prefix — a handy reference when deciding what to queue.

## Choosing which mails to queue

- **Mail IDs to queue** (`queue_mail_keys`, default empty) — a newline‑separated list
  of mail IDs. This is the one setting that actually switches queuing on. A mail ID is
  `{module}_{key}`, e.g. `user_password_reset` or
  `user_register_pending_approval_admin`. You can use wildcards:
  - `*` — queue **all** outgoing mail.
  - `user_*` — queue every mail from the User module.
  - `user_password_reset` — queue just that one message.

  List one pattern per line; anything not matched keeps sending inline as usual.

## Timing and retry options

These advanced settings tune how the cron worker behaves. The defaults are sensible;
change them only if you need to.

- **Queue processing time (max)** (`queue_mail_queue_time`, default `15`) — the maximum
  number of seconds cron spends sending queued mail on each run.
- **Retry threshold** (`threshold`, default `50`) — how many times a failing message is
  retried before it is dropped and logged. `0` means never retry; leave empty for
  unlimited attempts.
- **Requeue interval** (`requeue_interval`, default `10800` = 3 hours) — how long to
  wait before retrying a message that failed to send.
- **Wait time between items** (`queue_mail_queue_wait_time`, default `0`) — seconds to
  pause between sending each queued message, to throttle delivery. Must be no larger
  than the processing‑time setting above.

Click **Save configuration** to apply.

## Setting values from the command line

```bash
drush config:get queue_mail.settings

# Queue everything:
drush config:set queue_mail.settings queue_mail_keys '*' -y
```

For a multi‑line value (several patterns), set it in PHP:

```php
\Drupal::configFactory()->getEditable('queue_mail.settings')
  ->set('queue_mail_keys', "user_*\ncommerce_*")   // newline-separated
  ->save();
```

## Sending the queued mail

Queued messages go out on **cron**, so make sure cron runs regularly. To flush the
queue immediately:

```bash
drush queue:run queue_mail --time-limit=15
```

Always include `--time-limit`, since failed sends are re‑queued and an unbounded run
may not finish. The current queue length also appears on the site's status report
(**Reports → Status report**).

## A note for developers

Code that sends mail can check `$message['queued']` on the returned message array to
tell whether Queue Mail deferred it (`TRUE`) or it was sent inline (absent/`FALSE`). To
make a last‑moment decision right before a queued mail is sent — appending a footer,
cancelling delivery — implement `hook_queue_mail_send_alter()`; see the
[`agent/`](../agent/hooks/queue-mail-send-alter.md) docs.
