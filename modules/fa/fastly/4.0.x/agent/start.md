# Fastly — agent index

Integrates a site with the **Fastly CDN**: maps Drupal cache tags → Fastly Surrogate Keys,
purges (instant/soft), and configures edge features (stale content, image optimizer, edge modules,
webhooks, VCL). All settings in `fastly.settings` (+ `fastly.edge_modules.*`); UI under
`/admin/config/services/fastly` (route `fastly.settings`, permission `administer fastly`).
Real purging/VCL upload needs valid Fastly credentials + network; local config works without them.

- **Config keys, credential env vars, purge method, image optimizer, edge modules** →
  [configure/settings.md](configure/settings.md)
- **Drush purge commands** → [drush/purge.md](drush/purge.md)
- **Services (`fastly.api`, cache-tag hashing, surrogate keys, VclHandler, image formatter) + hook** →
  [api/services.md](api/services.md)

Key facts:
- `fastly.settings`: `api_key`, `service_id`, `site_id`, `purge_method` (`instant`/`soft`),
  `purge_logging`, `cache_tag_hash_length`, `stale_while_revalidate`(+`_value`),
  `stale_if_error`(+`_value`), `image_optimization`, `webp`(+`webp_quality`), `jpeg_quality`,
  `cookie_cache_bypass`, `webhook_enabled`/`webhook_url`.
- Env overrides: `FASTLY_API_TOKEN`, `FASTLY_API_SERVICE`, `FASTLY_SITE_ID`,
  `FASTLY_CACHE_TAG_HASH_LENGTH`.
- Drush: `fastly:purge:all` (`fpall`), `fastly:purge:url` (`fpurl`), `fastly:purge:key` (`fpkey`),
  `fastly:purge:service` (`fpservice`).
- Submodule **fastlypurger** integrates with the Purge module (see
  `../../modules/fastlypurger/4.0.x/`).
