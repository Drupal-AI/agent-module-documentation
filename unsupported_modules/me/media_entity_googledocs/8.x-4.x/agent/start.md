<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media entity GoogleDocs (media_entity_googledocs) — agent index

**Google Docs media source: parses published Google Docs/Sheets/Slides/Forms embed URLs (or iframe codes) and renders them via an iframe formatter.**

- **Version:** 8.x-4.x
- **Core:** ^8 || ^9 (verify before newer core)
- **Dependencies:** drupal:media (>= 8.4)
- **Media source:** `googledocs` (field types string/string_long/link); metadata `shortcode`/`type`/`id`
- **Validator:** `GoogleDocsEmbedCode` constraint (regex-matches docs.google.com published-embed URLs/iframes)
- **Formatter:** `googledocs_embed_generic` → `<iframe>` (width/height/scrolling/fullscreen)
- **Security:** No SSRF and no TLS concern — the module never fetches the URL server-side; PHP only runs `preg_match` and emits an `<iframe src>` for the client to load. The `src` comes from a regex-validated `docs.google.com/.../{doc|sheet|slide|form}/d/.../(pubhtml|embed|...)` capture. No routes/permissions/services/SQL. Residual risk is normal third-party embed trust; only editors who can create these media add embeds.

See [configure/media-source.md](configure/media-source.md)