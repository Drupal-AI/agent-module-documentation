<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mail Safety — agent index

Intercepts outgoing mail via `hook_mail_alter()`. When `enabled`, sets `$message['send'] = FALSE`
so nothing is delivered, then optionally stores each mail in the `mail_safety_dashboard` table
and/or reroutes it to one `default_mail_address`. All state = five keys in `mail_safety.settings`
plus rows in one DB table. No entities, no plugins, no Drush.

- **Settings, config keys, routes, permissions** → [configure/settings.md](configure/settings.md)
- **Dashboard: how mail is caught/stored/resent, the DB table, cron retention** → [api/dashboard.md](api/dashboard.md)
- **Hooks other modules can implement (attachments etc.)** → [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Config object: `mail_safety.settings` → `enabled`, `send_mail_to_dashboard`,
  `send_mail_to_default_mail`, `default_mail_address`, `log_retention_period`.
- Configure route: `mail_safety.settings` (`/admin/config/development/mail_safety/settings`).
  Dashboard route: `mail_safety.dashboard` (`/admin/config/development/mail_safety`).
- Permissions: `administer mail safety` (settings), `use mail safety dashboard` (dashboard + per-mail actions).
- Nothing is caught unless `enabled` is TRUE **and** at least one destination
  (`send_mail_to_dashboard` or `send_mail_to_default_mail`) is on.
