# Services & the asset pipeline

Declared in `ib_dam.services.yml`.

| Service id | Class | Role |
|---|---|---|
| `ib_dam.api` | `Drupal\ib_dam\IbDamApi` | HTTP client for the DAM. Fetches remote files/thumbnails from IB, sending the IB session id as the `sid` request header. |
| `ib_dam.downloader` | `Drupal\ib_dam\Downloader` | Uses `ib_dam.api` to stream an asset (or its thumbnail) to an unmanaged local file. |
| `plugin.manager.ib_dam.asset_validation` | `Drupal\ib_dam\AssetValidation\AssetValidationManager` | Plugin manager for `IbDamAssetValidation` (see plugins/asset-validation.md). |
| `logger.channel.ib_dam` | (factory) | Log channel `ib_dam`. |

## IbDamApi (`ib_dam.api`)

```php
$api = \Drupal::service('ib_dam.api');
$response = $api
  ->setSessionId($sid)                 // IB session token, put in the `sid` header
  ->fetchResource($url);               // GET $url with headers; returns PSR-7 response or NULL
$thumb = $api->fetchResource($thumbUrl, FALSE); // FALSE = no `sid` header (for public thumbnails)
```

- The Guzzle client is built from `http_client_factory->fromOptions(['timeout' => Settings::get('intelligencebank_api_timeout', 120)])`.
- `fetchResource()` returns `NULL` and logs an `AssetDownloaderBadRequest` on a Guzzle `RequestException`
  or an empty URL. It does **not** throw.

## Downloader (`ib_dam.downloader`)

- `download(AssetInterface $asset, string $upload_dir): string|false` — GETs `$asset->source()->getUrl()`
  (with the asset's session id) and saves the body via `FileSystem::saveData()` under `$upload_dir`,
  filename from `$asset->source()->getFileName()`, with `FileExists::Rename`.
- `downloadThumbnail(AssetInterface $asset, string $upload_dir): string|false` — GETs
  `$asset->source()->getThumbnail()`; on failure copies the module's `logo.png` as a fallback thumbnail.
  Derives extension/type from the response `Content-Type`.
- `Downloader::getSourceTypeFromMime($mime)` (static) — maps a MIME type to an asset type
  (`image`/`file`/`video`/`audio`), demoting `image/vnd.*`, `image/svg+xml`, `image/webp`, and any
  format unsupported by the site image toolkit to `file`.
- Note (bug, harmless): the constructor reads `$config_factory->get('id_dam.settings')` — a typo for
  `ib_dam.settings` — so `$this->config` is an empty (non-existent) config object; it is never used.

## The asset model & save pipeline

Selecting an asset in the iframe app posts back a JSON item; the flow builds these objects:

1. **`IbDamResourceModel`** (`src/IbDamResourceModel.php`) — value object over one app response item.
   Reads `download_url`/`url`, `type` (MIME), `name`, `filetype`, `thumbnail`, `action`,
   `description`, width/height. `action == 'resource_link'` ⇒ `resourceType = 'embed'` (uses the public
   `url`); otherwise `'local'` (uses `download_url`). The IB **session id is parsed from the URL's
   `sid` query param** (`extractSessionId()`), not stored in Drupal config.
2. **`Asset`** (`src/Asset/Asset.php`, abstract) — `Asset::createFromSource(IbDamResourceModel, $owner_id)`
   builds either an **`EmbedAsset`** (holds the remote URL, always previewable) or a **`LocalAsset`**
   (wraps a new unsaved `File` entity pointing at the download URL). `createFromValues(array)` rebuilds
   an asset from stored field values (used by the field formatter and the wysiwyg migration).
   `save()` validates + saves the thumbnail then delegates to a **storage handler** whose class is the
   first `:`-delimited segment of the asset's `storageType` (e.g. `ib_dam_media`'s `MediaStorage`).
3. **`LocalAsset::saveAttachments()` / `EmbedAsset::saveAttachments()`** — call the Downloader to fetch
   the file and/or thumbnail into the upload dir before the entity is saved.

Asset types & validators: `LocalAsset` applies `validateFileExtensions` + `validateFileDirectory`;
`EmbedAsset` applies `validateIsAllowedResourceType`. See plugins/asset-validation.md.

Exceptions live under `src/Exceptions/` (all extend `IbDamException`, which logs to the `ib_dam`
channel and can `displayMessage()`): `AssetDownloaderBad{Request,Response,Destination}`,
`AssetUnableSave{LocalFile,ThumbnailFile}`, `AssetUnableCreateStorageHandler`, `AssetValidationBadPluginId`.
