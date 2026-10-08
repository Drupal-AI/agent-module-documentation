<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Queue Mail intercepts outgoing site email and, for the mail IDs you nominate, defers sending to a cron-processed queue instead of sending it inline during the page request — so heavy email-sending pages stay fast.

---

Enabling the module does nothing until you list which mails to queue. Its `hook_mail_alter()` implementation (forced to run last via `hook_module_implements_alter()`) checks each outgoing message's `id` against the `queue_mail_keys` config (a newline-separated list of mail IDs, matched with `path.matcher` so `*` and `user_*` wildcards work); a match adds the message to the `queue_mail` reliable queue, records the active theme on it, sets `$message['queued'] = TRUE`, and sets `$message['send'] = FALSE` so core does not send it immediately. On cron the `SendMailQueueWorker` (`@QueueWorker` id `queue_mail`, default `cron.time` 60, overridable via `queue_mail_queue_time`) dequeues each message, invokes `hook_queue_mail_send_alter()`, re-applies the saved theme, formats and sends it through the mail manager. Failed sends are retried: a `requeue_interval` (default 10800s) delays retries (via `DelayedRequeueException`) and a `threshold` (default 50) caps attempts before the item is dropped and logged; `queue_mail_queue_wait_time` can sleep between items. The settings form (route `queue_mail.admin_settings`, `/admin/config/system/queue_mail`, permission `administer site configuration`) shows the current queue length, a table of mail-sending modules and their ID prefixes, and the advanced timing/retry options. Code can check `$message['queued']` to see whether a mail was queued. Process the queue with core `drush queue:run queue_mail --time-limit=15`. A submodule, **queue_mail_language**, makes the queued send honour each mail's own language.

---

- Speed up a registration or checkout page that would otherwise send several emails inline.
- Defer all site email to cron by setting the mail-IDs field to `*`.
- Queue only the User module's emails with the `user_*` wildcard.
- Queue just password-reset emails by listing `user_password_reset`.
- Offload a newsletter/notification blast so the triggering request returns quickly.
- Retry transient SMTP failures automatically up to a configurable threshold.
- Delay retries of failed emails by a configurable requeue interval (default 3 hours).
- Cap wasted effort by dropping an email after N failed attempts and logging it.
- Throttle sending by adding a wait time between each queued item.
- Bound cron email time with the "Queue processing time (max)" setting.
- Check `$message['queued']` in code to confirm a mail was deferred rather than sent inline.
- Process the mail queue on demand with `drush queue:run queue_mail --time-limit=15`.
- Alter a queued email just before it is finally sent via `hook_queue_mail_send_alter()`.
- Preserve the theme used to build a mail so the queued send renders identically.
- Reduce page latency spikes on high-traffic sites caused by synchronous mail delivery.
- Send transactional emails asynchronously without adding a dedicated mail-queue module stack.
- View how many mails are currently queued from the settings page or the status report.
- Keep sending order/reliability using a reliable Drupal queue.
- Send queued mails in each recipient's language by enabling the queue_mail_language submodule.
- Combine with SMTP/Symfony Mailer modules — Queue Mail only controls *when* mail is sent.
- Selectively queue only slow or bulk mail IDs while sending the rest immediately.
- Cancel a queued email at send time by setting `$message['send'] = FALSE` in the alter hook.
