<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Video Embed Field Youku — agent index

A single Youku provider plugin for the Video Embed Field module. Editors paste a Youku URL into a
Video Embed field; the module renders a `player.youku.com` iframe and (with an API client id) fetches
title/description/thumbnail from the Youku API. Depends on `video_embed_field`. Config schema provided;
no permissions of its own; no Drush.

- **Admin settings: API client id, cache duration, config keys, route** →
  [configure/settings.md](configure/settings.md)
- **The `Youku` provider plugin: URL → id parsing, iframe embed markup, oEmbed/API + caching** →
  [api/provider.md](api/provider.md)

Key facts:
- Config object `video_embed_youku.settings`: `api_client_id` (string), `api_cache_duration` (int, default 3600).
- Settings route `video_embed_youku.settings` at `/admin/config/media/video-embed-youku`, permission `administer site configuration`.
- Provider plugin id `youku`; embed URL `https://player.youku.com/embed/<id>?autoplay=<0|1>`.
- Video id is validated `^[a-zA-Z0-9]+$` before use; emitted via a render-array `html_tag` (attributes escaped).
