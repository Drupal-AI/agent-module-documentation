<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

From `social_auth.permissions.yml`:

| Permission | Gates |
|---|---|
| `administer social auth profiles` | Full admin of `social_auth` profile entities (this is the entity's `admin_permission`): view the site-wide list, delete any profile. |
| `delete own social auth profile` | A user may delete social auth profiles linked to their own account. |

Related permission (defined by the **social_api** dependency, used by this module's routes):

- `administer social api authentication` — required by `social_auth.integrations`
  (`/admin/config/social-api/social-auth`) and each provider settings form
  (`/admin/config/social-api/social-auth/{network}`).

Access notes:
- The OAuth routes `user/login/{network}` and `.../callback` are `_access: 'TRUE'` (anonymous
  can log in; authenticated users can link another provider).
- `/user/{user}/social-auth/profiles` requires `user.update` entity access on that user.
- Profile entity access is handled by `SocialAuthAccessControlHandler`.

```bash
drush role:perm:add authenticated 'delete own social auth profile'
drush role:perm:add content_admin 'administer social auth profiles'
```
