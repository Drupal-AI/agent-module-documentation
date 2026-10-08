# Services, plugins, and the API client

## Services (`media_acquiadam.services.yml`)

| Service | Class | Role |
|---|---|---|
| `media_acquiadam.auth` | `AcquiadamAuthService` | OAuth auth helper: `generateAuthUrl()`, `authenticate($code)`, `cancel($token)`, `getEndpoint()`. Holds the app `CLIENT_ID`/`CLIENT_SECRET` constants. |
| `media_acquiadam.client` | `Client` | Widen REST client, base `https://api.widencollective.com/v2`. Picks the per-user token (`user.data`) or the site `token` (CLI/cron only). |
| `media_acquiadam.acquiadam` | `Acquiadam` | Higher-level asset/category API over `Client` (`getAsset`, categories, search). |
| `media_acquiadam.asset_data` | `AssetData` | DB-backed per-asset key/value store (`backend_overridable`). |
| `media_acquiadam.asset_image.helper` | `AssetImageHelper` | Fetches/derives image files. |
| `media_acquiadam.asset_metadata.helper` | `AssetMetadataHelper` | Maps DAM metadata → media fields. |
| `media_acquiadam.asset_file.helper` | `AssetFileEntityHelper` | Downloads asset binaries into managed `file` entities. |
| `media_acquiadam.asset_media.factory` | `AssetMediaFactory` | Resolves media entities for assets. |
| `media_acquiadam.asset_refresh.manager` | `AssetRefreshManager` | Queues assets for refresh on the sync interval. |
| `media_acquiadam.field_cleanup` | `FieldCleanupService` | Removes orphaned asset-reference fields. |

## Plugins

- **Media source** `acquiadam_asset` (`src/Plugin/media/Source/AcquiadamAsset.php`, `@MediaSource`) — makes
  DAM assets Media entities; exposes DAM metadata as source fields.
- **Entity Browser widget** `acquiadam` (`src/Plugin/EntityBrowser/Widget/Acquiadam.php`) — the asset picker
  used inside Entity Browser / Media Library flows.
- **Linkit substitution** `dam_asset` (`src/Plugin/Linkit/Substitution/DAMAsset.php`) — deep links to DAM
  assets/files in rich text.
- **Queue workers**: `media_acquiadam_asset_refresh` (`AssetRefresh`) re-syncs queued assets;
  `media_acquiadam_integration_link_report` (`IntegrationLinkReport`) reports usage back to DAM.

## Auth flow (controllers)

- `AcquiadamAuthController::authenticate()` (route `media_acquiadam.user_auth`, `/user/acquiadam/auth`,
  `_user_is_logged_in: TRUE`): reads `code` + `uid` from the query, loads that user, exchanges the code via
  `AcquiadamAuthService::authenticate()`, and stores `{acquiadam_username, acquiadam_token}` in that user's
  `user.data`.
- `AcquiadamController` (`/acquiadam/asset/{assetId}`, `_user_is_logged_in: TRUE`) renders an asset-details page.
- `MigrationController` opens the guided migration modal/form.

## Programmatic use

```php
/** @var \Drupal\media_acquiadam\AcquiadamInterface $dam */
$dam = \Drupal::service('media_acquiadam.acquiadam');
$asset = $dam->getAsset($assetId);               // Entity\Asset

/** @var \Drupal\media_acquiadam\Service\AssetRefreshManagerInterface $rm */
$rm = \Drupal::service('media_acquiadam.asset_refresh.manager');
$rm->updateQueue();                              // enqueue assets due for refresh
```

Cron: `media_acquiadam_cron()` (in `.module`) drives `AssetRefreshManager` on `sync_interval`; the
`media_acquiadam_asset_refresh` queue then re-fetches each asset.
