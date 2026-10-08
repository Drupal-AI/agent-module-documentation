<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domino SMS (domino_sms) — agent index

Submodule of **Domino**. The SMS counterpart of Domino's "display emails as Drupal messages":
on non-production environments it **intercepts outgoing SMS (SMS Framework) and shows them as Drupal
messages instead of sending them**. Package `Domino`. Core `^10.1 || ^11`. License
GPL-2.0-or-later. Version 4.0.x.

- **The event subscriber, its config flag, and how the intercept works** →
  [services/sms-messages.md](services/sms-messages.md)

## Dependencies

- Modules: `domino` (parent), `sms` (SMS Framework, project `smsframework`) — from
  `domino_sms.info.yml`.
- Parent module docs: [`../../../4.0.x/agent/start.md`](../../../4.0.x/agent/start.md).

## What it actually provides (from source)

- **One service** (`domino_sms.services.yml`): `domino_sms.event_subscriber` =>
  `Drupal\domino_sms\EventSubscriber\DominoSmsSubscriber`, args `@messenger`, `@config.factory`,
  tagged `event_subscriber`.
- **One config object**: `domino_sms.settings` with a single key `display_sms_as_messages`
  (install default `1`). No config schema, no admin UI, no routes, no permissions, no Drush.
- **No credentials of its own** — it never contacts an SMS gateway; gateway/API-key handling lives
  entirely in the SMS Framework module you configure.

## Mechanism in one line

`DominoSmsSubscriber::onMessagePreprocess()` listens on `SmsEvents::MESSAGE_PRE_PROCESS`; if
`domino.settings.application_mode !== 'production'` **and** `domino_sms.settings.display_sms_as_messages`
is truthy, it renders each message as a status message (highlighting 6-digit codes) and calls
`$event->setMessages([])` so nothing is dispatched. See
[services/sms-messages.md](services/sms-messages.md).
