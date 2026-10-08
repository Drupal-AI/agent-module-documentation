<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Decoupled Notifications Symfony Mailer (de_notifications_symfony_mailer) — agent index

Email delivery channel for Decoupled Entity Notifications (DEN). Ships the `symfony_mail`
`notification_type` plugin, a Symfony Mailer EmailBuilder, and default mailer policies.

- **Package:** Decoupled Entity Notifications · **License:** GPL-2.0-or-later · **Core:** `^10 || ^11`
- **Depends on:** `symfony_mailer:symfony_mailer`, `de_notifications:de_notifications`
- **Parent module:** `../../../../de_notifications/2.0.x/agent/start.md`

## What it provides
- NotificationType plugin `symfony_mail` — `src/Plugin/NotificationType/SymfonyMail.php`
  (implements all six DEN send methods; injects `de_notifications.context` and Symfony Mailer
  `email_factory`).
- EmailBuilder `de_notifications_mailer` — `src/Plugin/EmailBuilder/SymfonyEmailBuilder.php`
  (extends `EmailBuilderBase`; `common_adjusters = email_subject, email_body`) with sub-types:
  `confirm`, `subscription_confirmed`, `already_subscribed`, `entity_notification`,
  `subscription_overview`, `archived`.
- Default mailer policies (install config): `config/install/symfony_mailer.mailer_policy.de_notifications_mailer.*.yml`.

## How it works
`SymfonyMail::composeMail($sub_type, $langcode)` sets the language, builds the recipient `Address`
from the subscriber email, creates a typed email via `email_factory->newTypedEmail('de_notifications_mailer', $sub_type)`,
and attaches common variables (`unsubscribe_all_url`, `request_subscription_overview_url`). Each send
method adds kind-specific variables (`confirm_url`, `unsubscribe_url`, `entity_title`, `entity_url`,
`changes`, `subscriptions`) from the `de_notifications.context` service, then `$email->send()`.

## Enable & use
Install Symfony Mailer, enable this submodule, then set DEN's `notification_type` to `symfony_mail`
at `/admin/config/system/de_notifications`. Theme each message under Symfony Mailer's policy UI.

## Solution doc
- The `symfony_mail` plugin & email builder: [agent/plugins/symfony-mail.md](plugins/symfony-mail.md)
