<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SMS Phone Number — permissions

Defined in `sms_phone_number.permissions.yml`:

| Permission | Gates |
|---|---|
| `bypass phone number verification requirement` | Allows saving an **unverified** phone number even when a field's `verify` setting is `required`. Marked `restrict access: 1` (a sensitive permission — grant only to trusted roles such as administrators/support). |

There is no other permission and no admin settings page; field configuration and the
`sms_phone_number.settings` config object cover the rest (see
[../configure/field-and-settings.md](../configure/field-and-settings.md)).
