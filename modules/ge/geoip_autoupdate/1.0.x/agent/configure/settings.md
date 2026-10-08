# Configure — GeoIP Auto-Update

## Settings form
Route `geoip_autoupdate.settings` → `/admin/config/system/geoip/autoupdate`, permission
`administer site configuration`. Form class `GeoIpAutoUpdateSettingsForm` (a `ConfigFormBase`).

Fields:
- **MaxMind Account ID** (`account_id`) — textfield, required. Numeric MaxMind account ID.
- **MaxMind License Key** (`license_key`) — **password** field. Leave blank to keep the existing
  stored value; a non-empty submit overwrites it.
- **Database last downloaded** — read-only item showing the stored `Last-Modified` (or "Never").
- **Download now** — submit button (`::downloadNow`) that saves credentials then calls
  `forceUpdate()` immediately, reporting success/failure via messenger.

## Config object
`geoip_autoupdate.settings` (schema `geoip_autoupdate.schema.yml`), defaults from
`config/install/geoip_autoupdate.settings.yml`:

```yaml
account_id: ''
license_key: ''
```

Set via Drush without the UI:
```
drush cset geoip_autoupdate.settings account_id 123456 -y
drush cset geoip_autoupdate.settings license_key YOUR_LICENSE_KEY -y
```

## Update flow (what actually happens)
- **On cron** (`hook_cron` → `updater->runUpdate()`): if either credential is empty it returns
  early. Otherwise a HEAD request to the fixed MaxMind URL (HTTP Basic auth, redirects allowed)
  reads `Last-Modified`. If that equals state `geoip_autoupdate.last_modified`, it stops (up to
  date). Otherwise it downloads.
- **Download** (`->get()` with `sink` to a temp `.tar.gz`) → `extractMmdb()` uses `\PharData`
  to extract, finds the first `*.mmdb`, copies it to `private://GeoLite2-Country.mmdb`, then
  stores the new `Last-Modified` in state. Failures are logged to the `geoip_autoupdate` channel.
- **Download now** calls `forceUpdate()` which downloads regardless of the freshness check (it
  still tries a HEAD to record `Last-Modified` but proceeds even if that HEAD fails).

## Wiring it up (end to end)
1. Configure `$settings['file_private_path']` in `settings.php`; ensure the dir is writable.
2. Enter Account ID + License Key here, click **Download now** to fetch + verify.
3. On the GeoIP settings page (`/admin/config/system/geoip`) select **Local dataset (private
   filesystem)** as the active GeoLocator (see [../plugins/geolocator.md](../plugins/geolocator.md)).
4. Cron keeps it fresh. Status page (`/admin/reports/status`) reports the private DB + its age.
