<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `simple_password_policy.permissions.yml`.

| Permission | Restricted | Gates |
|---|---|---|
| `administer password policy` | **`restrict access: TRUE`** | The settings form / route `simple_password_policy.simple_password_policy_settings` (`/admin/config/people/password_policy`). Grant only to trusted admins — it controls every rule, expiry and the reset-route toggle. |
| `bypass password policy` | no | A user holding this (via any role) is fully exempt: `PasswordPolicy::applyPolicy()` returns FALSE, so none of the length/complexity/history/expiry checks apply to that user's own password. |

**`bypass password policy` semantics (from README):** the bypass applies to the *bypassing user's
own* password only. It does **not** let that user create other accounts with non-policy passwords —
to create a user with a non-compliant password, the *target* user must be assigned a bypass role
(during or after creation). Use it for service/system accounts whose generated credentials shouldn't
be forced through the interactive rules.

Other exemption levers (not permissions): `ignore_users` (username/email list) and `ignore_routes`
(suppresses the expiry redirect) — see `configure/settings.md`.
