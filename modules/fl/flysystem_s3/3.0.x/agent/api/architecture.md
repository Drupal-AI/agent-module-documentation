<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Architecture

Components that make the `s3` scheme work. No public service API to call; you integrate by
configuring a scheme (settings.php) and using the resulting stream wrapper.

## Flysystem plugin — `Flysystem\S3` (`@Adapter(id = "s3")`)

Implements `FlysystemPluginInterface` + `ContainerFactoryPluginInterface`.
- `create()` merges config, builds an `Aws\S3\S3Client`, then **unsets `key`/`secret`** from the
  stored config. `mergeClientConfiguration()` sets `version: latest`, `region`, `endpoint`, and
  optional `bucket_endpoint` / `use_accelerate_endpoint` / `use_dual_stack_endpoint` /
  `use_path_style_endpoint`. If `key`+`secret` are present it uses `Aws\Credentials\Credentials`;
  otherwise it sets `credentials.cache` to an `AwsCacheAdapter` (IAM role path).
- `getAdapter()` returns an `S3Adapter`; on `S3Exception` it logs and returns a
  `MissingAdapter` so the site degrades gracefully.
- `getExternalUrl()` returns a Drupal download URL for private schemes, or a direct
  `urlPrefix + target` for public ones (generating the image style on demand for `styles/…`).
- `ensure()` checks `doesBucketExistV2()` and reports a bucket-missing error to status checks.
- `calculateUrlPrefix()` builds `protocol://cname[/bucket][/prefix]`, defaulting the CNAME to
  the region's `s3-<region>.amazonaws.com` (special-casing `us-east-1` → `s3.amazonaws.com`).

## `Flysystem\Adapter\S3Adapter` (extends league `AwsS3Adapter`)

Drupal-oriented overrides: forces non-streaming HTTP for stat (`@http.stream = FALSE`), a more
tolerant `has()` (object, object+`/`, or directory), a `getMetadata()` that treats a missing
object as a directory, and an `upload()` that defaults ACL to `private` and fills ContentType /
ContentLength.

## `File\FlysystemS3FileSystem` (decorates core `file_system`)

Registered in `flysystem_s3.services.yml` (`decorates: file_system`). Overrides `chmod()`: for a
**private** S3 scheme it forces mode `0600`/`0700` so the stream wrapper's ACL mapping keeps the
object private (Drupal would otherwise chmod it public via the default file mask).

## `AwsCacheAdapter` (implements `Aws\CacheInterface`)

Wraps a Drupal `CacheBackendInterface` (default `cache.default`, prefix `flysystem_s3:`) so the
AWS SDK caches IAM role credentials between requests.

## Managed-file CORS integration

`flysystem_s3_element_info_alter()` → `S3CorsManagedFileHelper::alterInfo()` injects pre/post
process callbacks into the `managed_file` element type (see configure/cors-upload.md). Key
static helpers: `isCorsAvailable($scheme, $account)` (driver `s3` + `config.cors` + permission)
and `getAcl($scheme)` (scheme `options.ACL`, else `private`).

## Extension points

No `*.api.php` hooks and no new plugin type. To add another storage backend you'd write a
separate Flysystem `@Adapter` plugin (that is what this module is, for `s3`). To reuse the
credential cache, instantiate `AwsCacheAdapter` with a cache backend.
