<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Queue Mail - Mailer Plus (advancedqueue_mail_symfony_mailer) — agent index

Submodule of **advancedqueue_mail** that replaces its mail sender with **Mailer Plus** (Symfony Mailer).
Package `Mail`. Depends on `advancedqueue_mail` and `symfony_mailer`. Core `^10.2 || ^11`.
License GPL-2.0-or-later. Version 1.0.1.

## What it provides

- **Service provider** `AdvancedqueueMailSymfonyMailerServiceProvider::alter()` — overrides the
  `advancedqueue_mail.mail_sender` definition. Detects Mailer Plus version by
  `interface_exists('Drupal\symfony_mailer\MailerPlusInterface')`:
  - 2.x → class `Service\SymfonyMailerV2MailSender`, arg `@Drupal\symfony_mailer\MailerPlusInterface`; also
    registers the component mailer service `Component\AdvancedQueueMailMailer`.
  - 1.x → class `Service\SymfonyMailerMailSender`, arg `@email_factory`.
- **EmailBuilder plugin** `Plugin/EmailBuilder/AdvancedQueueMail` (id `advancedqueue_mail`, sub-types
  `on_success` / `on_retry` / `on_failure`) — used by Mailer Plus 1.x; `createParams()` stores the `job` param.
- **Component mailer** `Component\AdvancedQueueMailMailer` with `#[MailerInfo(base_tag: 'advancedqueue_mail', …)]`
  — registers the same three sub-types with Mailer Plus 2.x's plugin system.
- Both senders implement the parent's `MailSenderInterface::sendNotificationMail()`, so the parent's event
  subscriber keeps working unchanged.

`services.yml` is empty (`services: {}`) — everything is wired in the service provider. No routes, permissions,
config schema or Drush of its own.

## Solution docs

- Service override, version detection, senders, plugins, configuration →
  [integration/mailer-plus.md](integration/mailer-plus.md)
