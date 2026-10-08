<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Video Embed Twitter (video_embed_twitter) — agent index

Twitter/X video provider for Video Embed Field. Version **1.0.1**. Depends on `video_embed_field`.

- **Provider**: `Twitter` (`@VideoEmbedProvider id="twitter"`). `getIdFromInput()` regex accepts only
  `twitter.com/i/status/<numeric>`; ID is digits-only.
- **Embed**: `html_tag` iframe, `src = sprintf('https://twitter.com/i/videos/tweet/%s', id)` — escaped
  attributes, no XSS sink, no SSRF.
- **Note**: endpoint/URL pattern predates X changes; embeds may be stale. No security issue.
