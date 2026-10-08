YouTube Plus imports the videos, channels and playlists of one or more YouTube accounts into Drupal content, using the official YouTube Data API v3 via the `google/apiclient` PHP library. Each imported video becomes a `ytp_video` node; each channel and playlist becomes a taxonomy term the videos reference, so you can list, filter and theme YouTube content with ordinary Drupal tools (Views, fields, view modes).

---

You configure a Google API key once (Configuration → Web services → YouTube Plus → Settings, config object `youtube_plus.settings`), then add one or more channels as lightweight `youtube_plus_channel` config entities — each identified either by a YouTube channel ID or by a legacy custom URL/username. Running an import (per channel from the admin list, in bulk via `drush youtubeplus:run`, or automatically on cron) calls the YouTube Data API to fetch the channel snippet/statistics, its "uploads" playlist items, and every playlist on the channel, then creates or updates a `ytp_video` node per video and a `ytp_channels`/`ytp_playlists` taxonomy term per channel/playlist. Videos carry the video ID, watch URL, description, published timestamp, and up to five thumbnail-size link fields, and reference their channel and playlist terms. A rollback (per channel, or in bulk via `drush youtubeplus:rollback`) deletes the imported nodes and terms. All admin/import/rollback routes are gated behind the restricted `administer youtube plus` permission (settings behind `administer site configuration`). The module ships the node type, both vocabularies, and all their fields as optional config, so the content model appears automatically when node/taxonomy/link are present.

---

- Mirror a brand's or organization's YouTube channel as a browsable video library of native Drupal nodes.
- Aggregate several YouTube channels into one site and keep each channel's content separable via the `ytp_channels` taxonomy.
- Build a "latest videos" or "videos by playlist" listing with Views over the `ytp_video` node type and its channel/playlist term references.
- Import a channel's full playlist structure so site visitors can browse videos grouped by playlist.
- Keep imported video metadata (title, description, published date, thumbnails) in sync by re-running the import; existing nodes are updated in place rather than duplicated.
- Schedule automatic re-imports of all configured channels on Drupal cron so new uploads appear without manual action.
- Run bulk imports of every configured channel from the command line with `drush youtubeplus:run` (aliases `ytp-run`, `youtubeplus-run`) in a deploy or scheduled job.
- Roll back all imported content with `drush youtubeplus:rollback` (aliases `ytp-rb`, `youtubeplus-rollback`) to reset before a clean re-import.
- Add a channel by its canonical channel ID (e.g. `UCAJALvsCWz8Kh6wOySHUJAA`) when you know it.
- Add a channel by legacy custom URL / username (e.g. `DrupalAssociation`) and let the module resolve the channel ID via the API.
- Display responsive video thumbnails by choosing among the imported default/medium/high/standard/maxres thumbnail link fields per view mode.
- Link each imported node straight to its YouTube watch page via the stored `field_ytp_url`.
- Segment content on multi-topic sites by rendering only videos referencing a chosen channel or playlist term.
- Feed imported video nodes into search, RSS, sitemaps, or JSON:API like any other Drupal content.
- Attach additional fields (tags, categories, editorial notes) to the `ytp_video` node type since it is a normal content type.
- Theme channel and playlist term pages (both vocabularies ship default and, for channels, custom URL / thumbnail fields) as landing pages for a channel's videos.
- Manage multiple channels from one admin list (Channel Name / Channel ID columns) with per-row Edit, Import, Rollback and Delete operations.
- Use imported published timestamps (`field_ytp_published`) to sort or filter videos chronologically in Views.
- Populate a video-gallery or grid layout backed entirely by imported YouTube data instead of hand-entered nodes.
- Track a channel's upload count via the `field_ytp_item_count` field on its channel term.
