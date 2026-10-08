<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `user_register_notify.permissions.yml`.

| Permission | Grants |
| --- | --- |
| `administer user_register_notify configuration` | Access the settings form (route `user_register_notify.settings`) and change every notification setting: recipients, events, message templates, header overrides, logging. |

This is the module's only permission; it is not marked `restrict access`. There is no separate
permission for receiving notifications — recipients are determined entirely by the `type`/`roles`/
`mail_to` config, not by a permission. Sending is triggered by core user entity hooks and requires
no permission on the acting user.
