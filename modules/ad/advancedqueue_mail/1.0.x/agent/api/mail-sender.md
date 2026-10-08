<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Event flow, mail sender service & hook_mail

## Services (`advancedqueue_mail.services.yml`)

`_defaults: autowire: true`. Defined:

- `advancedqueue_mail.mail_sender` → `Service\MailSender`, with
  `Service\MailSenderInterface` aliased to it.
- `advancedqueue_mail.event_subscriber.advancedqueue` → `EventSubscriber\AdvancedQueueEventSubscriber`
  (tagged `event_subscriber`).
- `Hook\MailHooks` (OOP hook class).

The parameter `advancedqueue_mail.skip_procedural_hook_scan: true` tells core not to scan the `.module` for
procedural hooks — the one procedural `advancedqueue_mail_mail()` is a `#[LegacyHook]` shim delegating to
`MailHooks::mail()`.

## Event subscriber

`AdvancedQueueEventSubscriber` (`getSubscribedEvents()`) listens on the `advancedqueue` constants and forwards the
`JobEvent`'s job to the sender with the matching config key:

| `AdvancedQueueEvents` constant | Handler | `$event_type` |
|---|---|---|
| `JOB_SUCCESS` | `queueJobSuccess()` | `on_success` |
| `JOB_RETRY` | `queueJobRetry()` | `on_retry` |
| `JOB_FAILURE` | `queueJobFailure()` | `on_failure` |

Each handler calls `$this->mailSender->sendNotificationMail($event->getJob(), $event_type)`. These events are
dispatched by advancedqueue as it processes jobs (cron/Drush queue runners), so notifications fire during
server-side queue processing, not from a web request.

## `MailSender::sendNotificationMail(Job $job, string $event_type)`

1. Loads `advancedqueue_mail.settings`, reads the `$event_type` mapping.
2. Returns early if `enabled` is empty **or** `recipients` is empty.
3. Builds `$replacements` from the job (`getReplacements()`), substitutes them into the configured `subject` and
   `body` (`replacePlaceholders()` = `str_replace`).
4. Calls `MailManagerInterface::mail('advancedqueue_mail', $event_type, $recipients, <default langcode>, $params)`
   where `$params = ['subject' => …, 'body' => …, 'job' => $job]`. Recipients come straight from the
   admin-configured `recipients` string; langcode is the default language.

## `MailHooks::mail()` (hook_mail)

For keys `on_success` / `on_retry` / `on_failure` it sets `$message['subject'] = $params['subject']` and appends
`$params['body']` to `$message['body']`. Other keys are ignored. Core's mail manager then formats and hands the
message to the active mail plugin (PhpMail by default).

## Extending / swapping the sender

`MailSenderInterface` has a single method `sendNotificationMail(Job $job, string $event_type)`. To change delivery
(e.g. a different transport), provide a service that implements it and override the `advancedqueue_mail.mail_sender`
definition in a `ServiceProvider::alter()` — exactly how the `advancedqueue_mail_symfony_mailer` submodule
substitutes `SymfonyMailerMailSender` / `SymfonyMailerV2MailSender`.
