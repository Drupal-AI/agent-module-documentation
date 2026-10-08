<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Disqus permissions

From `disqus.permissions.yml` (four permissions):

| Permission | Gates |
|---|---|
| `administer disqus` | Access to the settings form (`/admin/config/services/disqus`) and admin actions. Trusted users only. |
| `view disqus comments` | Whether a role may see Disqus threads. Grant to the roles that should see comments (commonly Anonymous + Authenticated). |
| `display disqus comments on profile` | Show Disqus comments on the profiles of users in this role. |
| `toggle disqus comments` | Lets users turn comments on/off on individual nodes. |

Grant via drush:

```bash
drush role:perm:add anonymous 'view disqus comments'
drush role:perm:add authenticated 'view disqus comments'
```

Note: `view disqus comments` is the one most sites forget — without it the thread is not
displayed to visitors even when a `disqus_comment` field and shortname are configured.
