<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CrowdriffService API

Service id `crowdriff_api.crowdriff_service` (`Drupal\crowdriff_api\CrowdriffService`). Reads config from `crowdriff_api.settings` (`api_url`, `api_key_name`, `cache`, `cache_length`) and resolves the Bearer token from the named **Key** via `key.repository`.

Core call: `makeRequest($path, $cache_key, $method = 'GET', $params = NULL, $paging_key = NULL)` — sends `Authorization: Bearer <key>`, 15s connect/read/timeout, caches successful `data` in the `crowdriff` bin for `cache_length` minutes, and on failure falls back to stale cache and logs the API error.

Convenience wrappers:
- `getFolders($ids)`, `getAlbums($ids)`, `getApps($ids)`, `getCtas($ids)`.
- `getAssetsById($ids)`, `getAssetAnalytics($id)`, `getCtaAnalytics($id)`.
- `getAlbumsFromFolder($folder_id)`.
- `getAssetsFromAlbums($album_ids, $count, $paging_key)`, `getAssetsFromFolder(...)`, `getAssetsFromApp(...)` — POST `search`, return `['assets' => ..., 'paging_key' => ...]` and invoke `hook_crowdriff_api_alter_assets`.
- `getCount($path, $method, $params)` — total matched.

If no API key is configured the service warns (with a link to the config form) and returns empty. Implement `hook_crowdriff_api_alter_assets(&$assets)` to post-process asset arrays before rendering.
