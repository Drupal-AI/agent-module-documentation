# Configure environments

![Environment Indicator settings](../../../../../../../screenshots/environment_indicator/4.0.x/settings.png)

Two layers: global **settings** (form + `settings.php`) and **Environment Switcher**
config entities.

## Settings form
`/admin/config/development/environment-indicator` (route `environment_indicator.settings`,
permission `administer environment indicator settings`). Stored in
`environment_indicator.settings` (config/install defaults):
```yaml
toolbar_integration: [toolbar]     # tint the admin toolbar (needs toolbar submodule)
favicon: true                      # recolor the favicon per environment
version_identifier: 'environment_indicator_current_release'   # state key holding the release
version_identifier_fallback: 'deployment_identifier'          # settings.php fallback
```

## Pin the current environment in settings.php
Fastest, per-deployment approach — override the active indicator so each copy is unambiguous:
```php
$config['environment_indicator.indicator']['name'] = 'Production';
$config['environment_indicator.indicator']['bg_color'] = '#cc0000';
$config['environment_indicator.indicator']['fg_color'] = '#ffffff';
```

## Environment Switcher entities
Config entity type `environment_indicator` (config prefix `switcher.*`), managed at
`.../environment-indicator/switcher`. Exportable fields (`config_export`):
`machine`, `name`, `description`, `url`, `weight`, `fg_color`, `bg_color`.
Each switcher with a `url` becomes an entry in the cross-environment **dropdown**, letting
users jump to the same-ish page on another environment. Deploy them like any config.

## Version identifier
Set the state value named by `version_identifier` (default state key
`environment_indicator_current_release`) at deploy time, or a
`$settings['deployment_identifier']`, to show a release/SHA next to the environment name.
