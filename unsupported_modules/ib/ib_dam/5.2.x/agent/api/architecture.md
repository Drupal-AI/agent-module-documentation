# ib_dam services & asset model

Concise map of the base module's programmatic surface (`src/`). Most of it is machinery the
submodules drive; you rarely call it directly.

## Services (`ib_dam.services.yml`)

| Service id | Class | Role |
|---|---|---|
| `ib_dam.api` | `IbDamApi` | Fetches remote IB resources over HTTP. `setSessionId($sid)` then `fetchResource($url, $useHeaders = TRUE)`; sends the IB session id as a `sid` header. Guzzle timeout from `Settings::get('intelligencebank_api_timeout', 120)`. Returns a PSR-7 response or NULL (errors logged). |
| `ib_dam.downloader` | `Downloader` | Downloads an IB resource to a local file (uses `ib_dam.api`, config, file system, uuid). |
| `plugin.manager.ib_dam.asset_validation` | `AssetValidationManager` | AssetValidation plugin manager — see [../plugins/asset-validation.md](../plugins/asset-validation.md). |
| `logger.channel.ib_dam` | core LoggerChannel | `ib_dam` log channel. |

## Asset object model (`src/Asset/`)

- `AssetInterface` / `Asset` — base asset value object; `Asset::createFromValues($data)` builds
  one from IB data; carries source type, type, storage type; `save()` persists via its storage.
- `EmbedAsset` / `EmbedAssetInterface` — an asset embedded by public CDN link.
- `LocalAsset` / `LocalAssetInterface` — an asset downloaded into a Drupal file.
- `IbDamResourceModel` — wraps a remote IB resource payload (`getName()`, `getUrl()`, `getType()`).

## Formatting & storage (pluggable, not Drupal plugin types)

- `src/AssetFormatter/` — `AssetFormatterManager` picks an `AssetFormatter` per asset/features:
  `EmbedImageAssetFormatter`, `EmbedVideoAssetFormatter`, `EmbedAudioAssetFormatter`,
  `EmbedLinkAssetFormatter`, `LocalAssetFormatter` (all off `AssetFormatterBase` /
  `EmbedAssetFormatterBase`). `AssetFeatures` describes what an asset supports.
- `src/AssetStorage/AssetStorageInterface` — where a saved asset lands; the concrete
  `MediaStorage` implementation ships in **ib_dam_media**.

## Field / render / theme

- Field formatter `ib_dam_embed` (`Plugin/Field/FieldFormatter/IbDamEmbedFormatter`, extends core
  `LinkFormatter`, for `link` fields) — adds a `no_link` setting.
- Render element / iframe app: `src/Element/IbIframeApp.php` (the in-page IB browser app).
- Theme hook `ib_dam_embed_playable_resource` (template
  `templates/ib-dam-embed-playable-resource.html.twig`) for playable audio/video embeds.

## Exceptions

`src/Exceptions/` — typed exceptions (`IbDamException` base) for download/storage/validation
failures (e.g. `AssetDownloaderBadRequest`, `AssetUnableSaveLocalFile`, `AssetValidationBadPluginId`).
