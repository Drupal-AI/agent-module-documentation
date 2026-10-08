<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Queue Mail settings

Config object **`queue_mail.settings`**. Form route `queue_mail.admin_settings` at
`/admin/config/system/queue_mail` (`QueueMailSettingsForm`), permission
`administer site configuration`. **The module queues nothing until `queue_mail_keys` is set.**

## Keys (with shipped defaults)

| Key | Default | Meaning |
|---|---|---|
| `queue_mail_keys` | `''` | Newline-separated list of mail IDs to queue. Wildcards via `path.matcher`: `*` = all mail, `user_*` = all User-module mail, or an exact id like `user_password_reset`. |
| `queue_mail_queue_time` | `15` | Max seconds cron spends sending queued mail (overrides the worker's `cron.time`). |
| `threshold` | `50` | Retry threshold: max send attempts before an item is dropped and logged. `0` = never retry; empty = unlimited. |
| `requeue_interval` | `10800` | Seconds to wait before retrying a failed mail (3 hours). |
| `queue_mail_queue_wait_time` | `0` | Seconds to sleep between processing each item (must be ≤ `queue_mail_queue_time`). |

## Mail IDs

A mail ID is `"{module}_{key}"` — the first two args to `MailManagerInterface::mail()`. E.g.
`user_password_reset`, `user_register_pending_approval_admin`. The settings form lists every
module that implements `hook_mail` with its `{module}_*` prefix to help you choose.

## Set / read via drush

```bash
drush config:get queue_mail.settings
# queue everything:
drush config:set queue_mail.settings queue_mail_keys '*' -y
# queue all user mails (multiline value in PHP):
```

```php
\Drupal::configFactory()->getEditable('queue_mail.settings')
  ->set('queue_mail_keys', "user_*\ncommerce_*")   // newline-separated
  ->save();
```

The settings form also shows the current queue length ("N mails currently queued") and a link
to run cron; the same info appears on the status report (`hook_requirements`).
