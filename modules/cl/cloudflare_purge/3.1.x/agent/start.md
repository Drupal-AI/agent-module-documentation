<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cloudflare Purge — agent index

Purges Cloudflare's CDN cache from Drupal: manual (URL / tag / prefix / hostname / everything) via
admin forms + Drush, and automatic on Drupal cache-tag invalidation. Depends only on core `system`;
optional Key module for secret storage. Talks to hardcoded `api.cloudflare.com` over Guzzle.

- **Credentials (3-tier resolution, auth methods), auto-purge, queue, Cache-Tag header, every config
  key** → [configure/settings.md](configure/settings.md)
- **Drush commands (purge-all/url/tags/prefixes/hostnames/status + aliases)** →
  [drush/commands.md](drush/commands.md)
- **Services to call from code (`Purge`, `CloudflarePurgeApi`, `CredentialResolver`, formatter)** →
  [api/services.md](api/services.md)
- **The four permissions and which routes/ops they gate** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Configure route `cloudflare_purge.form` → `/admin/config/cloudflare-purge/credentials`. Admin section
  `/admin/config/cloudflare-purge` (neutral landing, reachable by any of the 4 permissions).
- Config object `cloudflare_purge.settings` (schema-defined): `auth_method` (bearer|legacy),
  `storage_method` (plain|key), credential + `*_key` fields, `auto_purge_enabled`,
  `auto_purge_entity_types`, `auto_purge_use_queue`, `purge_everything_on_flush`, `tag_prefix`,
  Cache-Tag header sizing, `rate_limit_*`, `logging_enabled`, `history_limit`.
- settings.php override: `$settings['cloudflare_purge_credentials'] = ['zone_id'=>…, 'bearer_token'=>…]`
  (or `email` + `authorization` for legacy). A COMPLETE set here disables the credentials form.
- Auto-purge: `Cache\CloudflareCacheTagInvalidator` (tag `cache_tags_invalidator`, priority -100) →
  immediate purge or dedup into `cloudflare_purge_pending_tags` table → `hook_cron` drains to queue
  `cloudflare_purge_tags` in batches of `CloudflarePurgeApi::MAX_BATCH_SIZE` (100).
- Security posture: CSRF on all forms, per-route permissions, Zone ID hex-validated, API host fixed to
  Cloudflare, rate limiting is per-server (State API).
- Version dir `3.1.x` (release 3.1.2).
