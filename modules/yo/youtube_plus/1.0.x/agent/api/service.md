<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# YouTube Plus — API service, import flow, routes & Drush

## The two classes

- **`YouTubePlusUtils`** (`src/YouTubePlusUtils.php`) — thin wrapper over the Google API client. Its
  constructor builds a `Google_Client`, calls `setDeveloperKey($config->get('api_key'))` (config
  `youtube_plus.settings`) and instantiates `Google_Service_YouTube`. TLS/HTTP is handled entirely by
  the `google/apiclient` library (Guzzle) — the module sets no HTTP options. YouTube Data API v3
  endpoints it calls (each wrapped in try/catch that **returns** the `\Exception`, it does not throw):
  - `channels->listChannels('snippet,contentDetails,statistics', ...)` — by `id`
    (`getChannelInfo()`) or by `forUsername` (`getChannelByCustomUrl()`).
  - `playlists->listPlaylists('snippet,contentDetails', ...)` — `getChannelPlaylists()`, paginated
    (`maxResults` 50 + `pageToken` loop until `totalResults` reached).
  - `playlistItems->listPlaylistItems('snippet', ...)` — `getPlaylistItems()`, same pagination loop.

- **`YouTubePlusService`** (`src/YouTubePlusService.php`, service id **`youtube_plus.actions`**,
  args `@logger.factory`, `@config.factory`, `@entity_type.manager`) — orchestrates import/rollback
  and does all node/term create-or-update work. Field-name constants map API values onto the
  `ytp_channels` term fields.

## Import flow — `importChannel($channel)`

1. `getChannelInfo($channel->getId())`; if it returned an `\Exception` or has no items, show a
   messenger error and return.
2. Build the channel term data from the channel snippet/contentDetails/statistics (title,
   description, custom URL, channel URL, three thumbnails, the "uploads" playlist id, video count)
   and create-or-update a **`ytp_channels`** term (`entityGet` → `entityUpdate`/`entityCreate`,
   matched on `field_ytp_channel_id`).
3. Fetch the channel's **uploads** playlist items (`getPlaylistItems(uploads_id)`) and, per item,
   build node data (video id, title, description, watch URL, `publishedAt` → timestamp, thumbnails)
   and create-or-update a **`ytp_video`** node, deduped on `field_ytp_video_id` (`nodeGet`).
4. Fetch **all playlists** on the channel (`getChannelPlaylists`); per playlist create-or-update a
   **`ytp_playlists`** term, then fetch its items and create-or-update the corresponding `ytp_video`
   nodes, appending the playlist term to each node's `field_ytp_playlists` (dedup via
   `array_column(... 'target_id')`).

`importAll()` loops `importChannel()` over every `youtube_plus_channel` config entity.
`entityUpdate()`/`nodeUpdate()` diff each field and only `save()` when something changed.

## Rollback

- `rollbackChannel($channel)` — deletes the channel's `ytp_video` nodes (by `field_ytp_channel`
  term), then **all** `ytp_playlists` terms, then the matching `ytp_channels` term. (Contains a
  leftover `var_dump($channel->id())`.)
- `rollBack()` — deletes **all** `ytp_video` nodes and **all** `ytp_channels` / `ytp_playlists`
  terms site-wide. Called by `hook_uninstall()` and by the `youtubeplus:rollback` Drush command.
  All entity queries use `accessCheck(TRUE)`.

## Controller & routes (`youtube_plus.routing.yml`)

`YouTubePlusImport` (`src/Controller/YouTubePlusImport.php`, injects `youtube_plus.actions`):

- `youtube_plus.import_channel` — `/admin/config/services/youtube_plus/run/{channel}` → `run()` →
  `importChannel()`, then redirects to the channel list.
- `youtube_plus.rollback_channel` — `/admin/config/services/youtube_plus/rollback/{channel}` →
  `rollback()` → `rollbackChannel()`, then redirects.
- Both take a `{channel}` = `entity:youtube_plus_channel` upcast and require
  **`_permission: administer youtube plus`**. The list/add/edit/delete entity routes require the
  same permission; the settings route requires `administer site configuration`.

## Permission, cron & Drush

- **Permission** (`youtube_plus.permissions.yml`): one permission **`administer youtube plus`**
  ("Administer Youtube Plus", `restrict access: true`).
- **Cron** (`youtube_plus.module` → `youtube_plus_cron()`): loads every `youtube_plus_channel`
  entity and calls `youtube_plus.actions::importChannel()` on each — so all channels re-import on
  every cron run.
- **Drush** (`drush.services.yml` → `YoutubePlusCommands`, requires Drush ^10):
  - `youtubeplus:run` (aliases `ytp-run`, `youtubeplus-run`) — imports every configured channel.
  - `youtubeplus:rollback` (aliases `ytp-rb`, `youtubeplus-rollback`) — calls the service rollback.
