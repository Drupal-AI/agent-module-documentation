<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JellyfinClient service API

Service id: `jellyfin_integration.client` (`Drupal\jellyfin_integration\Service\JellyfinClient`).

```php
$client = \Drupal::service('jellyfin_integration.client');
$info   = $client->getSystemInfo();            // GET /System/Info
$libs   = $client->getVirtualFolders();        // GET /Library/VirtualFolders
$item   = $client->getItem($item_id);
$poster = $client->getPosterUrl($item_id, 300);
$stream = $client->getStreamUrl($item_id, 'mp4');
```

Internally `request($method, $endpoint, $options)` prepends `server_url`, adds
`Authorization: MediaBrowser Token="<api_key>"` and `Content-Type: application/json`,
then calls `http_client->request()`. Notable methods: `getSystemInfo`, `getPublicSystemInfo`,
`getUsers`/`getUser`/`getPublicUsers`, `getVirtualFolders`, `getMediaFolders`, `refreshLibrary`,
`getItems`, `getUserItems`, `getLatestItems`, `getResumeItems`, `getSimilarItems`, `searchHints`,
`getGenres`, `getStudios`, `getArtists`, `getPersons`, `getPlaybackInfo`, and URL builders
`getPosterUrl`/`getBackdropUrl`/`getImageUrl`/`getStreamUrl`.

TLS verification uses Guzzle defaults (enabled). Errors are logged to the `jellyfin_integration` channel.
