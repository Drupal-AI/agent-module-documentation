Adds a Wistia provider to the [Video Embed Field](https://www.drupal.org/project/video_embed_field) module so editors can paste a Wistia video URL into a video embed field and have it render as a responsive Wistia iframe.

---

The module is a single provider plugin (`Wistia`, id `wistia`) that extends `video_embed_field`'s `ProviderPluginBase`. It teaches Video Embed Field how to recognise Wistia URLs, build the embed markup, and fetch a remote thumbnail. `getIdFromInput()` matches URLs on `wistia.com`, `wi.st`, and `wistia.net` (including `/medias/`, `/embed/iframe/`, and `/embed/` path variants) with a regex and extracts the alphanumeric media id. `renderEmbedCode()` returns a `video_embed_iframe` render element pointing at `https://fast.wistia.com/embed/iframe/{id}`, passing `autoPlay` and `muted` query flags (both driven by the field's autoplay setting) and width/height/frameborder/allowfullscreen/`wistia_embed` class attributes. Thumbnails and the video title come from Wistia's oEmbed endpoint (`https://fast.wistia.net/oembed?url=...`) via the base class's `downloadJsonData()`/`oEmbedData()` — `getRemoteThumbnailUrl()` returns `thumbnail_url` and `getName()` returns the oEmbed `title`. There is no configuration UI (`configure` is null), no permissions, no config schema, and no services — once enabled, "Wistia" is simply an available provider anywhere a Video Embed Field is used (field widget, formatter, WYSIWYG embed button, Media source via video_embed_media, etc.).

---

- Embed a Wistia-hosted video by pasting its URL into a Video Embed Field.
- Accept Wistia share links in the `https://<sub>.wistia.com/medias/{id}` form.
- Accept direct Wistia iframe embed URLs (`/embed/iframe/{id}`).
- Accept short `wi.st` Wistia links.
- Accept `wistia.net` URLs.
- Render a Wistia video as a responsive, full-screen-capable iframe.
- Auto-play (and auto-mute) an embedded Wistia video via the field's autoplay setting.
- Pull the Wistia video's poster/thumbnail image automatically for teaser displays.
- Use the Wistia video's own title as the accessible iframe `title` attribute.
- Provide a Wistia option in the Video Embed Field WYSIWYG "Embed video" dialog.
- Combine Wistia videos with other providers (YouTube, Vimeo) in one video field.
- Back a Media type with Wistia videos when paired with `video_embed_media`.
- Control iframe width/height through the Video Embed Field formatter settings.
- Show a Wistia thumbnail that links to the full video (image-to-video formatter).
- Localise/format the rendered title through Video Embed Field's title options.
- Migrate marketing videos hosted on Wistia into Drupal content without custom code.
- Display Wistia product/demo videos on landing pages via a video field.
- Let editors switch a video between YouTube and Wistia just by changing the URL.
- Validate that a pasted URL is a supported Wistia link before saving the field.
- Serve Wistia thumbnails through Drupal's image pipeline for teaser cards.
- Add Wistia support to an existing Video Embed Field site by enabling one module.
