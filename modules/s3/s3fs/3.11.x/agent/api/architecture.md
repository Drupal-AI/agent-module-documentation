<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Architecture: services, wrappers, image styles

## Services

| Service | Class | Role |
|---|---|---|
| `stream_wrapper.s3` | `StreamWrapper\S3fsStream` | The `s3://` scheme (tag `stream_wrapper`, `scheme: s3`) |
| `s3fs` | `S3fsService` | AWS client factory, config validation, cache refresh helpers |
| `s3fsfileservice` | `S3fsFileSystemD103` | **Decorates core `file_system`** (`decoration_priority: 5`) so core file APIs work against S3 |
| `s3fs.path_processor.image_styles` | `S3fsPathProcessorImageStyles` | Inbound path processor, **priority 310** |
| `s3fs.route_subscriber_core_image_style` | `S3fsAlterCoreImageStyleRoutesSubscriber` | Alters core's image-style routes |
| `s3fs.file_migration_batch` / `s3fs.refresh_cache_batch` | batch services | Back `copy-local` / `refresh-cache` |
| `s3fs.mime_type.guesser` (+ `.extension`) | MIME guessers | Tag `s3fs_mime_type_guesser`; wired by compiler pass or tagged iterator depending on core version |
| `logger.channel.s3fs` | logger | `drush watchdog:show --type=s3fs` |

```php
$s3fs   = \Drupal::service('s3fs');
$client = $s3fs->getAmazonS3Client(\Drupal::config('s3fs.settings')->get());  // AWS\S3\S3Client
$errors = $s3fs->validate(\Drupal::config('s3fs.settings')->get());           // [] when healthy
```

## `S3fsServiceProvider` — the container surgery

Everything version- and settings-dependent happens here, which is why a `drush cr` is mandatory
after changing the takeover settings:

- `s3fs.use_s3_for_public` → `stream_wrapper.public` class becomes `PublicS3fsStream`; on core
  < 10.1 `asset.css.optimizer` is swapped for `S3fsCssOptimizer` (fixes CSS asset URLs), and when
  AdvAgg is present an `S3fsAdvAggSubscriber` is registered.
- `s3fs.use_s3_for_private` → `stream_wrapper.private` class becomes `PrivateS3fsStream`.
- Core ≤ 10.2 → `s3fsfileservice` falls back to the deprecated `S3fsFileService` class.
- MIME guessing: on core with setter injection a `S3fsMimeTypePass` compiler pass collects
  `s3fs_mime_type_guesser`-tagged services; on Drupal 11.4+ a `TaggedIteratorArgument` is used
  instead. Add your own guesser by tagging a service `s3fs_mime_type_guesser`.

## Stream wrappers

Three classes: `S3fsStream` (the `s3://` scheme), `PublicS3fsStream` and `PrivateS3fsStream`
(installed over core's schemes only when the corresponding setting is on). They extend the AWS
SDK's `StreamWrapper` and add Drupal behaviour: metadata-cache lookups instead of live `stat()`,
`presigned_urls` / `saveas` / `torrents` rule matching (parsed from the newline-separated config
strings), CNAME/custom-host URL building, and `Cache-Control`/encryption on write.

Ordinary Drupal code needs no s3fs API — use the standard file APIs and they route through the
wrapper:

```php
$uri = 'public://logo.png';                  // s3:// under takeover
file_put_contents($uri, $bytes);
$url = \Drupal::service('file_url_generator')->generateAbsoluteString($uri);
$file = \Drupal::service('file.repository')->writeData($bytes, 's3://reports/q1.pdf');
```

`CrossSchemeAccessException` is thrown when something tries to reach across schemes in a way the
module refuses (e.g. an image-style request pointing at a scheme it does not serve).

## Image styles

Two moving parts:

1. **Route callback** `S3fsImageStyleRoutes::routes()` adds `s3fs.image_styles` at
   `/s3/files/styles/{image_style}/{scheme}` (controller
   `NewS3fsImageStyleDownloadController::deliver`, `_access: 'TRUE'`), only when the `image`
   module is enabled.
2. **`S3fsAlterCoreImageStyleRoutesSubscriber`** rewrites core's own image-style routes so
   derivative requests are handled by the s3fs controllers
   (`S3fsImageStyleDownloadController` / `NewS3fsImageStyleDownloadController`).

Flow: a request for a derivative that does not exist yet is generated locally, written to the
bucket, and then served — with `redirect_styles_ttl > 0` the controller answers with a redirect to
the S3/CDN URL (cacheable for that TTL) instead of streaming the bytes through PHP. The controller
also honours core's `file_sa_core_2023_005_schemes` setting when validating the requested scheme.

`S3fsPathProcessorImageStyles` (inbound, priority 310) normalises incoming derivative paths before
routing, which is why it must run ahead of core's own image path processor.

## Config validation

```php
// Returns an array of human-readable errors; empty means the bucket is reachable
// with the current credentials/region/endpoint settings.
$errors = \Drupal::service('s3fs')->validate($config);
```

This is what the *Validate* button on `/admin/config/media/s3fs/actions` and
`drush s3fs:refresh-cache` both call before doing any work.

## Migrations (from Drupal 7)

`migrations/`: `d7_s3fs_config` (settings), `d7_s3fs_public_migrate`, `d7_s3fs_private_migrate`,
`d7_s3fs_s3_migrate` (file entities per scheme). Run them with the usual
`drush migrate:import` workflow after setting up the D7 source database.
