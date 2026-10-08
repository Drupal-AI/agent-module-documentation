# Configure — MaxMind GeoIP2 Precision web service source

This submodule has **no page of its own**. It adds fields to Smart IP's settings form
(`/admin/config/people/smart_ip`, permission `administer smart_ip`) by subscribing to
`smart_ip.display_admin_settings` (`formSettings()`), and validates/saves them via
`smart_ip.validate_admin_settings` / `smart_ip.submit_admin_settings`. It is only queried when
`smart_ip.settings:data_source` equals its `sourceId()`, `maxmind_geoip2_web_service`.

## Activate

```bash
drush en smart_ip_maxmind_geoip2_web_service -y
drush cset smart_ip.settings data_source maxmind_geoip2_web_service -y
```

## Config object `smart_ip_maxmind_geoip2_web_service.settings`

| Key | Form element (name) | Values / default | Meaning |
|---|---|---|---|
| `service_type` | `maxmind_geoip2_web_service_type` (select) | `country` \| `city` \| `insights` (default `city`) | Which Precision endpoint to call. |
| `user_id` | `maxmind_geoip2_web_service_uid` (textfield) | string / null | MaxMind account/user ID (required). |
| `license_key` | `maxmind_geoip2_web_service_license_key` (textfield) | string / null | MaxMind license key (required). |

Validation (`validateFormSettings()`) requires both `user_id` and `license_key` when this source is
selected. Schema: `config/schema/smart_ip_maxmind_geoip2_web_service.settings.schema.yml`
(`type: config_object`); install defaults in `config/install/…settings.yml`.

Set via drush:

```bash
drush cset smart_ip_maxmind_geoip2_web_service.settings service_type city -y
drush cset smart_ip_maxmind_geoip2_web_service.settings user_id YOUR_USER_ID -y
drush cset smart_ip_maxmind_geoip2_web_service.settings license_key YOUR_LICENSE_KEY -y
```

Or in PHP:

```php
\Drupal::configFactory()->getEditable('smart_ip_maxmind_geoip2_web_service.settings')
  ->set('service_type', 'city')
  ->set('user_id', 'UID')->set('license_key', 'KEY')->save();
```

## What happens at a lookup

`processQuery()` (on `smart_ip.query_ip_location`) calls
`WebServiceUtility::getGeolocation($ip)`:

- `WebServiceUtility::getUrl()` builds
  `https://<user_id>:<license_key>@geoip.maxmind.com/geoip/v2.1/<service_type>/<ip>`
  (`MaxmindGeoip2WebService::BASE_URL` = `geoip.maxmind.com/geoip/v2.1`; service constants
  `country`/`city`/`insights`).
- `WebServiceUtilityBase::sendRequest()` issues `\Drupal::httpClient()->get($url, ['headers' =>
  ['Accept' => 'application/json']])` and returns the body; empty/failed responses are logged to the
  `smart_ip` channel and yield an empty result.
- The JSON is decoded and mapped to the location keys `country`, `countryCode`, `region`,
  `regionCode`, `city`, `zip`, `latitude`, `longitude`, `timeZone`, `isEuCountry` (plus raw
  `originalData`). If the current language is not in MaxMind's `names`, English is used.

There is **no** database file, cron download, or manual-update step here — `manualUpdate()` and
`cronRun()` are empty. Every lookup that reaches this source is a billable outbound API call, so pair
it with Smart IP's role/page/excluded-IP controls to limit call volume.
