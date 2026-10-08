<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

From `auto_login_url.permissions.yml`. Both are `restrict access: true` (marked security-sensitive
in the UI):

| Permission | Gates |
|---|---|
| `administer auto login url` | All config + URL-management routes (`/admin/people/autologinurl*`, generate/manage/view/delete/bulk/usage) and the health check. A holder can mint a login URL for **any** uid, including uid 1 — treat as trusted-admin only. |
| `use auto login url` | Documented as "authenticate using auto login URLs". Note: the login controller/service do **not** gate `/autologinurl/{uid}/{hash}` on this permission — the route is `_access: TRUE` and success depends on possessing a valid token for that uid. The permission is effectively advisory in 3.1.x. |

Access notes:
- Minting URLs in code (`auto_login_url_create()`) performs **no** permission check on the caller —
  callers are trusted module code. It validates the target uid exists/active and rate-limits per uid.
- The public login endpoint's real protections are the unforgeable token, per-IP flood control,
  expiry, optional IP binding, and blocked/inactive-user rejection.
