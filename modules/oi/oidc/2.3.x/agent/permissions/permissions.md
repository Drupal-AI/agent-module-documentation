<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `oidc.permissions.yml`.

| Permission | Machine name | Notes |
| --- | --- | --- |
| Administer OpenID Connect | `administer oidc` | `restrict access: true` (marked security-sensitive). Gates both admin routes: `oidc.admin.settings` (`/admin/config/people/oidc`) and `oidc.admin.realms_config` (`/admin/config/people/oidc/realms`). |

There are no end-user-facing permissions — logging in via a realm needs no permission (the login
routes are gated only by `_user_is_logged_in: 'FALSE'` and, for the callbacks, the session-state
access checks). Grant `administer oidc` only to trusted administrators: it exposes client secrets and
provider configuration.

Grant via drush:

```bash
ddev drush role:perm:add administrator 'administer oidc'
```
