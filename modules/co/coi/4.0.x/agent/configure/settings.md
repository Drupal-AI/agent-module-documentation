<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure COI (`coi.settings`)

Single config object `coi.settings` (schema `config/schema/coi.schema.yml`, defaults in
`config/install/coi.settings.yml`). UI: `/admin/config/user-interface/coi` (route
`coi.settings`, permission `administer config override inspector`).

## Keys and defaults

```yaml
override_behavior: 'disable'          # 'disable' | 'noaccess' | '' (none / indicator only)
message:
  enabled: true
  template: 'This field is overridden by environment specific configuration.'
overridden_value:
  enabled: true                       # compute/show the overridden value
  element: true                       # inject overridden value as the field's #default_value (disable mode)
  secrets: false                      # also expose values on elements marked #config.secret
styling:
  selectors: true                     # add config / config--overridden / config--<bin>[--<key>] classes
  default: true                       # add COI's default CSS
```

`override_behavior` values map to `CoiValues` constants:
`disable` = `OVERRIDE_BEHAVIOUR_DISABLE`, `noaccess` = `OVERRIDE_BEHAVIOUR_NO_ACCESS`,
`''` = `OVERRIDE_BEHAVIOUR_NONE`.

- **disable**: overridden field is set `#disabled = TRUE`; if `overridden_value.element` is
  true, its `#default_value` becomes the overridden value.
- **noaccess**: overridden field gets `#access = FALSE` (hidden).
- **none (`''`)**: no disabling/hiding — only classes and/or message (if enabled).

`message.template` is run through the token service with `coi:active-value` and
`coi:overridden-value` available. Install `drupal/token` (suggested) for the token-browser UI
on the settings form.

## Set it via drush

```bash
# indicator-only, keep fields editable:
drush config:set coi.settings override_behavior '' -y
# hide overridden fields instead of disabling them:
drush config:set coi.settings override_behavior noaccess -y
# custom message:
drush config:set coi.settings message.template 'Managed per-environment; edit in settings.php.' -y
```

## Read it back

```bash
drush config:get coi.settings
```

## How to actually see an indicator

COI only reacts when a config **override** exists for a hinted field. Add one in
`settings.php`, e.g. `$config['system.site']['name'] = 'Overridden name';`, then open
*Configuration → System → Basic site settings* — the **Site name** field shows the COI
message/behavior. The set of fields that carry `#config` hints is provided by
`config_override_core_fields` (core system settings forms). See
[api/mechanism.md](../api/mechanism.md).
