CKEditor 5 YouTube adds a toolbar button to CKEditor 5 that lets content authors embed a YouTube video by URL, inserting a responsive iframe (or a lite-youtube web component) directly into the rich-text body.

---

The module registers a CKEditor 5 plugin (`ckeditor5_youtube_embed_youtubeembed`, label "YouTube embed") whose toolbar item `youtubeEmbed` opens a small form to paste a YouTube URL; the JS (built from `js/ckeditor5_plugins/youtubeembed/`, shipped as `js/build/youtubeembed.js`) inserts the video markup. Server-side, `src/Plugin/CKEditor5Plugin/Youtube.php` implements `CKEditor5PluginElementsSubsetInterface` and `CKEditor5PluginConfigurableTrait`: it always allows an `<iframe>` whose `src` is restricted to `https://www.youtube.com/*`, `https://youtube.com/*`, or `https://m.youtube.com/*`, plus `<lite-youtube>`, and lets an admin choose which **optional iframe attributes** are permitted (align, frameborder, height, width, longdesc, name, scrolling, tabindex, title, allowfullscreen, referrerpolicy, allow, class). Four of those (align, frameborder, longdesc, scrolling) are flagged *deprecated* and excluded from the default config; the default allows the rest. The chosen attributes drive both the editor's allowed-elements subset and the text-format filter's allowed HTML, so the embed survives text filtering. Configuration is per text format: enable the plugin's toolbar button on a CKEditor 5 format at *Configuration → Content authoring → Text formats and editors*, and the attribute checkboxes appear in the plugin settings (config schema `ckeditor5.plugin.ckeditor5_youtube_embed_youtubeembed`, key `enabled_optional_attributes`). A bundled `lite-youtube` web component (`js/vendor/lite-youtube.js`, attached site-wide via `hook_page_attachments`) renders `<lite-youtube>` embeds as lightweight, click-to-load players; responsive CSS ships in `css/youtube.responsive.css`.

---

- Let editors embed a YouTube video into body content by pasting its URL.
- Add a dedicated YouTube button to the CKEditor 5 toolbar of a text format.
- Insert responsive YouTube iframes that scale with their container.
- Restrict embeds to youtube.com / m.youtube.com URLs (src is allow-listed).
- Use the lightweight `<lite-youtube>` click-to-load player instead of an eager iframe.
- Control which optional iframe attributes editors may set per text format.
- Enable `allowfullscreen` so embedded videos can go fullscreen.
- Allow the `title` attribute on embeds for accessibility.
- Set explicit `width`/`height` on the embedded iframe when needed.
- Add a `class` (e.g. `youtube-embed-responsive`) to embeds for custom styling.
- Avoid deprecated attributes (align, frameborder, longdesc, scrolling) that are off by default.
- Configure the `allow` attribute (e.g. permission policy) on YouTube iframes.
- Set `referrerpolicy` on embeds to control referrer leakage to YouTube.
- Provide a consistent video-embedding UX across multiple text formats.
- Give a marketing/blog format YouTube embedding without allowing arbitrary iframes.
- Keep embedded video markup intact through the text-format filter (allowed HTML is derived from the plugin).
- Embed tutorial or product videos inline in articles.
- Add video to landing-page body fields edited with CKEditor 5.
- Offer a per-format toggle so only chosen formats gain the YouTube button.
- Render lazy-loading YouTube players to reduce initial page weight (lite-youtube).
