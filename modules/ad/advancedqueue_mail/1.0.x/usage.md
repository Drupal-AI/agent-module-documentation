<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Advanced Queue Mail emails a configured recipient list when Advanced Queue jobs succeed, are retried, or permanently fail.

---

Advanced Queue Mail is an operations/notification helper for the Advanced Queue module. It subscribes to the
`JOB_SUCCESS`, `JOB_RETRY` and `JOB_FAILURE` events and, for each event type you enable, sends an email built from
an admin-configured subject and body template. Templates support the placeholders `[job_id]`, `[job_type]`,
`[queue_id]`, `[message]` and `[state]`, which are filled in from the job that triggered the event. Out of the box
it sends through Drupal core's mail system; enabling the bundled `advancedqueue_mail_symfony_mailer` submodule
routes the same notifications through Mailer Plus (Symfony Mailer) so you can use policies, HTML and attachments.
All settings live in one config object edited at *Configuration → System → Queues → Mail Notifications*.

---

- Email administrators when a queued job permanently fails (the default enabled event).
- Notify a team when a job completes successfully.
- Send an alert each time a job is scheduled for a retry.
- Turn any of the three event notifications on or off independently.
- Send to a comma-separated list of recipient addresses per event type.
- Include the failing job's ID in the message with the `[job_id]` placeholder.
- Include the job/plugin type with `[job_type]`.
- Include the queue machine name with `[queue_id]`.
- Include the job result message (e.g. an exception text) with `[message]`.
- Include the job's final state with `[state]`.
- Customise the subject line per event type.
- Customise the body text per event type.
- Monitor background import/sync queues without watching logs.
- Get paged when a long-running batch queue fails after its retry budget is exhausted.
- Route notifications through Mailer Plus for HTML emails by enabling the submodule.
- Configure per-subtype Mailer Plus policies (Job success / Job retry / Job failure).
- Keep the same recipients across a Drupal core mail setup and a Mailer Plus setup.
- Alert on e-commerce order-processing queue failures.
- Notify content teams when a bulk-publish queue finishes.
- Watch cron-driven queues for silent failures.
- Feed queue-failure notifications to a shared ops inbox.
- Add queue observability to a site with no external monitoring stack.
