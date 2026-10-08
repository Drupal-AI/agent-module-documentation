<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mail Debugger (mail_debugger) — agent index

Developer tool for sending test email through Drupal's mail manager, to confirm a site can
actually deliver mail. Two admin pages: one sends a free-text message (to / subject / body); the
other re-sends a core user-notification mail (password reset, account activation, etc.) to a
chosen site user. No dependencies beyond core. `package: development`.
Core: `^8 || ^9 || ^10 || ^11`. `.info.yml` reports the legacy `version: '8.x-1.5'`.

- Configure route (`.info.yml` `configure`): `admin/config/development/mail_debugger`.
- Defines **1 permission**; no drush commands, no plugins, no config object/schema, no services.

Solutions:
- **Send a custom test email, or re-send a core user-notification mail** → [configure/send-test-mail.md](configure/send-test-mail.md)
- **Who can reach the mail-debugger pages** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Routes: `mail_debugger.wizard` (`admin/config/development/mail_debugger`, form `MailDebuggerForm`)
  and `mail_debugger.user` (`admin/config/development/mail_debugger/user`, form `UsermailDebuggerForm`).
- Permission gating both routes: `access mail_debugger`.
- Custom send goes through the mail manager (`plugin.manager.mail`) as module `mail_debugger`,
  key `mail_debugger`; the module's `hook_mail()` (`mail_debugger_mail()`) fills subject/body.
- User send calls core `_user_mail_notify($operation, $user)`; the `operation` options are the
  keys of the `user.mail` config that carry a `subject`.
- Last custom message persisted in a `keyvalue` store keyed by the form class FQCN; last
  user/operation in `tempstore.private`.
