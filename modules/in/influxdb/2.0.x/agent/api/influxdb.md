<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# influxdb — client API, buckets & ECA actions

## Client service
```php
/** @var \InfluxDB2\Client $client */
$client = \Drupal::service('influxdb.services.client');
$health = $client->createService(\InfluxDB2\Service\HealthService::class);
$writeApi = $client->createWriteApi();
$queryApi = $client->createQueryApi();
```
`ClientFactory::createClient('influxdb.settings')` reads config (`server_url`, `organization`, `allow_redirects`, `debug`), resolves the token from the Key repository (`getToken()` → `Key::getKeyValue()`), and injects `@http_client`. `getOrganizationId(?name)` resolves an org ID via `OrganizationsService`.

## Config (`influxdb.settings`)
`server_url`, `organization`, `token` (Key ID via `key_select`, filter `type: authentication`), `allow_redirects` (bool), `debug` (bool). Settings form pings the server on validate and reports the version.

## influxdb_bucket submodule
Config entity `influxdb_bucket` (label + `retention_seconds`). `BucketManager::upsertBucket(['label'=>…, 'retention_seconds'=>…])` looks up the bucket by label and either `postBuckets` (new, with org ID + `BucketRetentionRules`) or `patchBucketsID` (existing). Admin UI under `/admin/config/services/influxdb/buckets` (perm `administer influxdb bucket`).

## influxdb_bucket_eca submodule (ECA actions)
- `influxdb_create_point` (**Create a Point**) — builds a `Point` from `name`, `datetime`+`datetime_format`, `precision`, and `tags`/`fields` parsed as YAML; result stored in an ECA token. `access()` validates the datetime and YAML.
- `influxdb_write_point` (**Write Point**) — normalises the ECA-token Point and writes it to the selected `influxdb_bucket` via the write API.
- `influxdb_run_flux_query` (**Execute a Flux query**) — runs `configuration['query']` through the query API and stores rows in an ECA token.

All three take their query/point data from the ECA model configuration (admin-authored), not from request parameters.
