Youtube Gallery fetches the videos of a configured YouTube channel via the YouTube Data API v3 and displays them as a gallery block, with a per-video play page; it also has an optional OAuth-based flow for uploading a video from Drupal to YouTube.

---

You configure a Google API key, a YouTube channel ID (starting `UC…`), a maximum video count, and a sort order at `/admin/config/youtube_gallery/config` (stored in the `youtube_gallery.formsettings` config object). The `youtube_gallery.content` service (`YoutubeConfig`) converts the channel ID to its uploads playlist (`UC…` → `UU…`), calls the Data API `playlistItems` endpoint with `file_get_contents`, optionally sorts items by published date, and exposes helpers for total count, channel title, per-video duration and details. A "Youtube Gallery" block (`youtube_gallery_block`) renders the thumbnails/titles/durations, each linking to `/youtube-gallery/{vid}` (permission `access content`) which plays the selected video via the `youtube_gallery` theme/template. An admin status page at `/admin/config/youtube_gallery/manage` shows the current settings and detected channel. The optional upload feature (`/admin/config/youtube_gallery/upload-video`, `UploadVideoForm` + `UploadVideo` controller) requires the `google/apiclient` PHP library and OAuth client ID/secret; the library can be installed with `drush ytg:libraries` (downloads and extracts google-api-php-client into `libraries/`). All admin routes are gated by the `administer youtube_gallery` permission (`restrict access: TRUE`). Output is rendered through Twig templates you can override; the module ships no config schema and no submodules.

---

- Show a gallery of the latest videos from a specific YouTube channel on your site.
- Embed a "Youtube Gallery" block in any region via Block Layout.
- Limit how many videos are pulled and displayed (max videos setting).
- Sort displayed videos newest-first, oldest-first, or in YouTube's default order.
- Give each video a dedicated play page at `/youtube-gallery/{videoId}`.
- Display each video's thumbnail, title, and duration in the gallery.
- Pull videos automatically from a channel's uploads playlist without manually curating them.
- Show an admin status overview (API key, channel ID, total videos, channel name) at the manage page.
- Configure the integration with a Google Data API v3 key and channel ID through an admin form.
- Restrict all configuration/upload screens to trusted users via `administer youtube_gallery`.
- Override the `youtube-gallery.html.twig` / `youtube-gallery-block.html.twig` templates in your theme.
- Install the Google API PHP client library with a Drush command (`drush ytg:libraries [path]`).
- Upload a local video file (mp4/mkv) from Drupal to YouTube via the optional OAuth upload flow.
- Set title, description, tags, and category when uploading a video to YouTube.
- Use a Google OAuth client ID/secret to authorize the upload feature.
- Present a channel's content as an on-site gallery instead of linking out to YouTube.
- Provide a lightweight video landing experience without a full media/DAM stack.
- Localize/style the gallery with the module's CSS library and your own overrides.
- Reuse the `youtube_gallery.content` service programmatically to fetch channel videos in custom code.
- Build a channel-branded video wall for a marketing or community page.
