<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `pdb_vue.permissions.yml`.

| Permission | Machine name | Gates |
|---|---|---|
| Administer decoupled Vue.js block settings | `administer decoupled vue blocks` | The settings form only (route `pdb_vue.form`, `/admin/config/services/pdb-vue`). |

This is the module's only permission and it is not marked `restrict access`. It does **not** control
who can place or configure Vue blocks — that is core's block/layout access (`administer blocks`, or
Layout Builder access on the entity). It only guards the site-wide Vue version / dev-mode / SPA form.

Grant via drush:

```bash
drush role:perm:add administrator 'administer decoupled vue blocks'
```
