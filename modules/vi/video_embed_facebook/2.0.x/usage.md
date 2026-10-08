Video Embed Facebook adds a Facebook provider to the Video Embed Field module, so a `video_embed_field` field can accept Facebook video URLs and render them as an embedded player with a remote thumbnail.

---

The module is a single provider plugin: `Facebook` (annotation `@VideoEmbedProvider(id = "facebook")`) extending Video Embed Field's `ProviderPluginBase`. Once enabled, any Video Embed Field (field type `video_embed_field`) recognises Facebook URLs alongside the built-in YouTube/Vimeo providers. `getIdFromInput()` extracts the numeric video id from URLs of the form `https://www.facebook.com/<page>/videos/<id>` or `https://www.facebook.com/video.php?v=<id>`; `renderEmbedCode()` outputs a `video_embed_iframe` render element pointing at `https://www.facebook.com/plugins/video.php?href=<url>` (with `autoplay` and `show_text=0` query params); and `getRemoteThumbnailUrl()` returns `https://graph.facebook.com/<id>/picture` so Video Embed Field can download and image-style the thumbnail. It has no configuration, no permissions, no Drush, no config schema, and defines no plugin types of its own — all field/widget/formatter/thumbnail behaviour comes from the parent Video Embed Field module; this module only teaches it about Facebook. NOTE (environment-specific): the shipped `Facebook::renderEmbedCode($width, $height, $autoplay)` signature is out of date relative to the installed Video Embed Field `ProviderPluginBase::renderEmbedCode($width, $height, $autoplay, $title_format = NULL, $use_title_fallback = TRUE)`, so loading the provider class raises a fatal on this site — see agent/plugins for detail.

---

- Let editors paste a Facebook video URL into a Video Embed Field and get an embedded player.
- Accept `facebook.com/<page>/videos/<id>` share URLs in a video field.
- Accept legacy `facebook.com/video.php?v=<id>` URLs in a video field.
- Show a Facebook video inside an article, page, or any content type with a video field.
- Display a Facebook video's thumbnail (via Graph API) with Drupal image styles.
- Autoplay an embedded Facebook video via Video Embed Field's formatter autoplay setting.
- Mix Facebook, YouTube and Vimeo videos in one Video Embed Field.
- Restrict a video field to only certain providers using Video Embed Field's allowed-providers setting.
- Render a Facebook video responsively using Video Embed Field's responsive iframe wrapper.
- Provide a lazy/thumbnail-first display of a Facebook video via the field's thumbnail formatter.
- Reuse an existing Video Embed Field configuration and simply add Facebook support.
- Populate a Facebook video field programmatically by storing the video URL as the field value.
- Migrate content that references Facebook videos into a Video Embed Field.
- Use a Facebook video field in Views alongside other media.
- Offer content authors a no-markup way to embed Facebook videos (no manual iframe code).
- Pull a poster image for a Facebook video automatically from the Graph API endpoint.
- Standardise Facebook video embedding across a site through one field type.
- Combine with Media if wrapping Video Embed Field in a media type.
- Let a single video field switch between video, thumbnail, or colorbox formatters for a Facebook video.
- Support both `www.` and non-`www.` Facebook video URLs.
