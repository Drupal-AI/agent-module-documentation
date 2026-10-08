<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Kaltura Video Embed Field (video_embed_kaltura) — agent index

Kaltura provider for Video Embed Field. Version **2.0.0**. Depends on `video_embed_field`.

- **Provider**: `Kaltura` (`@VideoEmbedProvider id="kaltura"`). `getIdFromInput()` requires a valid URL
  whose host ends in `kaltura.com`, then extracts the entry ID from `id`/`media`/`entry_id` segments.
- **Embed**: `renderEmbedCode()` returns an `html_tag` iframe; `src` built by `sprintf` from config
  (partner_id, uiconf_id) + constrained entry ID — attributes escaped, no raw XSS sink, no SSRF.
- **Config**: `/admin/config/media/kaltura-config` (perm `kaltura settings`) sets partner/uiconf IDs.
- **Smells**: `getEditable()` used for read; hardcoded thumbnail partner ID.
