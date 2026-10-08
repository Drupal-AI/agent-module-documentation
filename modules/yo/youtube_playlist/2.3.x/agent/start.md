<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Youtube playlist (youtube_playlist) — agent index

**A YouTube playlist content entity + block that lists a playlist/channel's videos via the YouTube Data API.**

- **Version:** 2.3.x (2.3.1) · **Core:** ^8 || 9 || ^10.4 || ^11 · **Depends:** block, field, file, image, system
- **Configure:** `entity.youtube_playlist.settings` `/admin/structure/youtube-playlist` (`administer youtube playlist`, restricted).
- **Entity:** `YoutubePlaylist` (`@ContentEntityType`) with custom HTML route provider + list builder.
- **Block:** `YoutubePlaylistBlock` — fetches via `@http_client` from fixed host `https://www.googleapis.com` (`YoutubePlaylistBlock.php:147`), API key from block config.
- **Permission:** `administer youtube playlist` (restricted).
- **Security:** outbound URL is a hardcoded HTTPS host (no SSRF); TLS at Guzzle defaults (not disabled); API key is admin config. Admin routes permission-gated; no anonymous or mutating endpoints.
