<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `hook_queue_mail_send_alter()`

Declared in `queue_mail.api.php`. Invoked by `SendMailQueueWorker::processItem()` (via
`$moduleHandler->alter('queue_mail_send', $message)`) **when a queued mail is dequeued and
about to be sent** — i.e. potentially long after the original `hook_mail_alter()` ran. Use it
for anything that must happen at true send time.

```php
/**
 * Implements hook_queue_mail_send_alter().
 */
function mymodule_queue_mail_send_alter(array &$message) {
  if ($message['id'] == 'modulename_messagekey') {
    if (!example_notifications_optin($message['to'], $message['id'])) {
      // Cancel sending this queued mail.
      $message['send'] = FALSE;
      return;
    }
    $message['body'][] = "--\nMail sent out from " . \Drupal::config('system.site')->get('name');
  }
}
```

- `$message` has the usual mail keys: `id`, `to`, `from`, `subject`, `body` (array),
  `headers`, `params`, `language`, `send`, plus queue_mail's `theme` / retry bookkeeping.
- **Set `$message['send'] = FALSE` to abort** sending this queued item (the worker then sets
  `result = NULL` and does not send).
- It is largely equivalent to `hook_mail_alter()` but fires at dequeue/send time, so it is the
  place to make last-moment decisions (opt-out checks, appending footers, re-checking state).

There are no other module-specific hooks.
