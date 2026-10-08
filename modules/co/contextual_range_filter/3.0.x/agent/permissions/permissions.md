# Views Contextual Range Filter permissions

Two permissions (`contextual_range_filter.permissions.yml`):

| Permission | `restrict access` | Gates |
|---|---|---|
| `administer contextual range filters` | — | The settings page `/admin/config/content/contextual-range-filter` (route `contextual_range_filter.settings`) where contextual filters are converted to range filters. |
| `use php code for default contextual filter` | true | The `php_default` argument-default plugin's PHP-code textarea — i.e. entering a PHP snippet that computes a default contextual value. |

`use php code for default contextual filter` is restricted because it allows executing an
arbitrary PHP snippet as a Views argument default; grant it only to fully trusted users (they
must both hold the permission and "know what they are doing", per the form's own warning).

```bash
drush role:perm:add administrator 'administer contextual range filters'
```
