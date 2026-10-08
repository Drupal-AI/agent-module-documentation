<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# (ADFS) CDN Integration (advanced_filesystem_cdn) — agent index

Rewrites public file URLs to a CDN base URL via `hook_file_url_alter`, exposes a `|adfs_cdn_url`
Twig filter/function, and purges CDN caches through provider-aware APIs. Works standalone. Package
`Advanced Filesystem`. Depends only on core **`file`**. Core `^10 || ^11 || ^12`. GPL-2.0-or-later.
Version 1.0.27 (version-dir 1.0.x).

- **Rewriting settings, purge providers, routes, services, the Twig filter and the queue worker** →
  [config/settings.md](config/settings.md)

## What it actually is

- **Rewriter service** `advanced_filesystem_cdn.rewriter` → `Service\CdnUrlRewriterService`
  (`rewriteUrl()`, `rewriteUri()`, `isEnabled()`, `getPublicFilesPath()`; per-request config cache).
  `.module` `hook_file_url_alter()` calls it for every generated file URL.
- **Purge service** `advanced_filesystem_cdn.purge` → `Service\CdnPurgeService`
  (`purgeUrls()`, `purgeAll()`, `purgeFile()`, `buildCdnUrls()`); provider handlers for cloudflare,
  bunnycdn, fastly, cloudfront (native SigV4), generic HTTP PURGE. `.module` `hook_file_update()`
  / `hook_file_delete()` auto-purge when enabled (sync or queued).
- **Twig extension** `advanced_filesystem_cdn.twig_extension` → `TwigExtension\AdfsCdnTwigExtension`
  — filter and function `adfs_cdn_url` accepting a URI, absolute URL or file entity.
- **Queue worker** `Plugin\QueueWorker\CdnPurgeQueueWorker` (id `advanced_filesystem_cdn_purge`,
  cron 30 s).
- **Forms/controllers** `Form\CdnSettingsForm`, `Form\CdnPurgeForm` (purge by URL / URI / FID / all),
  `Controller\CdnCredentialTestController` (JSON connectivity test), `Controller\CdnPurgeLogController`.
- Config object **`advanced_filesystem_cdn.settings`** (schema in `config/schema/`), DB table
  **`adfs_cdn_purge_log`** (created by `.install` / `update_9001`), one permission
  **`administer advanced_filesystem_cdn`** (`restrict access: true`). No entities, no Drush.

## Routes (all `_permission: 'administer advanced_filesystem_cdn'`, `_admin_route`)

Base `/admin/config/media/advanced_filesystem/cdn`:
`.settings` (``), `.purge` (`/purge` form), `.test_credentials` (`/test-credentials`, GET, adds
`_csrf_token: 'TRUE'`, returns JSON), `.purge_log` (`/purge-log`).
