<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Email — agent index

Define emails that Drupal Commerce sends on store events (order placed/paid, order workflow
transitions, checkout registration…). Each email is a **`commerce_email`** config entity that
binds an **email event** plugin to a token-replaced message with recipient rules, conditions,
and optional queueing. Depends on `commerce` and `token`. Admin UI at
`/admin/commerce/config/emails` (permission `administer commerce_email`). No configure route in
info.yml, no Drush.

- **Create/configure an email entity: all config keys, recipients, conditions, queue, tokens** →
  [configure/emails.md](configure/emails.md)
- **The `commerce_email_event` plugin type: shipped events, event names, writing one** →
  [plugins/email-events.md](plugins/email-events.md)
- **How sending is wired (EmailSubscriber, EmailSender, queue) and programmatic entry points** →
  [api/sending.md](api/sending.md)

Key facts: config prefix `commerce_email.commerce_email.*`; an email's `event` id (e.g.
`order_placed`) resolves to a Symfony `event_name` (e.g. `commerce_order.place.post_transition`).
`toType` is `email` (address/token in `to`) or `role` (`toRole`). `queue: true` defers sending to
the `commerce_email` Advanced Queue (or core Queue on cron). Multiple enabled emails can target
the same event.
