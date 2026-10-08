<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How Queue Mail defers and sends

## Queuing (during the request)

`queue_mail_mail_alter(&$message)` (in `.module`) runs on every outgoing mail, forced to run
**last** among `hook_mail_alter` implementations (`hook_module_implements_alter`). It:

1. Sets `$message['queued'] = FALSE` and returns early if `$message['send']` is already empty.
2. Matches `$message['id']` against `queue_mail.settings:queue_mail_keys` using
   `\Drupal::service('path.matcher')->matchPath()` — so `*` / `user_*` wildcards work.
3. On a match: records the active theme on `$message['theme']`, pushes the message onto the
   `queue_mail` **reliable** queue (`\Drupal::queue('queue_mail', TRUE)`), sets
   `$message['queued'] = TRUE`, and sets `$message['send'] = FALSE` so core does not send it
   inline.

So calling code can inspect the outcome:

```php
$message = \Drupal::service('plugin.manager.mail')->mail($module, $key, $to, $langcode, $params);
if (!empty($message['queued'])) {
  // Deferred to the queue.
} else {
  // Sent inline as usual.
}
```

## Sending (on cron)

Worker `SendMailQueueWorker` — `@QueueWorker(id = "queue_mail", cron = {"time" = 60})`;
`queue_mail_queue_info_alter()` overrides that cron time with `queue_mail_queue_time`.
`processItem($message)`:

- Skips (throws `DelayedRequeueException`) if a previous `last_attempt` is within
  `requeue_interval`.
- Invokes `hook_queue_mail_send_alter($message)` (see
  [../hooks/queue-mail-send-alter.md](../hooks/queue-mail-send-alter.md)); if a hook clears
  `send`, sets `result = NULL` and stops.
- Restores the saved theme, formats the body, ensures a plain-text subject, and sends via
  `MailManagerInterface::mail()`.
- On failure: logs it and calls `processRetryLimit()` — increments `fail_count`, and re-queues
  with a new `last_attempt` unless `fail_count >= threshold` (then drops + logs).
- `queue_mail_queue_wait_time` sleeps between items.

## Processing manually

Core Drush (the module adds no command of its own):

```bash
drush queue:run queue_mail --time-limit=15
```

The README stresses using `--time-limit` because failed sends are re-queued, so without a
limit the run may not terminate.

## Install/uninstall

`hook_install` creates the `queue_mail` queue; `hook_uninstall` deletes it.
`hook_requirements` (runtime) reports the current queue length on the status report.
