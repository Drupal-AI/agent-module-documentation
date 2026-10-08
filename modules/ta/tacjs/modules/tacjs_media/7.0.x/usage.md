TacJS Media provides a consent-aware oEmbed field formatter (`tacjs_oembed`) that renders remote videos (YouTube, Vimeo, Dailymotion) through the TacJS / tarteaucitron.js consent gate instead of loading the third-party iframe immediately.

---

TacJS Media is a submodule of TacJS that bridges TacJS with Drupal core's Media / oEmbed. It defines a single field formatter plugin, `tacjs_oembed` ("oEmbed content (TacJS integration)"), which extends core's `OEmbedFormatter` and applies to `link`, `string` and `string_long` field types. Instead of emitting a ready-to-play `<iframe>`, `viewElements()` converts the element to a `<div>` carrying the provider-specific class (`youtube_player`, `dailymotion_player`, `vimeo_player`) and a `videoID` attribute extracted from the source URL, and drops the `src`. tarteaucitron.js then only instantiates the player after the visitor consents to that provider's service — so no cookies from the video host are set before consent. It requires both `tacjs` and the core `media` module. There is no configuration form; you use it by selecting the "oEmbed content (TacJS integration)" formatter on an oEmbed/remote-video field's *Manage display*, and enabling the matching service (youtube/vimeo/dailymotion) in TacJS.

---

- Embed a YouTube video that only loads after the visitor accepts YouTube cookies.
- Gate a Vimeo player behind tarteaucitron consent.
- Gate a Dailymotion player behind consent.
- Make remote-video Media fields GDPR-compliant without custom code.
- Replace the immediate oEmbed iframe with a consent placeholder that tarteaucitron manages.
- Extract the provider video ID automatically from a YouTube/Vimeo/Dailymotion URL.
- Apply the provider CSS class (youtube_player, vimeo_player, dailymotion_player) tarteaucitron expects.
- Use the consent-aware formatter on a core Media remote_video source field.
- Use it on a plain link field pointing at a video URL.
- Use it on a string / string_long field containing a video URL.
- Avoid setting third-party video cookies before the visitor opts in.
- Keep video markup accessible while deferring the actual player load.
- Combine remote video embedding with the site's existing TacJS consent banner.
- Switch a field's display from core oEmbed to the TacJS-integrated formatter per view mode.
- Ensure only visitors who accept the relevant service see the playable video.
- Comply with EU cookie law for embedded third-party video.
