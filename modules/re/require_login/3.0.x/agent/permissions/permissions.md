<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Require Login permission

From `require_login.permissions.yml`:

| Permission | Gates | Notes |
|---|---|---|
| `administer require login` | Access to the settings form at `/admin/config/people/login-requirements` (route `require_login.settings`). | `restrict access: true` — this permission controls whether the whole site is gated, so grant it only to trusted administrators. |

There are no per-content or per-user permissions; enforcement is decided by the configured
conditions in `require_login.settings`, not by a permission. Note that being able to *bypass*
the requirement simply means being authenticated (any logged-in user), plus the always-open
`PROTECTED_ROUTES` (login/register/password-reset and asset routes).
