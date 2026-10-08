# file_mdm — programmatic API

Inject `Drupal\file_mdm\FileMetadataManagerInterface` (service id same as interface; old
alias `file_metadata_manager` is deprecated).

## FileMetadataManagerInterface
- `has(string $uri): bool` — is a FileMetadata object already loaded for this URI.
- `uri(string $uri): ?FileMetadataInterface` — get (creating if needed) the metadata
  object for a file URI. Main entry point.
- `deleteCachedMetadata(string $uri): bool` — purge cached metadata for a URI.
- `release(string $uri): bool` — drop the in-memory object.

## FileMetadataInterface (per file)
Request metadata by plugin id (`getimagesize`, `exif`, `font`, …):
- `getMetadata(string $metadataId, mixed $key = NULL): mixed` — the value(s); `$key` for
  one entry (lazy-loads from file/cache on first call).
- `getSupportedKeys(string $metadataId, $options = NULL): array`
- `setMetadata()` / `removeMetadata()` — mutate in memory.
- `loadMetadata()` / `loadMetadataFromCache()` — populate.
- `saveMetadataToCache(string $metadataId, array $tags = [])` — cache it.
- `saveMetadataToFile(string $metadataId)` — write back to the file (EXIF supports this).
- `isMetadataLoaded()`, `getUri()`, `getLocalTempPath()`, `setLocalTempPath()`,
  `copyUriToTemp()`, `copyTempToUri()`.

```php
$fmm = \Drupal::service(FileMetadataManagerInterface::class);
$md  = $fmm->uri('public://photo.jpg');
[$width, $height] = $md->getMetadata('getimagesize');   // via base module
$orientation = $md->getMetadata('exif', 'Orientation'); // needs file_mdm_exif
```

Other services: `cache.file_mdm` (cache bin), `logger.channel.file_mdm`.
Alter hook for plugin discovery: `hook_file_metadata_plugin_info_alter()`.
