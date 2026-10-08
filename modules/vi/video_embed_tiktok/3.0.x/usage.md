Video Embed TikTok adds TikTok as an embeddable video source for the Video Embed Field module. Paste a TikTok video URL into a video embed field and the module renders TikTok's official iframe embed and pulls the video's thumbnail from TikTok's oEmbed endpoint.

---

Video Embed TikTok is a small provider plugin for `video_embed_field`. It contributes one plugin, `TikTok` (`@VideoEmbedProvider` id `tiktok`), extending `ProviderPluginBase`. The plugin recognises TikTok video URLs of the form `https://www.tiktok.com/@user/video/{numeric-id}` (with optional `www.`, `http`/`https`, trailing slash, and query string), extracts the numeric video id, and outputs a `video_embed_iframe` render element pointing at `https://www.tiktok.com/embed/{id}` with `frameborder="0"` and `allowfullscreen`. In Video Embed Field 3.0.x it also sets a `title` attribute on the iframe for accessibility when a title format resolves. Remote thumbnails are retrieved by calling `https://www.tiktok.com/oembed?url={input}` and reading the returned `thumbnail_url`. The module has no settings form, no permissions, no Drush commands, and no config schema of its own; it is enabled and restricted purely through Video Embed Field's per-field "Allowed providers" list. Requires `drupal/video_embed_field:^3` and Drupal core `^10.3 || ^11`.

---

- Let editors embed a TikTok video simply by pasting its URL into a video embed field, with no manual iframe or shortcode.
- Add TikTok short-form video support to an existing site that already uses Video Embed Field for YouTube/Vimeo.
- Display TikTok videos in an article or blog body via a video embed field on the content type.
- Show a creator's TikTok clips on a landing page or campaign page built from fielded content.
- Render TikTok thumbnails in teaser/card view modes, using Video Embed Field's thumbnail formatter, then the full player on the full view.
- Build a curated feed or view of TikTok videos where each node stores one TikTok URL in a video embed field.
- Provide a lazy/colorbox-style thumbnail-to-iframe experience for TikTok using Video Embed Field's built-in field formatters.
- Restrict a specific field to only accept TikTok URLs by enabling just the "TikTok" provider in that field's Allowed providers.
- Allow marketing/editorial teams to add social video without touching TikTok's raw embed code or JavaScript SDK.
- Standardise how TikTok embeds are output site-wide (consistent iframe attributes and dimensions) via the field formatter settings.
- Combine TikTok with other Video Embed Field providers so one field accepts YouTube, Vimeo and TikTok links interchangeably.
- Populate a media/social wall that mixes TikTok clips with other embedded video sources.
- Store TikTok videos as structured field data (rather than free HTML) so they are searchable, migratable and theme-controlled.
- Set consistent player width/height for TikTok embeds through the video embed field's display formatter.
- Give editors accessible embeds automatically, since the iframe carries a `title` attribute derived from the configured title format.
- Use TikTok video thumbnails as responsive image sources elsewhere on the site once Video Embed Field imports the remote thumbnail.
- Migrate legacy hand-coded TikTok embeds into managed field values that render through a single, maintainable provider.
- Support content authors on decoupled/JSON:API sites by exposing the TikTok URL and derived embed data as field values.
- Add TikTok embedding to a paragraph type or media type that uses a video embed field.
- Enforce that only valid TikTok video URLs are accepted, since the provider only matches URLs containing `/@user/video/{id}`.
