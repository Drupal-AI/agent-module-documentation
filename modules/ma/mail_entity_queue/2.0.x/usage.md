<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mail Entity Queue provides an entity queue based system to process emails.

---

Mail Entity Queue provides an **entity-queue-based system for processing emails** — queuing emails as
entities and sending them through a controlled queue (with Symfony Mailer, Ultimate Cron, Webform integrations
via submodules), for reliable/throttled sending. It depends on core Options and System, provides its own
permissions, in the Mail package.

Use it to queue and process outbound email reliably. It is a mail/operations feature. Security note: a system
that **sends email in bulk** is powerful — ensure only trusted flows enqueue mail (to avoid it becoming a spam/
relay vector), gate its permissions to trusted operators, and keep queued email content trusted. It has no
access-control role beyond its permissions. Configure the mail queue.

---

- Queue emails as entities.
- Process email through a queue.
- Send reliably/throttled.
- Integrate Symfony Mailer/Webform.
- Depend on core Options and System.
- Provide its own permissions.
- Ensure only trusted flows enqueue mail.
- Avoid becoming a spam/relay vector.
- Keep queued email content trusted.
- Gate permissions to trusted operators.
- Have no access-control role beyond permissions.
- Configure the mail queue.
- Handle mail queuing.
- Queue email.
- Configure the queue.
- Send email.
- Handle the queue.
- Process mail.
- Restrict enqueuing.
- Provide a mail queue.
