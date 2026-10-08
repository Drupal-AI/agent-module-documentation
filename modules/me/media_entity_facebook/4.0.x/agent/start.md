<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Entity Facebook — agent index

A core Media source (`facebook`) for embedding Facebook posts/photos/videos, plus the `facebook_embed` formatter and a fetcher with SDK-embed and oEmbed-API modes. Depends on `media`. No permissions of its own, no Drush. Provides a config schema.

- **Settings (app id/secret, embedded-posts vs oEmbed mode) and how to set up the media type** → [configure/settings.md](configure/settings.md)
- **The media source plugin, fetcher, constraint, formatter, and output/XSS handling for custom code** → [api/media-source.md](api/media-source.md)

Key facts:
- Source plugin `facebook` (`src/Plugin/media/Source/Facebook.php`), source field type `string_long`, default thumbnail `facebook.png`.
- Formatter `facebook_embed` (field types `link`, `string`, `string_long`) — applicable only on `media` entities.
- Constraint `FacebookEmbedCode` requires value to resolve to a `facebook.com`/`fb.watch` URL.
- Fetcher `media_entity_facebook.facebook_fetcher`. `use_embedded_posts=true` (default) → JS SDK embed, no app review. `false` → `graph.facebook.com/v11.0/oembed_{post,video}` with `app_id|app_secret`, cached 10 min.
- Settings form route `media_entity_facebook.settings` at `/admin/config/media/facebook-settings`, permission `administer media`. `configure` is NOT set in info.yml.
- Config object `media_entity_facebook.settings`: `facebook_app_id`, `facebook_app_secret`, `use_embedded_posts` (default `true`).
