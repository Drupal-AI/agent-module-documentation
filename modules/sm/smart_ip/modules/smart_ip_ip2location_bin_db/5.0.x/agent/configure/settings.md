# Configure — IP2Location binary database source

This submodule has **no page of its own**. It adds fields to Smart IP's settings form
(`/admin/config/people/smart_ip`, permission `administer smart_ip`) by subscribing to
`smart_ip.display_admin_settings` (`formSettings()`), and validates/saves them via
`smart_ip.validate_admin_settings` / `smart_ip.submit_admin_settings`. It is only queried when
`smart_ip.settings:data_source` equals its `sourceId()`, `ip2location_bin_db`.

## Activate

```bash
drush en smart_ip_ip2location_bin_db -y
drush cset smart_ip.settings data_source ip2location_bin_db -y
```

## Config object `smart_ip_ip2location_bin_db.settings`

| Key | Form element (name) | Values / default | Meaning |
|---|---|---|---|
| `version` | `ip2location_bin_db_version` (select) | `licensed` \| `lite` (default `lite`) | Commercial or free IP2Location LITE. |
| `edition` | `ip2location_bin_db_edition_licensed` / `…_edition_lite` (select) | product code (default `DB11`) | Licensed: `DB1`..`DB24`; lite: `DB1/DB3/DB5/DB9/DB11`. The form has two selects; the one for the chosen version is saved to `edition`. |
| `token` | `ip2location_bin_db_token` (textfield) | string / null | IP2Location download token; required for **licensed** auto-download. |
| `db_auto_update` | `ip2location_bin_db_auto_update` (select Yes/No) | bool (default **false**) | Download/refresh the BIN files on cron (licensed only). |
| `caching_method` | `ip2location_bin_db_caching_method` (select) | `no_cache` \| `memory_cache` \| `shared_memory` (default `no_cache`) | Reader mode → `\IP2Location\Database::FILE_IO` / `MEMORY_CACHE` / `SHARED_MEMORY`. |
| `bin_file_custom_path` | `ip2location_bin_db_custom_path` (textfield) | string / null | Absolute dir holding the BIN files you manage (used when auto-update is off). |

Schema: `config/schema/smart_ip_ip2location_bin_db.settings.schema.yml` (`type: config_object`);
install defaults in `config/install/…settings.yml`. `hook_update_8301` merged the old separate
IPv4/IPv6 custom-path settings into `bin_file_custom_path` and set `db_auto_update` to off.

Set via drush:

```bash
drush cset smart_ip_ip2location_bin_db.settings version licensed -y
drush cset smart_ip_ip2location_bin_db.settings edition DB11 -y
drush cset smart_ip_ip2location_bin_db.settings token YOUR_DOWNLOAD_TOKEN -y
drush cset smart_ip_ip2location_bin_db.settings db_auto_update 1 -y
drush cset smart_ip_ip2location_bin_db.settings caching_method no_cache -y
```

## Database files

- Two BIN files are used per lookup direction: IPv4 and IPv6.
  `DatabaseFileUtility::getFilename($version, $edition, $ipVersion)` →
  `IP2LOCATION-LITE-<edition>.BIN` / `IP2LOCATION-LITE-<edition>.IPV6.BIN` (lite), or
  `IP-<PRODUCT>.BIN` / `IPV6-<PRODUCT>.BIN` (licensed, where `<PRODUCT>` is the product name for the
  code, upper-cased).
- Default location: `private://smart_ip` (`DatabaseFileUtilityBase::DRUPAL_FOLDER`); a private
  filesystem path must be configured. When auto-update is off and `bin_file_custom_path` is set,
  that directory is read instead.
- Validation opens each BIN with the reader to confirm it exists and is valid; a missing/corrupt
  file blocks saving and (for licensed auto-update) tells you to upload the initial file first.

## What happens at runtime

- **Lookup** (`processQuery()`): resolves folder+filename, opens
  `new \IP2Location\Database($dbFile, $cachingMode)`, `lookup($ip, ALL)`, blanks IP2Location
  placeholder values (`-`, `Please upgrade`, `Invalid IP address`), and fills the location keys
  `country`, `countryCode`, `region`, `regionCode`, `city`, `zip`, `latitude`, `longitude`,
  `timeZone`, `isEuCountry` (plus raw `originalData`). Missing file → logs an error and returns.
- **Download/refresh** (`DatabaseFileUtility::downloadDatabaseFile($ipVersion)` via
  `manualUpdate()`/`cronRun()`): licensed builds a query against
  `https://www.ip2location.com/download` (`token`, `file`) for IPv4 then IPv6, via
  `DatabaseFileUtilityBase::requestDatabaseFile()` (download to `temporary://smart_ip`, extract,
  move the BIN into `private://smart_ip`). A queue state
  `smart_ip_ip2location_bin_db.current_ip_version_queue` walks IPv4 → IPv6; on completion
  `…last_update_time` is stamped. **Lite auto-download returns early (unsupported).**
- **Cron cadence** (`cronRun()`): monthly — `needsUpdate()` fires on the first Wednesday of the
  month (or continues an in-progress IPv4/IPv6 queue).

## Requirements

`hook_requirements('install')` errors if `\IP2Location\Database` (the `ip2location/ip2location-php`
library) is not installed. `hook_uninstall()` clears the `…last_update_time` and
`…current_ip_version_queue` state.
