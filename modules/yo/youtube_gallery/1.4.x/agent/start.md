# Youtube Gallery — agent index

Fetches a YouTube channel's videos via the Data API v3 and shows them as a block + per-video play
page. Optional OAuth flow uploads a local video to YouTube. All admin screens require the
`administer youtube_gallery` permission (`restrict access: TRUE`); the play page uses `access content`.

- **Settings form, config object, channel/API-key setup, OAuth upload prerequisites** →
  [configure/settings.md](configure/settings.md)
- **`drush ytg:libraries` — install the google/apiclient PHP library** →
  [drush/commands.md](drush/commands.md)
- **Theme hooks, templates, the gallery block, routes, and the `youtube_gallery.content` service** →
  [theming/templates.md](theming/templates.md)

Key facts:
- Config object: `youtube_gallery.formsettings` (`api_key`, `channel_id`, `max_videos`, `sort_order`,
  `client_id`, `client_secret`). No config schema shipped.
- Configure route: `youtube_gallery.config` → `/admin/config/youtube_gallery/config`.
- Permission: `administer youtube_gallery` (restricted) gates config/status/upload; play page
  `/youtube-gallery/{vid}` uses `access content`.
- Data flow: channel `UC…` → uploads playlist `UU…` → Data API `playlistItems` via `file_get_contents`.
- Upload feature needs `google/apiclient` (Composer or `drush ytg:libraries`) + OAuth client id/secret.
