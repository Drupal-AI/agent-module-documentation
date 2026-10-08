<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Varnish cache — agent index

Integrates Drupal with a Varnish reverse proxy: emits cache headers, invalidates content by cache
tag via **BAN** requests, and supports **ESI** for per-user fragments. One config object drives
everything: `adv_varnish.cache_settings`. Core requirement: `^10.1 || ^11 || ^12`. This is the
**4.2.x** branch (installed release 4.2.0); behavior matches 4.1.x — a maintenance/version bump with
the same routes, permissions, config schema and services.

- **Settings (general / available / cache_control / redirect keys), the form, purge & deflate forms, permissions** →
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
  url_filter_rules, deprecated excluded_urls), `cache_control` (anonymous, authenticated).
- `general.varnish_server` = one or more **space-separated** hosts; each is BANned in turn and gets
  an `http://` prefix if it has no scheme.
- Two "Redirect" flags are stored in **state**, not config: `adv_varnish__redirect_forbidden`
  (default FALSE), `adv_varnish__redirect_forbidden_nocookie` (default TRUE).
- Service `adv_varnish.cache_manager` is tagged `cache_tags_invalidator`; it BANs tags on the Varnish
  server(s), but only when `general.varnish_purger` is TRUE. Purge requests use short Guzzle timeouts
  (5s / 2s connect).
- ESI routes are static in `adv_varnish.routing.yml`:
  `adv_varnish.esi_user_block` → `/adv_varnish/esi/user_blocks/{block_id}` (`UserBlocksController`),
  `adv_varnish.esi_block` → `/adv_varnish/esi/block/{block_id}` (`ESIBlockController`); both
  `_permission: 'access content'`, `no_cache: TRUE`.
- Plugin type `user_blocks`: namespace `Plugin/UserBlocks`, manager `plugin.manager.user_blocks`,
  base `UserBlockBase`, interface `UserBlocksInterface`, attribute `Attribute\UserBlocks` (legacy
  annotation `Annotation\UserBlocks`), alter hook `adv_varnish_user_blocks_info`.
- Permissions: `administer advanced varnish configuration` (restricted), `bypass advanced varnish cache`.
- Manual purge / deflate forms exist only when `general.varnish_purger` is enabled (dynamic routes
  via `RouteSubscriber`; disabled state registers the routes with `_access: 'FALSE'`).
- Hooks live in `src/Hook/*` (OOP `#[Hook]` attributes) with `#[LegacyHook]` shims in
  `adv_varnish.module`; requirements in `src/Hook/AdvVarnishRequirements.php` (`#[Hook('runtime')]`
  via `LegacyRequirementsHook` shim in `adv_varnish.install`) flag a **BigPipe conflict** at runtime.
- Node-type TTL override via `hook_form_node_type_form_alter` (`adv_varnish` third-party settings
  `override` + `ttl`). Placed-block ESI opt-in via `CacheBlockForm` (`cache.esi` / `cache.ttl` /
  `cache.cachemode`). Update hook `adv_varnish_update_10001` migrates `excluded_urls` →
  `url_filter_rules` and sets `url_filter_mode` = `blacklist`. No Drush commands.
- Ships `varnish/default.vcl` (VCL 4.0) as the reference reverse-proxy config; BAN endpoints are
  gated in the VCL by an `internal` ACL plus the shared secret.
