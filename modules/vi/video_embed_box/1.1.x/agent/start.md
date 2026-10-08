<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Video Embed Field - Box.com provider (video_embed_box) — agent index
**A Video Embed Field provider plugin for Box.com shared-link videos.**

- **Version:** 1.1.x (info.yml `1.1.1`)
- **Core:** ^8.8 || ^9 || ^10 || ^11
- **Depends:** `video_embed_field`
- **Plugin:** `@VideoEmbedProvider(id="box")` — `src/Plugin/video_embed_field/Provider/Box.php`.
- **Surface:** provider plugin only — no routes, permissions, services, or config.
- **Security:** Embed URL built solely from regex-captured `domain`/`id` (both `[a-zA-Z0-9]` only), no arbitrary-host injection, no server-side fetch or TLS handling. No mutating endpoints.
