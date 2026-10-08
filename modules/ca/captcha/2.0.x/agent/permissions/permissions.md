# Permissions

Defined in `captcha.permissions.yml`.

| Permission | Gates |
|---|---|
| `administer CAPTCHA settings` | Full admin access: the settings form, CAPTCHA points list/add/edit/delete, and the examples page. All `captcha_*` admin routes require it. Trusted/restricted. |
| `skip CAPTCHA` | Users with this permission are never shown a CAPTCHA (e.g. authenticated/trusted roles). |

Grant via drush:
```
drush role:perm:add authenticated 'skip CAPTCHA'
drush role:perm:add administrator 'administer CAPTCHA settings'
```

Beyond permissions, the `whitelist_ips` setting lets anonymous requests from listed IPs /
ranges bypass challenges (see [../configure/settings.md](../configure/settings.md)).
