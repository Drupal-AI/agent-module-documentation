<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# immich_integration — ImmichClient service

Service id: `immich_integration.client` (`\Drupal\immich_integration\Service\ImmichClient`).
Configured from `immich_integration.settings` (`server_url`, `api_key`). All requests send
`x-api-key: <api_key>` and `Accept: application/json`; every method returns the decoded array or
**NULL on failure** (errors are logged to the `immich_integration` channel).

```php
$immich = \Drupal::service('immich_integration.client');
if ($immich->testConnection()['success']) {
  foreach ($immich->getAlbums() as $album) {
    // $album['albumName'], $album['id'] ...
  }
}
```

## Method groups
- **Server:** `testConnection()`, `getServerVersion()`, `getServerConfig()`, `getServerFeatures()`, `getServerStats()`
- **Albums:** `getAlbums($params)`, `getAlbum($id)`, `createAlbum($name,$desc,$assetIds)`, `updateAlbum($id,$data)`, `deleteAlbum($id)`, `addAssetsToAlbum($id,$ids)`, `removeAssetsFromAlbum($id,$ids)`
- **Assets:** `getAssets($params)`, `getAsset($id)`, `updateAsset($id,$data)`, `deleteAssets($ids)`, `getAssetStatistics()`, `getAssetThumbnailUrl($id,$size)`, `getAssetUrl($id)`
- **Search:** `searchAssets($params)`, `searchPlaces()`, `getExploreData()`
- **Timeline:** `getTimelineBuckets($params)`, `getTimelineBucket($params)`
- **People:** `getPeople($withHidden)`, `getPerson($id)`, `updatePerson($id,$data)`
- **Shared links / tags / users / libraries / memories:** `getSharedLinks()`, `createSharedLink($data)`, `deleteSharedLink($id)`, `getTags()`, `createTag($name)`, `tagAssets($tagId,$ids)`, `getCurrentUser()`, `getUserPreferences()`, `getLibraries()`, `getLibraryStatistics($id)`, `getMemories()`

## Notes
- `getAssetThumbnailUrl()` / `getAssetUrl()` return URLs on the Immich server that themselves require authentication.
- TLS verification uses Guzzle defaults (enabled). The server URL is admin-configured.
