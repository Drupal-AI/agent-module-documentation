<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Maillog / Mail Developer — agent index

Logs outgoing email to the `maillog` DB table, can display mails on-screen, and can suppress
delivery. Ships a core Mail plugin (`maillog`) set as the default mail interface on install.
Browsable View at `/admin/reports/maillog`. Depends on Views.

- **Settings form, config keys, install/uninstall behaviour, the `maillog` table & View** →
  [configure/settings.md](configure/settings.md)
- **Permissions (view / delete / administer maillog)** →
  [permissions/permissions.md](permissions/permissions.md)
- **Drush `maillog:clear`** →
  [drush/commands.md](drush/commands.md)

Key facts:
- Config object `maillog.settings`; suppress delivery with `send: false`, capture with `log: true`,
  on-screen dump with `verbose: true`. Cron cleanup via `cron_enabled` + `keep_limit_type`
  (`time_to_keep` days / `number_to_keep` count).
- Configure route `maillog.settings` → `/admin/config/development/maillog` (permission
  *administer maillog*).
- Install sets `system.mail.interface.default = maillog`; uninstall restores `php_mail`.
