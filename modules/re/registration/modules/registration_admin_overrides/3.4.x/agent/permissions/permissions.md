<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

All five are `restrict access: true` (security-sensitive) — from
`registration_admin_overrides.permissions.yml`.

| Permission | Allows the account to override |
|---|---|
| `registration override status` | the host's enabled/disabled status |
| `registration override maximum spaces` | the maximum spaces allowed per registration |
| `registration override capacity` | the host entity capacity |
| `registration override open` | the open date (register before open) |
| `registration override close` | the close date (register after close) |

An override fires only if the registration type **also** enables the matching third-party boolean
(see [../configure/overrides.md](../configure/overrides.md)). Holding `administer registration` or
`administer <type> registration` implies all overrides for that scope.
