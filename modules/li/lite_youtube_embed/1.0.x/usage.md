Lite YouTube embed provides an alternative field formatter that renders YouTube videos with Paul Irish's lightweight `lite-youtube` web component (a fast "facade" that loads the real YouTube iframe only on click) instead of Drupal's default oEmbed iframe, with automatic fallback to the normal oEmbed iframe for non-YouTube providers.

---

The module adds a single field formatter plugin, **`lite_youtube_embed`** ("Lite YouTube embed (with oEmbed fallback)"), applicable to `link`, `string` and `string_long` fields on **media** entities whose media type uses an **oEmbed** source (e.g. the standard Remote video type). For each value it resolves the oEmbed resource; if the provider is **YouTube** and it can parse an 11-character video id from the URL, it renders the `lite_youtube_embed` theme (`<lite-youtube videoid="…">`) and attaches the `lite_youtube_embed/lite_youtube_embed` library. For any other provider (Vimeo, etc.) or resource type it falls back to the core oEmbed iframe / link / photo rendering, so a generic remote-video bundle keeps working. The formatter exposes `max_width` and `max_height` settings that (per the field descriptions) apply only to the non-YouTube fallback. The `lite-youtube` JavaScript/CSS is **not bundled**: you must install Paul Irish's library into `/libraries/lite-youtube-embed/src` (manually or via Asset Packagist), as declared in `lite_youtube_embed.libraries.yml`. The benefit is performance — the page ships a tiny thumbnail facade instead of a heavy YouTube iframe until the visitor plays the video.

---

- Replace heavy YouTube iframes with a click-to-load facade for faster pages.
- Improve Core Web Vitals (LCP/TBT) on pages with embedded YouTube videos.
- Render Remote video media items with the `lite-youtube` web component.
- Keep Vimeo and other oEmbed providers working via the automatic iframe fallback.
- Use on any media type whose source is oEmbed (the formatter's `isApplicable` check).
- Defer loading of the real YouTube player until the user clicks play.
- Reduce third-party requests and cookies on initial page load from YouTube.
- Apply the formatter per view mode (teaser vs full) on a media display.
- Set max width/height for the non-YouTube oEmbed fallback.
- Show a lightweight thumbnail-based preview for YouTube in listings.
- Parse YouTube IDs from watch, youtu.be, embed, /v/ and /shorts/ URLs.
- Swap the default Remote video formatter to Lite YouTube embed on a site.
- Cut the JavaScript weight of pages heavy with video embeds.
- Provide a privacy-friendlier initial load (no YouTube iframe until interaction).
- Use Asset Packagist/Composer to install the lite-youtube library into /libraries.
- Style the video facade with the library's component CSS.
- Keep using Drupal's media oEmbed pipeline while changing only the render output.
- Fall back gracefully to a link or image when the oEmbed resource is not a rich video.
- Give editors the same media workflow with a faster front-end result.
- Standardise YouTube rendering across a site through one formatter choice.
- Avoid writing a custom formatter or Twig to embed the lite-youtube component.
- Combine with responsive layouts since the facade scales like the component allows.
