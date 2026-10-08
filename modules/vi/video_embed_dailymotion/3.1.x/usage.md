Video Embed Field Dailymotion adds a single Dailymotion provider plugin to the [Video Embed Field](https://www.drupal.org/project/video_embed_field) module, so editors can paste a Dailymotion URL into a `video_embed_field` and have it render as a responsive Dailymotion iframe with a remote thumbnail.

---

The whole module is one `@VideoEmbedProvider` plugin (`Dailymotion`, extending `ProviderPluginBase`). It contributes no config, no permissions, no schema and no services — installing it simply makes "Dailymotion" appear in the list of allowed providers on any `video_embed_field` field. `getIdFromInput()` recognises `dailymotion.com/video/<id>`, `dailymotion.com/<id>`, embed URLs, and short `dai.ly/<id>` links via a regex, extracting the alphanumeric video id. `renderEmbed()` returns a `video_embed_iframe` render element pointing at `//www.dailymotion.com/embed/video/<id>` with width/height, autoplay, `loading` (lazy/eager), fullscreen and an optional `title` attribute. `getRemoteThumbnailUrl()` returns Dailymotion's thumbnail endpoint so Video Embed Field can download and cache a poster image. `getName()` fetches the video title from Dailymotion's public oEmbed endpoint (`/services/oembed`) to build accessible iframe titles. The deprecated `renderEmbedCode()` remains as a shim delegating to `renderEmbed()`. Configuration (dimensions, autoplay, lazy loading, thumbnails, allowed-provider restrictions) is entirely inherited from Video Embed Field's own field formatter/widget settings.

---

- Embed a Dailymotion video by pasting its URL into a Video Embed Field.
- Accept full `https://www.dailymotion.com/video/<id>` watch URLs.
- Accept short `https://dai.ly/<id>` share links.
- Accept Dailymotion `embed` URLs (`/embed/video/<id>`).
- Render the video as a responsive, fullscreen-capable iframe.
- Autoplay a Dailymotion embed when the field formatter enables autoplay.
- Lazy-load the Dailymotion iframe (`loading="lazy"`) to improve page performance.
- Download and cache a remote poster thumbnail for each Dailymotion video.
- Show the Dailymotion thumbnail in teaser/list views via Video Embed Field's thumbnail formatter.
- Set an accessible iframe `title` sourced from the video's real title (via oEmbed).
- Add Dailymotion to the allowlist of providers on a restricted `video_embed_field`.
- Mix Dailymotion videos alongside YouTube/Vimeo in the same field.
- Provide editors a paste-a-URL workflow instead of hand-writing embed markup.
- Use Dailymotion videos as a media source when combined with Video Embed Field's media integration.
- Control iframe width/height through the field's display formatter settings.
- Reference Dailymotion videos in Views that render the video field.
- Support content migrations that import Dailymotion video URLs into a video field.
- Keep third-party player markup out of the body by using a structured video field.
