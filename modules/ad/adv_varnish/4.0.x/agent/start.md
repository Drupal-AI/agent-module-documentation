<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Varnish cache — agent index

Integrates Drupal with a Varnish reverse proxy: emits cache headers, invalidates content by cache
tag via **BAN** requests, and supports **ESI** for per-user fragments. One config object drives
everything: `adv_varnish.cache_settings`.

- **Settings (general / available / cache_control keys), the form, purge & deflate forms, permissions** →
  [configure/settings.md](configure/settings.md)
- **The `cache_manager` service: BAN purging, tag invalidation, flush/deflate, ESI** →
  [api/cache-manager.md](api/cache-manager.md)
- **The `user_blocks` plugin type (ESI per-user content) and how to implement one** →
  [plugins/user-blocks.md](plugins/user-blocks.md)

Key facts:
- Configure route: `adv_varnish.config_form` → `/admin/config/development/adv_varnish`.
- Config `adv_varnish.cache_settings` sections: `general` (varnish_server, secret, noise,
  page_cache_maximum_age, grace, debug, logging, varnish_purger, purger_maintenance_mode),
  `available` (enable_cache, authenticated_users, esi, esi_purge_user_blocks, url_filter_mode,
  url_filter_rules), `cache_control` (anonymous, authenticated).
- Service `adv_varnish.cache_manager` is tagged `cache_tags_invalidator`; it BANs tags on the Varnish
  server, but only when `general.varnish_purger` is TRUE.
- Plugin type `user_blocks`: namespace `Plugin/UserBlocks`, manager `plugin.manager.user_blocks`,
  base `UserBlockBase`, interface `UserBlocksInterface`, alter hook `adv_varnish_user_blocks_info`.
- Permissions: `administer advanced varnish configuration`, `bypass advanced varnish cache`.
- Manual purge / deflate forms exist only when `general.varnish_purger` is enabled (dynamic routes
  via `RouteSubscriber`).
