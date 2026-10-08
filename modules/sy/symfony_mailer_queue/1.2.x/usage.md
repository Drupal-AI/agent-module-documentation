<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Symfony Mailer Queue moves outbound mail off the request: an email adjuster puts messages on a Drupal queue instead of sending them inline, and a queue worker delivers them on cron with configurable retry behaviour for failures.

---

Sending mail during a web request is slow and fragile — an unreachable SMTP server turns into a failed node save. This module makes queueing a **mailer policy** decision. It decorates Symfony Mailer's `email_factory` service so emails are instantiated as `QueueableEmail` objects, and adds a `queue_sending` email adjuster you attach to any mailer policy; when that adjuster runs, `build()` checks the email is queueable (throwing `LogicException` otherwise) and, if it is not already in the queue, pushes a `SymfonyMailerQueueItem` — a readonly value object capturing type, subtype, params, addresses, sender, subject, body, theme and the inner Symfony `Email` — onto the `symfony_mailer_queue` queue. `SymfonyMailerQueueWorker` (cron time 60s) pops items and sends them. Failure handling is configurable per policy: **Queue Behavior** chooses between immediate requeue, delayed requeue (the default, honoured by Drupal's database queue) and suspending the queue so the remaining items wait for the next run; **Requeue delay** (default 60 seconds), **Maximum attempts** and **Email send wait time** tune the rest. Two events, `EmailSendFailureEvent` and `EmailSendRequeueEvent`, let other modules react when delivery fails or is retried, each carrying the queue item. A `StaticLanguageNegotiator` preserves the language context of the original request so a queued email renders in the right language. Note the module-level `symfony_mailer_queue.settings` object is deprecated for removal — its schema is retained only for migration; configure the adjuster instead. `hook_uninstall()` cleans up both the old settings and every `queue_sending` adjuster from existing mailer policies.

---

- Stop slow SMTP servers from delaying node saves.
- Send bulk notification emails from cron rather than a request.
- Retry failed deliveries automatically with a delay.
- Cap retries so a permanently broken address stops being retried.
- Suspend the mail queue when the mail server is down.
- Queue only specific mailer policies, leaving others inline.
- Keep the correct interface language on queued emails.
- Send registration emails asynchronously.
- Improve perceived performance of content workflows.
- React to send failures with a custom event subscriber.
- Log or alert when an email is requeued.
- Smooth out mail bursts caused by bulk operations.
- Avoid losing emails when a request times out.
- Use Drupal's database queue without extra infrastructure.
- Plug in a different queue backend supported by Drupal.
- Tune the delay between retry attempts.
- Process queued mail on a dedicated cron run.
- Keep the email's full context (params, theme, addresses) for later sending.
- Migrate away from the deprecated module-level settings to per-policy config.
- Clean up queue adjusters automatically when uninstalling.
