# API — `geoip_autoupdate.updater` service

Service id `geoip_autoupdate.updater`, class `Drupal\geoip_autoupdate\GeoIpUpdaterService`.
Constructor deps: `config.factory`, `http_client`, `state`, `file_system`, and the
`logger.channel.geoip_autoupdate` channel.

Constants:
- `DOWNLOAD_URL` = `https://download.maxmind.com/geoip/databases/%s/download?suffix=tar.gz`
- `EDITION_ID` = `GeoLite2-Country`
- `STATE_LAST_MODIFIED` = `geoip_autoupdate.last_modified`

## Public methods
```php
$updater = \Drupal::service('geoip_autoupdate.updater');

$updater->runUpdate();   // void. Cron path: no-op if creds empty; HEAD check; downloads only if newer.
$updater->forceUpdate(); // void. Downloads now, bypassing the Last-Modified gate.
                         //   throws \RuntimeException if credentials are not configured.
$stamp = $updater->getLastModified(); // ?string. Stored Last-Modified of the installed DB, or NULL.
```

- Both `runUpdate()` and `forceUpdate()` read `account_id` / `license_key` from
  `geoip_autoupdate.settings` and authenticate to MaxMind with HTTP Basic auth.
- Network/extraction failures are caught and logged (channel `geoip_autoupdate`), not thrown —
  except `forceUpdate()` which throws `\RuntimeException` when credentials are missing (surfaced
  as a form error by the "Download now" button).
- On success the `.mmdb` lands at `private://GeoLite2-Country.mmdb` and state
  `geoip_autoupdate.last_modified` is updated.

## Notes
- `hook_cron` simply calls `runUpdate()`; there is no queue or scheduler of its own.
- Extraction uses `\PharData::extractTo()` into a `sys_get_temp_dir()` subdir; the temp archive
  and extract dir are cleaned up afterward.
