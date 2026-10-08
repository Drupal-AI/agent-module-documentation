# Configure — smart_ip

Admin form: route **`smart_ip.settings`** → `/admin/config/people/smart_ip`
(`Drupal\smart_ip\Form\SmartIpAdminSettingsForm`, permission **`administer smart_ip`**). The form
has sections: manual lookup, data-source selection (each enabled source injects its own subsection
via the `smart_ip.display_admin_settings` event), preferences, and a debug tool. All values are
stored in the **`smart_ip.settings`** config object.

## `smart_ip.settings` keys

| Key | Type | Default | Meaning |
|---|---|---|---|
| `data_source` | string | `null` | **The active data source's `sourceId()`.** Must match an enabled source submodule (e.g. `maxmind_geoip2_bin_db`, `ip2location_bin_db`, `maxmind_geoip2_web_service`, `ipinfodb_web_service`, `abstract_web_service`, `device_geolocation`). Nothing geolocates until this is set. |
| `roles_to_geolocate` | sequence(role→role) | `{authenticated: authenticated}` | Which roles get geolocated on request. |
| `save_user_location_creation` | bool | `true` | Save location onto the user profile at registration. |
| `roles_in_debug_mode` | sequence(role→bool) | all `false` | Per-role: use a fixed debug IP instead of the real one. |
| `roles_in_debug_mode_ip` | sequence(role→string) | all `null` | Per-role debug IP address used when debug mode is on. |
| `allowed_pages` | text | `null` | Restrict geolocation to these Drupal paths (visibility-style list). |
| `excluded_ips` | text | `null` | Newline-separated IPs to skip (e.g. office ranges); `SmartIp::query()` returns `[]` for them. |
| `eu_visitor_dont_save` | bool | `false` | Do not store location for EU-country visitors (privacy/GDPR). |
| `timezone_format` | string | `identifier` | Time-zone representation: `identifier` (e.g. `Europe/Berlin`) vs offset. |

Read / set with drush:

```bash
drush cget smart_ip.settings data_source
drush cset smart_ip.settings data_source maxmind_geoip2_bin_db -y
drush cget smart_ip.settings roles_to_geolocate
```

## Selecting a data source (required)

1. Enable a source submodule, e.g. `drush en smart_ip_maxmind_geoip2_bin_db -y`.
2. Set `smart_ip.settings:data_source` to that source's id (its `sourceId()`), e.g.
   `maxmind_geoip2_bin_db`. Each source stores its own credentials/paths in its own config object
   (`<source_module>.settings`) — see each submodule's docs.
3. For binary-database sources, download/update the database from the admin form's manual-update
   button (dispatches `smart_ip.manual_database_update`) or via cron
   (`smart_ip.cron_run`).

Source id ↔ submodule:

| `data_source` value | submodule | config object |
|---|---|---|
| `maxmind_geoip2_bin_db` | smart_ip_maxmind_geoip2_bin_db | `smart_ip_maxmind_geoip2_bin_db.settings` |
| `maxmind_geoip2_web_service` | smart_ip_maxmind_geoip2_web_service | `smart_ip_maxmind_geoip2_web_service.settings` |
| `ip2location_bin_db` | smart_ip_ip2location_bin_db | `smart_ip_ip2location_bin_db.settings` |
| `ipinfodb_web_service` | smart_ip_ipinfodb_web_service | `smart_ip_ipinfodb_web_service.settings` |
| `abstract_web_service` | smart_ip_abstract_web_service | `smart_ip_abstract_web_service.settings` |
| `device_geolocation` | device_geolocation | `device_geolocation.settings` |

## Debugging

Per role, set `roles_in_debug_mode[<role>] = true` and `roles_in_debug_mode_ip[<role>] = <ip>` to
force geolocation of a fixed IP (`SmartIp::isUserDebugMode()` gates this). The admin form's "debug
tool" and "manual lookup" sections let you query an arbitrary IP interactively.
