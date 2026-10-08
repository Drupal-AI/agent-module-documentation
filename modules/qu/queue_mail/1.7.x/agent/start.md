<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Queue Mail — agent index

Defers outgoing site email for the mail IDs you nominate to a **cron-processed queue**
(`queue_mail`), instead of sending inline during the request. Does nothing until you set
which mail IDs to queue.

- **Settings form + `queue_mail.settings` config keys** →
  [configure/settings.md](configure/settings.md)
- **How queuing/sending works (hooks, worker, cron, retries, `$message['queued']`, drush)** →
  [api/mechanism.md](api/mechanism.md)
- **`hook_queue_mail_send_alter()` — alter a queued mail just before it is sent** →
  [hooks/queue-mail-send-alter.md](hooks/queue-mail-send-alter.md)

Submodule: **queue_mail_language** (nested) — sends queued mail in each mail's own language.

Key facts:
- Configure route `queue_mail.admin_settings` at `/admin/config/system/queue_mail`
  (`info.yml` `configure: queue_mail.admin_settings`), permission `administer site configuration`.
- Config `queue_mail.settings`: `queue_mail_keys` (newline list, `*`/`user_*` wildcards),
  `queue_mail_queue_time` (15), `threshold` (50), `requeue_interval` (10800),
  `queue_mail_queue_wait_time` (0).
- Queue id `queue_mail` (reliable); worker `SendMailQueueWorker` (`@QueueWorker` id `queue_mail`).
- Process with core `drush queue:run queue_mail --time-limit=15`.
