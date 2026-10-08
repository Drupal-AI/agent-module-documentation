<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Symfony Mailer Queue (symfony_mailer_queue) — agent index

Moves outbound Symfony Mailer email off the request onto a Drupal queue. You attach a
`queue_sending` email adjuster to a **mailer policy**; matching emails are pushed to the
`symfony_mailer_queue` queue and delivered later by a cron queue worker, with per-policy
retry/requeue behaviour.

- Requires contrib `symfony_mailer` (`drupal/symfony_mailer:^1.5`), core `^10.3 || ^11`.
- **No settings page / configure route of its own** — configured per policy under
  `symfony_mailer`'s Mailer UI (`/admin/config/system/mailer`, route `symfony_mailer.policy`).
- No permissions. No Drush commands. No new plugin *types* (it ships plugin *instances*:
  one EmailAdjuster + one QueueWorker). Config schema shipped.

## Solution docs
- **Queue a policy's mail + tune retries / cron** → [configure/queue-sending.md](configure/queue-sending.md)
- **How queueing works (factory decoration, worker, DTO, language)** → [api/queue-mechanism.md](api/queue-mechanism.md)
- **React to send failures / requeues** → [events/events.md](events/events.md)

## Key facts
- Queue name: `symfony_mailer_queue` (`SymfonyMailerQueueWorker::QUEUE_NAME`); worker
  `Plugin\QueueWorker\SymfonyMailerQueueWorker`, annotation `cron = {"time" = 60}`.
- Adjuster plugin id `queue_sending` (`Plugin\EmailAdjuster\QueueSendingEmailAdjuster`); its
  settings live inside the mailer policy config under `configuration.queue_sending`.
- Adjuster settings keys: `queue_behavior` (default `delayed`; values `delayed`/`requeue`/`suspend`),
  `requeue_delay` (default `60` s), `maximum_attempts` (default `5`), `send_wait_time` (default `0` s).
- Config schema: `symfony_mailer.email_adjuster_plugin.queue_sending`.
- Service override: `email_factory` is redefined in `symfony_mailer_queue.services.yml` to
  `Service\EmailFactory`, producing `QueueableEmail` (`QueueableEmailInterface`) objects.
- `SymfonyMailerQueueServiceProvider` registers `symfony_mailer_queue.static_language_negotiator`
  (only when the `language` module is enabled).
- Events: `Event\EmailSendFailureEvent`, `Event\EmailSendRequeueEvent` (each holds a readonly
  `SymfonyMailerQueueItem $item`).
- `hook_cron()` runs `garbageCollection()` on the queue to release delayed items.
- Deprecated `symfony_mailer_queue.settings` config object exists only for migration
  (`hook_update_10101` moves it into the adjuster); `hook_uninstall()` deletes it and strips the
  `queue_sending` adjuster from every `mailer_policy`.

```bash
drush en symfony_mailer symfony_mailer_queue -y
# Add the "Queue sending" adjuster to a policy in the Mailer UI, then:
drush queue:run symfony_mailer_queue
```
