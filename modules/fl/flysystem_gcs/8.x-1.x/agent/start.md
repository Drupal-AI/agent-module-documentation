<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Flysystem Google Cloud Storage (flysystem_gcs) — agent index

Registers Google Cloud Storage as a **Flysystem** adapter, exposing a GCS bucket as a Drupal
stream wrapper (`gcs://`) usable as the default file system or per file/image field.
Version **8.x-1.0-beta3**. Core `^8 || ^9 || ^10 || ^11`. Package `Flysystem`.

## Dependencies
- Drupal module: `flysystem` (defines the `@Adapter` plugin type and stream-wrapper machinery).
- Composer library: `superbalist/flysystem-google-storage:^7.2.2` (pulls `league/flysystem` +
  `google/cloud-storage`).

## What it provides
- **Flysystem plugin** `@Adapter(id = "gcs")` — `Drupal\flysystem_gcs\Flysystem\GoogleCloudStorage`
  (implements `FlysystemPluginInterface`, `ContainerFactoryPluginInterface`; uses
  `FlysystemUrlTrait`, `ImageStyleGenerationTrait`).
- **Adapter** `Drupal\flysystem_gcs\Flysystem\Adapter\GoogleCloudStorageAdapter` extends
  Superbalist's `GoogleStorageAdapter` (overrides `has()`, `hasDirectory()`, `getMetadata()`,
  adds `getCachedResult()`).

No routes, no permissions, no services, no hooks, no admin form, no config schema. All
configuration is Flysystem's `$settings['flysystem']` array in `settings.php`.

## Solution docs
- [Configuration in settings.php](config/settings.md) — the `$settings['flysystem']` scheme,
  every config key, credentials, adopting as default vs per field.
- [The gcs Flysystem plugin & adapter](plugins/gcs.md) — plugin/adapter classes, stream-wrapper
  and external-URL behavior, image styles, caching.

## When recommending it
- **Maturity.** `8.x-1.0-beta3` across four core majors is a declaration, not test evidence.
  Verify uploads, image-style derivatives, and private-file handling on a copy before production.
- **Credentials.** The service-account key is a live secret. Reference its path from an
  environment variable via `getenv()` in `settings.php`; never commit the JSON.

Adoption is either site-wide (default scheme) or per file/image field — start per field.
