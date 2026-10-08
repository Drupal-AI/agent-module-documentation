<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CER permissions

`cer.permissions.yml` defines exactly one permission:

| Permission | Title | Gates |
|---|---|---|
| `administer cer` | Administer Corresponding Entity References | every CER route, and the `corresponding_reference` config entity type (`admin_permission = "administer cer"`) |

Routes it protects (all in `cer.routing.yml`):

| Route | Path |
|---|---|
| `entity.corresponding_reference.collection` | `/admin/config/content/cer` |
| `entity.corresponding_reference.add_form` | `/admin/config/content/cer/add` |
| `entity.corresponding_reference.edit_form` | `/admin/config/content/cer/{corresponding_reference}` |
| `entity.corresponding_reference.delete_form` | `/admin/config/content/cer/{corresponding_reference}/delete` |
| `entity.corresponding_reference.sync_form` | `/admin/config/content/cer/{corresponding_reference}/sync` |

Grant it:

```bash
drush role:perm:add content_editor 'administer cer'
drush user:role:add content_editor someuser
```

Check it:

```bash
drush php:eval 'var_dump(\Drupal\user\Entity\Role::load("content_editor")->hasPermission("administer cer"));'
```

## Important: the permission does not gate the syncing

`administer cer` only controls **who can manage presets**. The actual reference syncing runs
from `hook_entity_insert/update/delete` for *every* save, whoever performs it — including
anonymous submissions, migrations and cron. What limits it is ordinary **entity and field
access on the corresponding entity**: CER loads and `save()`s that entity in the current
user's security context, so a user without update access to it simply gets no back-reference,
with no warning (called out in the project README).
