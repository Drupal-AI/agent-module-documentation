<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Instagram Media renders a business/creator Instagram account's recent posts in a Drupal block. On block save (and again on cron) it calls the Facebook Graph API with a long-lived access token, downloads each post's media to `public://instagram_media/<block_id>/`, caches the metadata in two custom tables, and renders it through a Twig template with optional image styles, grid, Swiper and Fancybox.

Dependencies: core `block` only; talks to Graph API v22.0 over HTTPS. There is **no settings page** — everything is configured per block instance in Block layout (place the "Instagram Media Block"). The module defines one permission, one service, `hook_cron`, a theme hook, and an alter hook. No routes, no drush commands.

- **Place and configure the feed block (token, limit, styles, grid, swiper/fancybox)** → [blocks/instagram-media.md](blocks/instagram-media.md)
- **Full settings reference + config object / schema keys + set via drush/PHP** → [configure/settings.md](configure/settings.md)
- **Call the API client service directly / the Graph API flow + DB tables** → [api/service.md](api/service.md)
- **Cron sync, token auto-refresh, and the build alter hook** → [hooks/hooks.md](hooks/hooks.md)
- **The permission** → [permissions/permissions.md](permissions/permissions.md)
- **Theme hook, template variables, attached libraries** → [theme/theme.md](theme/theme.md)

Key facts:
- Block plugin id: `instagram_media` (admin_label "Instagram Media Block"), class `Drupal\instagram_media\Plugin\Block\InstagramMedia`
- Service id: `instagram_media.instagram_media_service` (class `InstagramMediaService`)
- Config object: `block.block.<id>` → `settings.*`; schema type `block.settings.instagram_media`
- Graph API base: `https://graph.facebook.com/v22.0/`
- DB tables: `instagram_media_posts`, `instagram_media_links`
- Media directory: `public://instagram_media/<block_id>/`
- Permission: `administer instagram media block`
- Cache tag: `instagram_media:media`
- Theme hook: `instagram_media_block`; alter hook: `hook_instagram_media_build_alter(&$build)`
- Library: `instagram_media/instagram` (CSS only); `swiper` / `fancybox` are pulled from the active theme
