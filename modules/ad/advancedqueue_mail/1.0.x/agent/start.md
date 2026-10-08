<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Queue Mail (advancedqueue_mail) — agent index

Emails a configured recipient list on Advanced Queue job events. Subscribes to the `advancedqueue`
`JOB_SUCCESS`, `JOB_RETRY` and `JOB_FAILURE` events and sends a templated notification per enabled event type.
Package `Mail`. Depends on **`advancedqueue`** (`>=8.x-1.6`). Core `^10.2 || ^11`. License GPL-2.0-or-later.
Version 1.0.1.

## What it provides

- **Event subscriber** `AdvancedQueueEventSubscriber` (`src/EventSubscriber/`) — maps the three
  advancedqueue job events to `MailSenderInterface::sendNotificationMail($job, $event_type)`.
- **Service** `advancedqueue_mail.mail_sender` = `MailSender` (`src/Service/`), aliased from
  `MailSenderInterface`. Reads config, substitutes placeholders, calls the core mail manager.
- **hook_mail()** via `Hook\MailHooks` (OOP `#[Hook('mail')]`, wired from `advancedqueue_mail.module`) — sets
  `subject`/`body` from params for keys `on_success`, `on_retry`, `on_failure`.
- **Config form** `Form\SettingsForm` at route `advancedqueue_mail.settings`
  (`/admin/config/system/queues/mail`, permission `administer site configuration`). Menu/task links appear under
  the Advanced Queue *Queues* collection.
- **Config object** `advancedqueue_mail.settings` (schema in `config/schema/`, defaults in `config/install/`).
- **Submodule** `advancedqueue_mail_symfony_mailer` — swaps the mail sender for Mailer Plus (Symfony Mailer).
  Documented separately under `modules/advancedqueue_mail_symfony_mailer/`.

No permissions of its own, no Drush commands, no plugin types.

## Solution docs

- Config object, schema, route, placeholders, install/enable →
  [config/settings.md](config/settings.md)
- Event subscriber, mail sender service, hook_mail, extension points →
  [api/mail-sender.md](api/mail-sender.md)
