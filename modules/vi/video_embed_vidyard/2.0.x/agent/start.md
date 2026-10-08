<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Video Embed Vidyard (video_embed_vidyard) — agent index

Vidyard provider for Video Embed Field. Version **2.0.0**. Depends on `video_embed_field`.

- **Provider**: `Vidyard` (`@VideoEmbedProvider id="vidyard"`). `getIdFromInput()` requires host to
  contain `vidyard.com` or the configured custom domain; ID regex group is `[_\-a-zA-Z0-9]+`.
  `additional_pattern` is `Html::escape()`-d before regex use.
- **Embed**: `html_tag` `script` with `src = //play.vidyard.com/{id}.js` — escaped attributes, no XSS
  sink, no SSRF. Loads remote Vidyard JS (third-party-script trust).
- **Config**: `/admin/config/media/video-embed-vidyard` (perm `administer video_embed_vidyard`).
