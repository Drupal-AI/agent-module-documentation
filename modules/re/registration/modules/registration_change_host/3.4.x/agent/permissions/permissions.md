<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

From `registration_change_host.permissions.yml`:

| Permission | Allows |
|---|---|
| `change host any registration` | change the host of **any** registration |
| `change host own registration` | change the host of the user's **own** registrations |

These gate the `entity.registration.change_host` / change-host form routes (entity access
`registration.change host`), on top of the base module's registration access. Moving to a host of a
different registration type additionally requires the type's
`registration_change_host.allow_data_loss` third-party setting to be true.
