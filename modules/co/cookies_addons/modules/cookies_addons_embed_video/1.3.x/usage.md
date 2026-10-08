<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cookies Addons Embed Video adds a "Block YouTube videos" text-format filter that stops YouTube video iframes in formatted text from loading until consent, using the COOKiES Video module's placeholder.

---

A submodule of Cookies Addons that depends on the COOKiES Video submodule (`cookies:cookies_video`). It provides one `@Filter` plugin, `CookiesAddonsEmbedVideoFilter` (id `cookies_addons_embed_video_filter`, `TYPE_TRANSFORM_IRREVERSIBLE`). `process()` loads the text with `Html::load()`, iterates `<iframe>` elements, and for each whose `src` matches `_cookies_addons_embed_video_is_youtube()` (a YouTube URL regex) it blanks `src`, copies the original to `data-src`, and adds the class `cookies-video-embed-field`. When any YouTube iframe was rewritten it attaches the `cookies_video/cookies_video_embed_field` library from the COOKiES Video module, which renders the consent placeholder and restores the video once the video service is consented to. Enable the filter in a text format's configuration. Update hook `cookies_addons_embed_video_update_8001()` fixes the historical mistyped filter id `cookies_addons_embed_viedeo_filter` in existing filter formats.

---

- Stop YouTube video embeds in body text from loading before consent.
- Enable the "Block YouTube videos" filter on any text format used for editorial content.
- Reuse the COOKiES Video module's placeholder and consent flow for YouTube.
- Cover both youtube.com and youtube-nocookie.com embed URLs.
- Pair with the embed-iframe filter (non-YouTube iframes) for complete embed coverage.
- Keep YouTube cookies off the page for GDPR/ePrivacy compliance.
- Gate videos authored in CKEditor without permanently altering the stored markup.
- Restore the video automatically once the visitor accepts the video service.
- Automatically repair the mistyped filter id from older installs via update hook 8001.
- Rely on COOKiES Video for the placeholder rather than shipping its own overlay.
