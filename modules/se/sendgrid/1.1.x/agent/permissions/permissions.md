<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `sendgrid.permissions.yml`.

| Permission | Machine name | Notes |
|---|---|---|
| Administer Sendgrid | `administer sendgrid` | `restrict access: true` (flagged as restricted/sensitive in the permissions UI). Required by both module routes: `sendgrid.settings_form` and `sendgrid.test_email_form`. |

Grant to a role via Drush:

```bash
drush role:perm:add administrator 'administer sendgrid'
```

This is the only permission the module defines. There are no other access checks of its own — mail is
sent through the standard `MailManager` / `mailsystem` pipeline.
