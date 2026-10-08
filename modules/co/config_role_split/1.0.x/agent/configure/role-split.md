<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure: the `role_split` config entity

Config entity type `role_split` (`Drupal\config_role_split\Entity\RoleSplitEntity`,
`config_prefix = role_split`) → stored as config `config_role_split.role_split.<id>`.
Exported keys (`config_export`):

| Key | Type | Meaning |
|---|---|---|
| `id` | string | machine name. |
| `label` | label | admin label. |
| `weight` | int | order among filters (smaller/negative applied first). Default `0`. |
| `status` | bool | active. Only active filters run. Default `TRUE`. |
| `mode` | string | `split` (default), `fork`, or `exclude`. |
| `roles` | map | `role_id => [ permission_string, ... ]` — only the roles/permissions the filter manages. |

The `roles` map does **not** need every role or every permission — just the ones you want the
filter to interact with. Role ids are `user.role.<id>` ids (e.g. `authenticated`,
`administrator`); permission strings are exact permission ids (e.g. `access content`).

Example config (YAML):

```yaml
id: prod_admin
label: 'Production admin extras'
weight: 0
status: true
mode: split
roles:
  administrator:
    - 'access devel information'
  authenticated:
    - 'access user profiles'
```

## Admin UI

- Collection / configure route: `entity.role_split.collection` →
  `/admin/config/development/configuration/config-role-split` (listed under
  *Configuration → Development → Configuration synchronization*).
- Add: `/admin/config/development/configuration/config-role-split/add`; edit/delete under the
  same path. The roles form takes the `roles` map as YAML-style input (crude but functional —
  role id → list of permission ids).

## Via drush php:eval (scriptable)

```php
\Drupal::entityTypeManager()->getStorage('role_split')->create([
  'id' => 'prod_admin',
  'label' => 'Production admin extras',
  'weight' => 0,
  'status' => TRUE,
  'mode' => 'split',
  'roles' => ['authenticated' => ['access content']],
])->save();   // clears the config_filter plugin cache automatically
```

Read back:

```bash
drush cget config_role_split.role_split.prod_admin
```

## When it actually runs

Nothing happens until a config sync. Test the effect with `drush config:export` /
`drush config:import` (or `drush cex`/`drush cim`) — the filter rewrites the `user.role.*`
entries as they pass through the sync storage. There are **no Drush commands specific to this
module**; you drive it through core's config import/export.

## Overrides & weight/status

`weight` and `status` can be overridden per environment in `settings.php`
(`$config['config_role_split.role_split.<id>']['status'] = FALSE;`), but because the filter
plugins are derived and cached, you must clear caches for an override change to take effect.
The `roles` and `mode` are always read from the stored config (so deployment is deterministic).

## Permission

`administer config role split` (`restrict access: true`) gates the entity forms and collection.
