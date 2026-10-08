<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Cloudflare Purge

Two admin forms plus one config object. Credentials form: `cloudflare_purge.form` →
`/admin/config/cloudflare-purge/credentials` (perm `administer cloudflare purge`). Auto-purge form:
`cloudflare_purge.settings` → `/admin/config/cloudflare-purge/settings`. Config object:
`cloudflare_purge.settings` (schema `config/schema/cloudflare_purge.schema.yml`).

## Credentials — three-tier resolution

`CredentialResolver` resolves each credential in priority order:

1. **`settings.php`** — `$settings['cloudflare_purge_credentials']` (highest).
2. **Key module** — the `*_key` config fields reference Key entities (only if `key` is enabled).
3. **Plain config** — the plain fields in `cloudflare_purge.settings` (lowest).

A **complete** settings.php set disables the on-screen credentials form
(`hasSettingsOverride()`); a partial set warns but leaves the form editable.

```php
// settings.php — Bearer Token (recommended)
$settings['cloudflare_purge_credentials'] = [
  'zone_id'      => '<32-hex zone id>',
  'bearer_token' => '<token with Zone > Cache Purge > Purge>',
];
// …or legacy Global API Key:
$settings['cloudflare_purge_credentials'] = [
  'zone_id' => '…', 'email' => 'you@example.com', 'authorization' => '<global api key>',
];
```

### Auth & storage config keys

| Key | Values / default | Meaning |
|---|---|---|
| `auth_method` | `bearer` (default) \| `legacy` | Bearer Token vs Email+API Key. |
| `storage_method` | `plain` (default) \| `key` | On fresh install, flipped to `key` if Key module present. |
| `zone_id` | string | Cloudflare Zone ID, validated `^[a-f0-9]{32}$`. |
| `bearer_token` | string | API token (bearer method). |
| `email`, `authorization` | string | Account email + Global API Key (legacy method). |
| `zone_id_key`, `bearer_token_key`, `email_key`, `authorization_key` | string | Key entity IDs when `storage_method: key`. |

## Auto-purge (opt-in) config keys

| Key | Default | Meaning |
|---|---|---|
| `auto_purge_enabled` | `false` | Purge Cloudflare when Drupal cache tags for selected entity types invalidate. |
| `auto_purge_entity_types` | `[node, taxonomy_term, media]` | Entity types whose tag invalidations trigger a purge. |
| `auto_purge_use_queue` | `false` | Defer purges to cron via a queue instead of purging inline. |
| `purge_everything_on_flush` | `false` | Purge the WHOLE zone on every full Drupal cache flush (`drush cr`). Heavy + rate-limited; off by default. |
| `queue_max_age_enabled` / `queue_max_age` | `false` / `900` | Discard queued items older than N seconds (edge TTL protection). |
| `tag_prefix` | `''` | Prefix added to tags (multi-site sharing one zone). |
| `rate_limit_enabled` / `rate_limit_per_minute` | `false` / `60` | Per-minute cap enforced in the `Purge` service (State API, **per-server** — see note). |
| `logging_enabled` | `false` | Log successful purges too (errors are always logged). Needed for full Purge History. |
| `history_limit` | `100` (max 1000) | Rows shown on the Purge History page. |

### Cache-Tag response header sizing

| Key | Default | Meaning |
|---|---|---|
| `auto_purge_filter_header_tags` | `true` | Emit only purgeable (entity-type) tags in the `Cache-Tag` header. |
| `auto_purge_hash_tags` | `false` | Hash tags in BOTH the header and the purge call (so they still match at Cloudflare). |
| `auto_purge_hash_length` | `16` (6–64) | Hashed tag length. |
| `auto_purge_header_max_bytes` | `7168` (1024–16384) | Cap the header so it stays under the ~8 KB server/CDN limit (avoids 5xx on tag-rich pages). |

The header is emitted by `EventSubscriber\CloudflarePurgeSubscriber`; the same `CacheTagFormatter`
(prefix + filter + optional hash + size guard) is used for the header and the tag-purge call so they
always agree.

## How auto-purge flows

`Cache\CloudflareCacheTagInvalidator` (service tag `cache_tags_invalidator`, priority `-100` so core
invalidation runs first) receives invalidated tags. Immediate mode purges via the `Purge` service;
queue mode merges tags into the deduplicated `cloudflare_purge_pending_tags` table (unique on a
SHA-256 of the tag). `hook_cron()` drains that table oldest-first into the `cloudflare_purge_tags`
queue in batches of `CloudflarePurgeApi::MAX_BATCH_SIZE` (100); the `CloudflarePurgeQueueWorker`
processes them. A successful "Purge Everything" records a timestamp so queued tag purges older than it
are skipped (content already gone).

## Setting config via Drush

```
drush cset cloudflare_purge.settings auto_purge_enabled true -y
drush cset cloudflare_purge.settings auth_method bearer -y
```

## Requirements / status

`hook_requirements` (runtime) reports whether credentials are configured and by which method, whether
Key is available, and whether auto-purge is on. Purge forms disable their submit button until
`hasCredentials()` is true.
