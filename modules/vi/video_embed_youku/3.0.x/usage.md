<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds Youku (优酷) as a video provider for the Video Embed Field module, so editors can paste a Youku video URL into a Video Embed field and get a responsive player plus (optionally) the remote title, description, and thumbnail via the Youku API.

---

The module ships one provider plugin, `Youku` (`@VideoEmbedProvider`), that plugs into Video Embed Field. `getIdFromInput()` parses a pasted URL with `parse_url`, walks the path segments, and extracts the id from the `id_XXXX` segment (stripping `id_` and `.html`); the id is accepted only if it matches `^[a-zA-Z0-9]+$`, otherwise the input is rejected. `renderEmbedCode()` returns an `iframe` render-array (`#type => html_tag`) whose `src` is `https://player.youku.com/embed/<id>?autoplay=<0|1>` — because `id` is validated to be alphanumeric and the value is emitted through a render array (attribute values are auto-escaped), there is no markup-injection surface. Thumbnail/title/description come from `oEmbedData()`, which calls the Youku open API (`https://api.youku.com/videos/show.json`) using a site-configured **API Client ID** and caches the JSON response in `cache.default` for a configurable duration (default 3600s, keyed by video id, tagged `video_embed_youku`). If no client id is configured the API calls are skipped (a warning is logged/shown) and the player still renders. A settings form at `/admin/config/media/video-embed-youku` (permission `administer site configuration`) stores `api_client_id` and `api_cache_duration` in `video_embed_youku.settings`. HTTP failures are caught and logged; the module uses Guzzle via dependency injection.

---

- Let editors embed Youku videos by pasting a `v.youku.com/v_show/id_XXXX.html` URL into a Video Embed field.
- Render a Youku player as a responsive iframe in content, using Video Embed Field's field formatter.
- Autoplay a Youku video where the field formatter requests it.
- Fetch and display the Youku video's title as the media name.
- Fetch and display the Youku video's description.
- Pull the Youku big thumbnail for use as the video preview image.
- Cache Youku API responses to avoid repeated remote calls (default 1 hour).
- Tune the API cache duration (60–86400s) to balance freshness against API load.
- Configure the Youku API Client ID obtained from the Youku Developer Portal.
- Support both `http://` and `https://` Youku URL forms when pasting.
- Gracefully render the player even when the API client id is missing (title/thumbnail simply omitted).
- Surface a warning to editors when the Youku API client id has not been configured.
- Log API/network errors to the `video_embed_youku` channel for debugging.
- Reject malformed or non-Youku input at the provider level (invalid id → field validation fails).
- Provide Chinese-platform video support alongside YouTube/Vimeo via the same Video Embed Field.
- Reuse the provider in any entity that has a Video Embed Field (nodes, media, paragraphs).
- Invalidate cached Youku metadata site-wide via the `video_embed_youku` cache tag.
- Combine with core Media / oEmbed workflows through Video Embed Field's media integration.
- Localize the admin settings form via standard Drupal translation.
- Serve the same embed across multiple display modes configured on the Video Embed field.
