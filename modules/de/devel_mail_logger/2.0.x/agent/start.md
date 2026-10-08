<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Devel Mail Logger — agent index

Dev/QA tool: a mail backend (`MailInterface` plugin `devel_mail_logger`) that stores every outgoing email in the `devel_mail_logger` DB table, plus a report UI to browse/send/delete them. No config page (`configure` null); you activate it by pointing `system.mail` at the plugin. Provides 3 permissions. Not for production.

- **How to activate the mail backend, the report routes, permissions, and the DB schema** → [configure/setup.md](configure/setup.md)

Key facts:
- Plugin: `@Mail(id="devel_mail_logger")` → `DevelMailLogger::mail()` inserts `{timestamp, recipient, subject, message=json_encode($message)}`.
- Activate: `$config['system.mail']['interface']['default'] = 'devel_mail_logger';` (settings.php) or via the Mail System module.
- UI: `admin/reports/devel_mail_logger` (list), `/mail/{id}` (view), `/send` (test mail), delete form.
