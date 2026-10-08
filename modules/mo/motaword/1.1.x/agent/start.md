<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MotaWord (motaword) — agent index

CDN-backed site translation into 100+ languages via **MotaWord Active Serve**. Version **1.1.x**. Core `^9 || ^10 || ^11`, PHP `>=8.0`. No Drupal module dependencies; no external Composer libraries (uses core `http_client`).

Two translation strategies, chosen on the settings form as one "Translation mode" radio:
- **Browser** — inject the ActiveJS widget script into `<head>`; text is swapped client-side.
- **Server** — a `kernel.request` subscriber proxies locale-prefixed GET URLs (`/fr/about`) through Serve and replays the pre-translated HTML.

Configuration lives in `motaword.settings` (config route `motaword.settings` at `/admin/config/motaword`); project/widget metadata lives in the State API. Permission: `administer motaword` (`motaword.permissions.yml`). One menu link (`motaword.links.menu.yml`).

Services (`motaword.services.yml`): `motaword.serve_client` (ServeClient), `motaword.metadata_store` (MetadataStore), `motaword.metadata_refresher` (MetadataRefresher), `motaword.active_script_builder` (ActiveScriptBuilder), `motaword.url_allow_list` (UrlAllowList), `motaword.invalidation_manager` (InvalidationManager), `motaword.language_menu_manipulator` (LanguageMenuManipulator), plus event subscribers `callback_subscriber`, `proxy_request_subscriber`, `config_save_subscriber`, `config_import_guard_subscriber`, and a dedicated `logger.channel.motaword`.

Hooks (`motaword.module`): `hook_help`, `hook_page_attachments` (ActiveJS injection), `hook_cron` (background metadata load), `hook_entity_insert/update/delete` (cache purge), `hook_preprocess_toolbar` (mark admin UI `translate="no"`), `hook_preprocess_menu` (custom-switcher rewriting). `hook_uninstall` + `motaword_update_10001` in `motaword.install`.

Solution docs:
- [config/settings.md](config/settings.md) — settings form, config keys + schema, `settings.php` overrides, health checks, admin actions.
- [api/serve-client.md](api/serve-client.md) — ServeClient HTTP methods, MetadataStore, MetadataRefresher (fetch/cache/token model).
- [api/translation-delivery.md](api/translation-delivery.md) — proxy subscriber, UrlAllowList, ActiveScriptBuilder, menu manipulator, page attachments.
- [api/callbacks-and-invalidation.md](api/callbacks-and-invalidation.md) — dashboard callback, InvalidationManager, config-save + config-import-guard subscribers, entity hooks.
