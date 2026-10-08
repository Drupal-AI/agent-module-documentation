# Configure ip2country

## Config object `ip2country.settings`

Shipped defaults (`config/install/ip2country.settings.yml`), all `FullyValidatable`:

| Key | Default | Meaning / allowed values |
|---|---|---|
| `watchdog` | `true` | Log DB updates to dblog/watchdog. |
| `rir` | `'all'` | Registry to pull from. One of `all`, `afrinic`, `apnic`, `arin`, `lacnic`, `ripe`. |
| `md5_checksum` | `false` | Verify download with an MD5 checksum (RIRs don't always provide one). |
| `update_interval` | `604800` | Auto-update period, seconds. Allowed: `0` (off), `86400`, `302400`, `604800`, `1209600`, `2419200`. |
| `batch_size` | `200` | Rows per insert during import (min 1). |
| `debug` | `false` | Enable spoofing mode (see below). |
| `test_type` | `0` | `0` = spoof a **country**, `1` = spoof an **IP address**. |
| `test_country` | `''` | ISO 3166 country code to spoof (validated as a CountryCode). |
| `test_ip_address` | `''` | IP address to spoof (validated as an IP). |

## Debug / spoofing mode

When `debug` is TRUE **and** the acting user has `administer ip2country`, `hook_user_login`
overrides the detected country: with `test_type = 0` it uses `test_country` directly; with
`test_type = 1` it looks up `test_ip_address`. A status message "Using DEBUG value for
Country - XX" is shown. This only affects users who hold the permission — normal visitors are
never spoofed.

## Routes / UI

- `ip2country.settings` — `/admin/config/people/ip2country` (the settings form).
- `ip2country.update_database` — `/admin/config/people/ip2country/update/{rir}` (trigger an update).
- `ip2country.lookup` — `/admin/config/people/ip2country/lookup/{ip_address}` (UI lookup).
- All three require **`administer ip2country`**. Menu/task under *People* admin.

## Scriptable config

```bash
drush cget ip2country.settings

# use APNIC and update every 2 weeks
drush php:eval '$c=\Drupal::configFactory()->getEditable("ip2country.settings");
  $c->set("rir","apnic")->set("update_interval",1209600)->save();'

# turn on country spoofing to Germany (admins only)
drush php:eval '$c=\Drupal::configFactory()->getEditable("ip2country.settings");
  $c->set("debug",TRUE)->set("test_type",0)->set("test_country","DE")->save();'
```

Restore shipped defaults explicitly (do not rely on `State::has()` on this site): set each key
back to the values in the table above.

## Related State (not config)

- `ip2country_last_update` — unix timestamp of the last successful DB load.
- `ip2country_last_update_rir` — which RIR that load came from.
Read via `\Drupal::state()->get(...)`; these drive `drush ip2country:status`.
