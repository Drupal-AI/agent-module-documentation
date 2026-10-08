<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `watchdog_mailer.permissions.yml`.

| Permission | Title | Grants |
|------------|-------|--------|
| `administer watchdog_mailer` | Administer Watchdog Mailer | Access to the settings form at `/admin/config/development/watchdog_mailer` (route `watchdog_mailer.settings`) — i.e. enabling the mailer, setting recipients, editing subject/body templates, defining notification types, and the rate limit. |

This is the only permission the module defines, and it is the sole requirement on the settings route.
Grant it only to trusted administrators, since it controls which addresses receive log-derived mail
and the content of those messages.
