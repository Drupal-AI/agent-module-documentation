<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `symfony_mail` notification type & email builder

## Plugin
`src/Plugin/NotificationType/SymfonyMail.php` — `@NotificationType(id = "symfony_mail",
label = "Symfony mailer")`, extends `NotificationTypeBase`, `ContainerFactoryPluginInterface`.
Injected: `de_notifications.context` (`NotificationsContextServiceInterface`) and Symfony Mailer
`email_factory` (`EmailFactoryInterface`).

Implements DEN's six send methods; each sets context (subscription or subscriber), composes a typed
email, attaches variables, and calls `$email->send()`:

| Method | Sub-type | Extra variables |
|---|---|---|
| `sendConfirmation` | `confirm` | `confirm_url`, `unsubscribe_url`, `entity_title`, `entity_url` |
| `sendSubscriptionConfirmed` | `subscription_confirmed` | `unsubscribe_url`, `entity_title`, `entity_url` |
| `sendAlreadySubscribed` | `already_subscribed` | `confirm_url`, `unsubscribe_url`, `entity_title`, `entity_url` |
| `sendEntityNotification` | `entity_notification` | `confirm_url`, `unsubscribe_url`, `entity_title`, `entity_url`, `changes` |
| `sendArchived` | `archived` | `confirm_url`, `unsubscribe_url`, `entity_title`, `entity_url` |
| `sendSubscriptionOverview` | `subscription_overview` | `subscriptions` (title + unsubscribe_url list) |

`composeMail($sub_type, $langcode)`: `contextService->setLanguage()`, recipient
`new Address(subscriberEmail, NULL, $langcode)`, `email_factory->newTypedEmail('de_notifications_mailer', $sub_type)`,
plus common variables `unsubscribe_all_url` and `request_subscription_overview_url`.

## Email builder
`src/Plugin/EmailBuilder/SymfonyEmailBuilder.php` — `@EmailBuilder(id = "de_notifications_mailer", …)`
extends `EmailBuilderBase`, declares the six `sub_types` and `common_adjusters = {email_subject,
email_body}`. No custom build logic; subject/body come from mailer policies.

## Mailer policies (config/install)
`symfony_mailer.mailer_policy.de_notifications_mailer.<sub_type>.yml` for `confirm`,
`entity_notification`, `subscription_confirmed`, `subscription_overview`, `already_subscribed`,
`archived`. Edit these (or via Symfony Mailer UI) to customize subject/body; the variables above are
available in the templates.

## URLs / tokens
All `*_url` variables are produced by `NotificationsContextService` and carry the JWT `t` query
parameter (confirm uses `ttl_confirm`, others `ttl_generic`); entity URLs are built under DEN's
`frontend_url`. See the parent module's `agent/config/settings.md`.
