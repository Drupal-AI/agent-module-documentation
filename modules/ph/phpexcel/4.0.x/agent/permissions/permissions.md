<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `phpexcel.permissions.yml`. One permission, gating only the cache settings form.

| Permission | Machine name | Grants |
|---|---|---|
| administer phpexcel | `administer phpexcel` | Access to the settings form at `/admin/config/development/phpexcel` (route `phpexcel.admin`) |

There is **no** permission controlling the `phpexcel` service itself — reading and writing spreadsheets
is a code-level API, callable by any module that has the service. Access control for exported/imported
files is the responsibility of the calling code.
