<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mailer Plus log — agent index

Logs emails sent through Symfony Mailer / Mailer Plus as `symfony_mailer_log` content entities.
Logging is driven by an **EmailAdjuster plugin** ("Log email") added to a Mailer policy, plus a
master **Enable logging** switch and optional cron-based expiry. Depends on `symfony_mailer`.

- **Turn logging on/off, enable it on a policy, retention/expiry settings, config keys** →
  [configure/settings.md](configure/settings.md)
- **The log entity: fields, storage helper, viewing/querying entries programmatically** →
  [api/log-entity.md](api/log-entity.md)
- **The three permissions (view / delete / administer entries)** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts: settings config object `symfony_mailer_log.settings`
(`enable` bool default TRUE, `log_expiry.max_age` ISO-8601 duration string default null,
`log_expiry.batch_size` int default 100). Settings route `symfony_mailer_log.settings` at
`/admin/config/system/mailer/symfony_mailer_log/settings`. Entity type `symfony_mailer_log`,
collection `/admin/reports/symfony_mailer_log`. The EmailAdjuster plugin id is
`symfony_mailer_log` (label "Log email"); logging only happens when that adjuster is on a
Mailer policy **and** `enable` is TRUE.
