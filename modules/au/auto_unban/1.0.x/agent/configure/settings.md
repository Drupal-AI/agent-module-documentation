# Configure Auto Unban

## Settings form
- Route `auto_unban.settings` → `/admin/config/system/auto-unban`, permission
  `administer site configuration`. Form class `Drupal\auto_unban\Form\SettingsForm`.
- Single field `seconds` (a `select`), stored in config object `auto_unban.settings`.
  Options: 60, 600, 1800, 3600, 21600, 43200, 86400, 172800, 604800, 2592000, 31536000
  (one minute … one year). Default (config/install) = `3600`.
- Change via Drush: `drush config:set auto_unban.settings seconds 86400 -y`.
- The description on the form notes it **only affects IPs banned in the future**; existing
  ban rows keep their current `expires` value.

## What the setting controls
`seconds` is the base ban window. On a ban, expiry = `now + seconds * 2^attempts` (see
[api/ban-manager.md](../api/ban-manager.md) for the back-off). So `seconds`=3600 gives
1h / 2h / 4h / 8h … for an IP banned repeatedly.

## Schema
`config/schema/auto_unban.settings.schema.yml` → `auto_unban.settings` (`config_object`) with
one `integer` mapping `seconds`.

## Install / uninstall side effects (auto_unban.install)
- **install:** adds `expires` (int, default 0) and `attempts` (int, default 0) columns to the
  core `ban_ip` table, then sets every existing row's `expires` to `2147483647` — pre-existing
  bans stay effectively permanent.
- **uninstall:** deletes rows whose `expires <= now` (so core Ban does not re-activate lapsed
  bans), then drops the `expires` and `attempts` columns.

## Behaviour note (not a vuln, but a policy change)
Enabling this module changes core Ban semantics: any IP banned afterwards (through the UI form,
`banIp()`, or Drush `ban` without `--permanent`) becomes **time-limited** (default 1h), not
permanent. Use the ban form's **Add indefinitely** button or `drush ban <ip> --permanent` when a
truly permanent ban is intended. There is no route or mechanism by which a banned visitor can
lift their own ban — expiry is purely time-based and evaluated server-side.
