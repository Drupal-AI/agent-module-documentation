<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JW Platform Media Source (jw_player_media_source) — agent index

**Embeds JW Player (JW Platform v2 API) videos via a media source, field, block and CKEditor 5 plugin.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 || ^11 (deps: media, media_library, field, block, ckeditor5)
- **Config route:** `jwmedia.settings` → `/admin/config/media/jw-player-media-source` (perm `administer jw player media source`, restricted)
- **Routes:** `entity.jwmedia.collection` `/admin/content/jw-media`, `entity.jwmedia.modal` `/admin/content/jw-media-modal` (both perm `administer site configuration`)
- **Provides:** field type `JwVideoItem` + widget/formatter, block `JwVideoBlock`, CKEditor 5 plugin
- **External APIs:** `https://api.jwplayer.com/v2/...`, `https://cdn.jwplayer.com/...` (Bearer auth)

**Security:** all routes permission-gated; no anonymous or mutating public endpoints. The `'verify' => FALSE` at `src/Form/MediaViewForm.php:315,339` and `src/Form/JWPlayerMediaSourceSettings.php:195` sits **inside the `headers` array**, so it is an inert header — TLS verification stays ON (harmless bug, not a TLS finding).

See [configure/settings.md](configure/settings.md)
