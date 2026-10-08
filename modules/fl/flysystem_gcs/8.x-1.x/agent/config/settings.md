<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring a GCS scheme (settings.php)

`flysystem_gcs` has **no config entity, no schema, and no admin form**. Schemes are defined the
Flysystem way: as entries in `$settings['flysystem']` in `settings.php`. Each entry with
`driver: gcs` becomes a stream wrapper whose key is the scheme name (e.g. `cloud-storage://`).

## Install / enable
1. `composer require drupal/flysystem_gcs` (pulls `superbalist/flysystem-google-storage`, which
   pulls `league/flysystem` and `google/cloud-storage`).
2. Enable `flysystem_gcs` (depends on `flysystem`): `drush en flysystem_gcs -y`.
3. Create a GCP bucket and a Service Account with the *Storage Admin* role; download its JSON key
   to a **private** folder outside the web root.
4. Add a scheme to `settings.php` (below), then set the File system default download method at
   `/admin/config/media/file-system` and/or repoint individual field storage destinations.

## Example scheme
```php
$settings['flysystem'] = [
  'cloud-storage' => [
    'driver' => 'gcs',
    'config' => [
      'bucket'         => 'example',
      'keyFilePath'    => '/serviceaccount.json',
      'projectId'      => 'google-project-id',
      'requestTimeout' => 5,
    ],
    'cache' => true,        // Cache filesystem metadata.
    '_localConfig' => [
      'prefix' => 'extra-folder/another-folder/',
      'uri'    => 'https://cname',
    ],
  ],
];
```

## Config keys
The entire `config` array is passed verbatim to `new StorageClient($configuration)` (see
`GoogleCloudStorage::create()`), so any `Google\Cloud\Storage\StorageClient` constructor option is
valid. Commonly used:

| Key | Where used | Meaning |
|-----|-----------|---------|
| `bucket` | pulled out in `create()` as `$bucketName`; required | Bucket name. Missing/empty throws `\InvalidArgumentException('A valid bucket name must be given')`. |
| `keyFilePath` | passed to `StorageClient` | Filesystem path to the Service Account JSON key. |
| `keyFile` | passed to `StorageClient` | Inline JSON credentials array (alternative to `keyFilePath`). |
| `projectId` | passed to `StorageClient` | GCP project id. |
| `requestTimeout` | passed to `StorageClient` | Seconds before a GCS request times out. |
| `_localConfig.prefix` | given to the adapter constructor | Path prefix prepended to every object key. |
| `_localConfig.uri` | given to the adapter constructor | Custom base URL / CNAME for **public** external URLs (API calls still hit Google's endpoint). |
| `cache` | consumed by the Flysystem module | Cache filesystem metadata. |

Note `_localConfig` is split off and `unset()` from `$configuration` before the client is built, so
it never reaches the GCS client — only `prefix` and `uri` reach `GoogleCloudStorage`/the adapter.

## Credentials — recommended pattern
Do not paste the JSON into a committed file. Keep the key outside the repo and reference it from an
env var:
```php
$settings['flysystem']['cloud-storage']['config']['keyFilePath'] = getenv('GCS_KEY_FILE');
```
Credentials are never written to Drupal config (this module ships none) and are not logged; the only
logging is in `GoogleCloudStorage::ensure()`, which reports a missing bucket or a `GoogleException`
message.

## Adopting the scheme
- **Site default:** set the scheme as the default download method at
  `/admin/config/media/file-system`.
- **Per field (safer):** set an individual file/image field's upload destination to the scheme.
- **Roll back:** repoint the field or File system default back to `public://`.
