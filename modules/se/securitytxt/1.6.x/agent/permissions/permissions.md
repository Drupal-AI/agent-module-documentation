<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# securitytxt — permissions

Defined in `securitytxt.permissions.yml`. Two permissions, and they gate different things:

| Permission | Gates | Who should get it |
|---|---|---|
| `administer securitytxt` | The config form (`securitytxt.configure`) and Sign form (`securitytxt.sign`). `restrict access: TRUE`. | Only very trusted admin roles. |
| `view securitytxt` | Reading `/.well-known/security.txt` and `/.well-known/security.txt.sig`. | **Both Anonymous and Authenticated** — otherwise the whole point (public discovery) is lost. |

The module intentionally puts the public file behind a permission rather than making it
world-readable, so you must explicitly grant `view securitytxt` to the Anonymous role for
scanners and researchers to reach it.

## Grant via drush

```bash
drush role:perm:add anonymous 'view securitytxt'
drush role:perm:add authenticated 'view securitytxt'
drush role:perm:add administrator 'administer securitytxt'
drush cr
```

Check which roles hold a permission:

```bash
drush php:eval '$r=\Drupal\user\Entity\Role::loadMultiple(); foreach($r as $id=>$role){ echo $id.": ".($role->hasPermission("view securitytxt")?"yes":"no")."\n"; }'
```
