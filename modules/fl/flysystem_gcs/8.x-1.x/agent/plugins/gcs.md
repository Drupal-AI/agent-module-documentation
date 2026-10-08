<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `gcs` Flysystem plugin & adapter

Two classes, no other moving parts.

## Plugin: `GoogleCloudStorage`
`src/Flysystem/GoogleCloudStorage.php`, annotated `@Adapter(id = "gcs")`. Implements
`FlysystemPluginInterface` and `ContainerFactoryPluginInterface`; uses `FlysystemUrlTrait` (aliasing
`getExternalUrl` to `getDownloadUrl`) and `ImageStyleGenerationTrait`.

- **`create($container, $configuration, …)`** — pulls `bucket` out of the scheme `config`; splits off
  `_localConfig` and `unset()`s it from `$configuration`; throws `\InvalidArgumentException` if the
  bucket name is empty; then `new StorageClient($configuration)` and `$client->bucket($bucketName)`.
  The remaining `_localConfig` (`prefix`, `uri`) is handed to the constructor.
- **`getAdapter()`** — returns a `GoogleCloudStorageAdapter($client, $bucket, $prefix, $uri)`; on any
  exception returns `flysystem`'s `MissingAdapter` instead (so a broken scheme degrades rather than
  fatals).
- **`getExternalUrl($uri)`** — the URL policy:
  1. Resolve `$target = $this->getTarget($uri)`.
  2. If the target is under `styles/` and the file does not yet exist, generate the image derivative
     (`generateImageUrl()` if present, else `generateImageStyle()`).
  3. Read `$adapter->getVisibility($target)`. **If not `VISIBILITY_PUBLIC`, return
     `getDownloadUrl($uri)`** — i.e. the file is served through Drupal's own Flysystem download
     route, not a direct bucket link. Only public objects return `$adapter->getUrl($target)` (the
     direct GCS/CNAME URL).
- **`ensure($force = FALSE)`** — health check: returns an error entry if `$this->bucket->exists()` is
  false or a `GoogleException` is thrown; the message goes through `RfcLogLevel::ERROR`.

## Adapter: `GoogleCloudStorageAdapter`
`src/Flysystem/Adapter/GoogleCloudStorageAdapter.php`, extends Superbalist's `GoogleStorageAdapter`
(from `superbalist/flysystem-google-storage`). Overrides:

- **`has($path)`** — treats a path as existing only when exactly one entry in the parent directory's
  `listContents()` matches it (works around GCS's directory semantics).
- **`hasDirectory($path)`** — true when a `listContents($path)` entry is that path with `type === 'dir'`.
- **`getMetadata($path)`** — returns synthetic dir metadata (`type: dir`, request-time timestamp,
  `VISIBILITY_PUBLIC`) for directories; otherwise defers to `parent::getMetadata()`.
- **`getCachedResult($name, $arguments, $callback)`** — helper that memoises a callback's result in
  the default `\Drupal::cache()` bin under `"$name:arg,arg"`.

## Stream-wrapper behavior
The Flysystem module builds a stream wrapper per scheme, so `gcs`-driven schemes read/write through
`league/flysystem` → this adapter → `google/cloud-storage`. TLS to the GCS API is handled by the
`google/cloud-storage` client; this module sets no option that would disable certificate
verification. Standard Drupal file APIs, image styles, and media all operate against the scheme
transparently.
