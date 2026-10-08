<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Async queue + sparkpost_requeue submodule

## Async sending (main module)

The QueueWorker `Drupal\sparkpost\Plugin\QueueWorker\SparkpostSend` (`@QueueWorker` id
`sparkpost_send`, cron time 60s) drains the `sparkpost_send` queue. When `async` is enabled the
Mail plugin serialises a `MessageWrapper` into that queue instead of sending inline; the worker
calls `$wrapper->sendMessage()` per item. `skip_cron` config removes the queue from cron
(`sparkpost_queue_info_alter`) so you run it yourself: `drush queue:run sparkpost_send`.

## sparkpost_requeue

Submodule (`modules/sparkpost_requeue`, package Sparkpost, depends on `sparkpost:sparkpost`).
Automatically retries failed sends. Config form at `/admin/config/services/sparkpost_requeue`
(route `sparkpost_requeue.settings_form`, permission **`administer sparkpost`**, `_admin_route`).

Config object `sparkpost_requeue.settings`:

| Key | Default | Meaning |
| --- | --- | --- |
| `enable` | `false` | Master on/off. When off the hook returns immediately. |
| `max_retries` | `10` | After this many requeues the message is logged and discarded. |
| `minimum_time` | `300` | Minimum seconds between attempts; if too soon the hook throws `Exception('Too soon to retry')`, keeping the item in the queue. |

### How it works

`sparkpost_requeue_sparkpost_mailsend_error()` implements `hook_sparkpost_mailsend_error()`, which
`MessageWrapper::sendMessage()` fires whenever a send fails. It:

1. Wraps the failed `MessageWrapper` in a `QueuedMessageWrapper` (subclass that tracks
   `retryCount` and `lastRetry`) if it is not already one.
2. Discards (logs) the message once `getRetryCount() >= max_retries`.
3. Throws if `time() - lastRetry < minimum_time` (defers the retry).
4. Otherwise increments the retry count, stamps `lastRetry`, clears the (non-serialisable)
   `SparkPostException`, and re-adds the wrapper to the `sparkpost_send` queue.

This is a purely internal error-handling loop over Drupal's own queue — **not** an inbound
webhook and not driven by any SparkPost callback. It reacts only to local send failures.
