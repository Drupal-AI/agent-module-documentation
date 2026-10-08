<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
URL To Video Filter turns a bare YouTube or Vimeo URL pasted into body text into an embedded player — no CKEditor plugin, no media entity, just a text filter that recognises the URL and replaces it with a responsive embed.

---

The module is a single filter plugin, `filter_url_to_video` (*Convert URLs to embedded videos*), declared with the modern `#[Filter]` attribute and backed by an injectable service that does the URL matching. Its settings are per text format and all start **off**: the `youtube` and `vimeo` toggles decide which providers are recognised (turn on at least one or nothing is converted), `autoload` decides whether the player `<iframe>` loads on page view or only after the visitor clicks the thumbnail (leaving it off is the lighter, privacy-friendlier choice — no third-party iframe until a click), and `youtube_webp_preview` swaps the YouTube thumbnail for a WebP image. The settings summary reports each provider as On or Off so a site builder can see at a glance what a format does. Styling comes from a small library with a compiled `url_to_video_embed.css` (SCSS source and source map included) and a `no-js.png` fallback image for browsers without JavaScript. Because it is a text filter, editors simply paste a URL on its own line and the rendered output contains the player; nothing changes in the stored content, so disabling the filter reverts to plain URLs. This 3.0.x branch supports YouTube and Vimeo only. One ordering caveat: if the format also uses "Limit allowed HTML tags" or core's "Convert URLs into links", this filter must run before those.

---

- Let editors embed a video by pasting its URL.
- Avoid teaching editors a CKEditor embed dialog.
- Embed YouTube videos in article bodies.
- Embed Vimeo videos in the same way.
- Use a WebP preview instead of loading the player immediately.
- Reduce third-party requests until a visitor clicks play.
- Keep the stored content as a plain URL.
- Turn embedding on for one text format only.
- Disable embedding without editing content.
- Provide a responsive video wrapper via the shipped CSS.
- Show a fallback image when JavaScript is unavailable.
- Speed up pages with many videos.
- Avoid media entities for one-off video embeds.
- Let comment authors embed videos where policy allows.
- Support both providers with independent toggles.
- Migrate legacy content containing bare video URLs.
- Keep video markup consistent across the site.
- Reduce editorial errors from hand-written iframes.
- Style embeds site-wide from one CSS file.
- Preview embedding behaviour per text format from the settings summary.
