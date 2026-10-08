<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure queueing (queue_sending adjuster)

The module adds **no settings page of its own**. Queueing is a per-policy decision: attach the
**Queue sending** email adjuster (plugin id `queue_sending`) to any `symfony_mailer` mailer
policy. Every email that resolves to that policy is queued instead of sent inline.

- UI: `/admin/config/system/mailer` (route `symfony_mailer.policy`) → edit a policy → add the
  *Queue sending* adjuster.
- Class: `Plugin\EmailAdjuster\QueueSendingEmailAdjuster` (extends `symfony_mailer`'s
  `EmailAdjusterBase`), `@EmailAdjuster(id = "queue_sending", weight = 0)`.
- Settings storage: inside the policy entity's `configuration.queue_sending` map (NOT a
  standalone config object). Schema: `symfony_mailer.email_adjuster_plugin.queue_sending`
  (base type `symfony_mailer.address_adjuster_base`).

## Settings

| Key | Form title | Type | Default | Meaning |
|---|---|---|---|---|
| `queue_behavior` | Queue Behavior | select | `delayed` | Retry strategy on failure — `delayed` / `requeue` / `suspend` (see below). |
| `requeue_delay` | Requeue delay | int (seconds) | `60` | Wait before a failed item is retried. Only used (and shown/required) when `queue_behavior = delayed`. |
| `maximum_attempts` | Maximum attempts | int | `5` | Retry cap; once exceeded the item is dropped and an `EmailSendFailureEvent` is dispatched. |
| `send_wait_time` | Wait time per item | int (seconds) | `0` | `sleep()` after each successful send, to throttle throughput. |

## Queue behaviors (on delivery failure)

- **`delayed`** (default) — throws `DelayedRequeueException($requeue_delay)`. The item only
  becomes available again after `requeue_delay` seconds or once its lease expires. Requires a
  queue implementing `DelayableQueueInterface` (Drupal's DB queue qualifies). For backends
  without delay support a default 1-minute lease applies. Cron garbage collection must run to
  release items (see below).
- **`requeue`** (Immediate requeue) — throws `RequeueException`; the item is available again
  right away and may be retried within the same queue run.
- **`suspend`** (Suspend queue) — throws `SuspendQueueException`; the failed item is released and
  processing of the remaining items is deferred to the next queue run.

## Runtime / operations

- Queue name: `symfony_mailer_queue`. Process it with cron or `drush queue:run symfony_mailer_queue`.
- The worker (`SymfonyMailerQueueWorker`, cron `time = 60`) is picked up by Drupal's core cron
  queue runner automatically.
- `symfony_mailer_queue_cron()` calls `garbageCollection()` on the queue (when it implements
  `QueueGarbageCollectionInterface`) to reset expiry on delayed items. For frequent delayed
  retries, schedule cron more often than `requeue_delay` — the README recommends **Ultimate Cron**
  with two jobs: the module's default cron handler (garbage collection) and the queue itself.
- Retry counters are kept in expirable key-value storage `keyvalue.expirable` collection
  `symfony_mailer_queue`, keyed by `md5(serialize($item))`, TTL 86400 s.

## Set the adjuster on a policy via PHP

```php
/** @var \Drupal\symfony_mailer\Entity\MailerPolicy $policy */
$policy = \Drupal::entityTypeManager()->getStorage('mailer_policy')->load('user.password_reset');
$config = $policy->getConfiguration();
$config['queue_sending'] = [
  'queue_behavior' => 'delayed',
  'requeue_delay' => 60,
  'maximum_attempts' => 5,
  'send_wait_time' => 0,
];
$policy->setConfiguration($config);
$policy->save();
```

## Deprecated module-level settings

The `symfony_mailer_queue.settings` config object (keys `maximum_attempts`, `requeue_delay`,
`send_wait_time`) is **deprecated for removal**; its schema is retained only so that
`symfony_mailer_queue_update_10101()` can copy those values into each policy's `queue_sending`
adjuster and then delete the object. Configure the adjuster per policy instead.
`hook_uninstall()` deletes the settings object and removes `queue_sending` from every mailer
policy.
