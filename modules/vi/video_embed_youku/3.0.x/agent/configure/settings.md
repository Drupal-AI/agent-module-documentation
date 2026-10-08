<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — settings

## Route
`video_embed_youku.settings` → `/admin/config/media/video-embed-youku`
(`_form: SettingsForm`, `_permission: administer site configuration`). Also linked in the admin menu
under Configuration → Media.

## Config object `video_embed_youku.settings`
Schema in `config/schema/video_embed_youku.schema.yml`; defaults in `config/install`.

| Key | Type | Default | Notes |
|---|---|---|---|
| `api_client_id` | string | `''` | Youku open-platform API Client ID (from https://open.youku.com/). Required on the form. Only needed for title/description/thumbnail lookup — the player embeds without it. |
| `api_cache_duration` | integer | `3600` | Seconds to cache each video's API response. Form enforces 60–86400. |

## Behavior
- With no `api_client_id`, `oEmbedData()` short-circuits: logs a warning, shows a warning message to
  the editor, and returns NULL — so `getName()`/`getDescription()`/`getRemoteThumbnailUrl()` fall back
  to defaults but the iframe still renders.
- API responses are cached in `cache.default` under key `video_embed_youku:<video_id>`, tag
  `video_embed_youku`, for `api_cache_duration` seconds. Clear that tag (or the default cache) to refresh.

## Drush / config set
```
drush cset video_embed_youku.settings api_client_id 'YOUR_CLIENT_ID'
drush cset video_embed_youku.settings api_cache_duration 3600
```

## Usage after config
Add a **Video Embed** field (from video_embed_field) to a bundle, then paste a Youku URL such as
`https://v.youku.com/v_show/id_XNDQ2NjQwMjQw.html`. The provider extracts the id and renders the player.
