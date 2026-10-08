# GeoLite2 Database Update submodule

Optional submodule `geolite2_update` (machine name `geolite2_update`, package GeoIP, depends on
`geoip:geoip`). Downloads a MaxMind GeoLite2 database and writes it to `public://<edition>.mmdb`
where the `local` plugin reads it. Enable with `drush en geolite2_update`.

## Settings form

Route `geolite2_update.settings` → `/admin/config/system/geoip/update` (a **tab on the GeoIP
settings**, `base_route: geoip.configure`; moved from `/admin/config/system/geolite2-update` in
3.1). Permission: `administer geolite2 update` (restricted). Class `GeoLite2UpdateSettingsForm`.

Config object `geolite2_update.settings`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `account_id` | string | `''` | MaxMind account ID. Overridable by `$settings['geolite2_update_account_id']`. |
| `license_key` | string | `''` | MaxMind license key. Overridable by `$settings['geolite2_update_license_key']`. |
| `edition_id` | string | `GeoLite2-Country` | Edition to download: `GeoLite2-Country`, `GeoLite2-City`, or `GeoLite2-ASN`. |
| `update_method` | string | `drush` | `drush` (manual only) or `cron` (daily auto check). |

If `$settings['geolite2_update_account_id']` / `..._license_key` are set in settings.php, the form
disables those fields and the `settings.php` value wins (`Settings::get()` is checked before config).

## Drush command

`drush geolite2:update` (alias `geolite2-update`) — class `GeoLite2UpdateCommands`, service
`geolite2_update.updater`. Downloads the latest configured edition from MaxMind now, regardless of
`update_method`. Prints success/error; details go to the `geolite2_update` log channel.

## Cron

`geolite2_update_cron()` runs the update only when `update_method === 'cron'` **and**
`needsUpdate()` is true (last successful update, tracked in state key
`geolite2_update.last_update`, is older than 1 day).

## How the download works (`GeoLite2Updater::update()`)

- URL: `https://download.maxmind.com/app/geoip_download` with query `edition_id`, `license_key`,
  `suffix`. Fetched with the core `http_client` (Guzzle), HTTP Basic `auth: [account_id, license_key]`,
  `timeout: 120`, streamed to a temp file. **HTTPS with default TLS verification — no `verify=>false`.**
- Requires account ID + license key (else logs an error and returns FALSE).
- Archive suffix is `zip` when `ZipArchive` exists, else `tar.gz` when `gzopen` exists, else fails.
- Extracts the `<edition_id>.mmdb` entry (`extractMmdbFromZipArchive` /
  `extractMmdbFromTarGzArchive`) and writes it to `public://<edition_id>.mmdb` via
  `FileSystem::saveData(..., FileExists::Replace)`. A write failure throws and is caught/logged.
- On success, records `time()` in state and logs info.

After downloading, set the base module's `plugin_id` to `local` to use the file.
