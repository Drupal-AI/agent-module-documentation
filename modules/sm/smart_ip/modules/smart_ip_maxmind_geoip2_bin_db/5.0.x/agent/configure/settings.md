# Configure — MaxMind GeoIP2 binary database source

This submodule has **no page of its own**. It adds fields to Smart IP's settings form
(`/admin/config/people/smart_ip`, permission `administer smart_ip`) by subscribing to
`smart_ip.display_admin_settings` (`formSettings()`), and validates/saves them via
`smart_ip.validate_admin_settings` / `smart_ip.submit_admin_settings`. It is only queried when
`smart_ip.settings:data_source` equals its `sourceId()`, `maxmind_geoip2_bin_db`.

## Activate

```bash
drush en smart_ip_maxmind_geoip2_bin_db -y
drush cset smart_ip.settings data_source maxmind_geoip2_bin_db -y
```

## Config object `smart_ip_maxmind_geoip2_bin_db.settings`

| Key | Form element (name) | Values / default | Meaning |
|---|---|---|---|
| `version` | `maxmind_geoip2_bin_db_version` (select) | `licensed` \| `lite` (default `lite`) | Commercial GeoIP2 or free GeoLite2. |
| `edition` | `maxmind_geoip2_bin_db_edition` (select) | `city` \| `country` (default `city`) | Resolution level. |
| `user_account` | `maxmind_geoip2_bin_db_user_account` (textfield) | string / null | MaxMind account ID; required for **lite** auto-download. |
| `license_key` | `maxmind_geoip2_bin_db_license_key` (textfield) | string / null | MaxMind license key; required for auto-download (lite and licensed). |
| `db_auto_update` | `maxmind_geoip2_bin_db_auto_update` (select Yes/No) | bool (default **true**) | Download/refresh the `.mmdb` on cron. |
| `bin_file_custom_path` | `maxmind_geoip2_bin_db_custom_path` (textfield) | string / null | Absolute dir of a `.mmdb` you manage yourself (used only when auto-update is off). |

Schema: `config/schema/smart_ip_maxmind_geoip2_bin_db.settings.schema.yml`
(`type: config_object`). Install defaults: `config/install/…settings.yml`.

Set via drush (equivalent to the admin sub-form):

```bash
drush cset smart_ip_maxmind_geoip2_bin_db.settings version lite -y
drush cset smart_ip_maxmind_geoip2_bin_db.settings edition city -y
drush cset smart_ip_maxmind_geoip2_bin_db.settings user_account YOUR_ACCOUNT_ID -y
drush cset smart_ip_maxmind_geoip2_bin_db.settings license_key YOUR_LICENSE_KEY -y
drush cset smart_ip_maxmind_geoip2_bin_db.settings db_auto_update 1 -y
```

Or in PHP:

```php
\Drupal::configFactory()->getEditable('smart_ip_maxmind_geoip2_bin_db.settings')
  ->set('version', 'lite')->set('edition', 'city')
  ->set('user_account', 'ACC')->set('license_key', 'KEY')
  ->set('db_auto_update', TRUE)->save();
```

## Database file

- Filenames (`DatabaseFileUtility::getFilename()`): `GeoLite2-City.mmdb` / `GeoLite2-Country.mmdb`
  (lite), `GeoIP2-City.mmdb` / `GeoIP2-Country.mmdb` (licensed).
- Default location: Drupal private stream `private://smart_ip` (`DatabaseFileUtilityBase::DRUPAL_FOLDER`).
  A private filesystem path must be configured (validation blocks save otherwise). When auto-update
  is off and `bin_file_custom_path` is set, that directory is read instead.
- The initial file must exist before saving: validation requires the expected `.mmdb` to already be
  present at the private path (or custom path). Auto-update then keeps it current on cron.

## What happens at runtime

- **Lookup** (`processQuery()` on `smart_ip.query_ip_location`): resolves the folder via
  `DatabaseFileUtility::getPath($autoUpdate, $customPath)` and the filename, opens the `.mmdb` with
  `\MaxMind\Db\Reader` (fast C reader, if available) or `\GeoIp2\Database\Reader`, and fills the
  location keys `country`, `countryCode`, `region`, `regionCode`, `city`, `zip`, `latitude`,
  `longitude`, `timeZone`, `isEuCountry` (plus raw `originalData`). Missing file → logs an error and
  returns (Smart IP falls back).
- **Download/refresh** (`DatabaseFileUtility::downloadDatabaseFile()` via
  `manualUpdate()`/`cronRun()`): builds a query against
  `https://download.maxmind.com/app/geoip_download` (`edition_id`, `license_key`, `suffix=tar.gz`;
  plus `account_id` for lite), calls `DatabaseFileUtilityBase::requestDatabaseFile()` which streams
  the tar.gz to `temporary://smart_ip`, extracts it (core `Tar`/`Zip`, `PharData` fallback), moves
  the `.mmdb` into `private://smart_ip`, and stamps
  `smart_ip_maxmind_geoip2_bin_db.last_update_time`.
- **Cron cadence** (`cronRun()`): weekly — downloads when `needsUpdate()` sees the current
  Wednesday is newer than the last update (MaxMind rebuilds every Tuesday).

## Requirements

`hook_requirements('install')` errors if `\GeoIp2\Database\Reader` (the `geoip2/geoip2` library) is
not installed. `hook_uninstall()` clears the `…last_update_time` state.
