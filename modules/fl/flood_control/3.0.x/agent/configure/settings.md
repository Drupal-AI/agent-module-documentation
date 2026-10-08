# Configure

Settings form `Drupal\flood_control\Form\FloodControlSettingsForm` at
`/admin/config/people/flood-control` (route `flood_control.settings`). The form edits keys in
**core's** `user.flood` config plus this module's own `flood_control.settings`, and (if the
Contact module is enabled) `contact.settings`.

`user.flood` keys written by the form (these are the "hidden" core flood variables):

| Key | Meaning |
|---|---|
| `ip_limit` | Failed logins allowed per IP before blocking. |
| `ip_window` | Seconds an IP stays blocked. |
| `user_limit` | Failed logins allowed per username. |
| `user_window` | Seconds a username stays blocked. |

`flood_control.settings` (schema `config/schema/flood_control.schema.yml`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `ip_white_list` | string | `''` | Newline/comma list of IPs and ranges exempt from flood limits. |

`contact.settings` keys (only when Contact is enabled): `flood.limit`, `flood.interval`.

Read/write with drush, e.g.:
```
drush config:set user.flood ip_limit 50 -y
drush config:set user.flood user_window 3600 -y
drush config:set flood_control.settings ip_white_list "127.0.0.1" -y
```

The allow-list is parsed by `flood_control_get_whitelist_ips()` and enforced by the
`FloodWhiteList` service decorator — see [extend/whitelist.md](../extend/whitelist.md).
