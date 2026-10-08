# Permissions

Defined in `environment_indicator.permissions.yml` (plus a `permissions_callback`,
`EnvironmentIndicatorPermissions::permissions`, that adds per-switcher permissions).

| Permission | Gates |
|---|---|
| `administer environment indicator settings` | Access the settings form and add/edit/delete Environment Switcher entities. Also the entity `admin_permission`. Trusted. |
| `access environment indicator` | Whether the user actually sees the indicator banner/toolbar cue on the site. |

The permission callback additionally generates a per-environment "access <name> environment
indicator" style permission for each switcher, so visibility can be granted per environment.

Grant via drush:
```
drush role:perm:add authenticated 'access environment indicator'
```
