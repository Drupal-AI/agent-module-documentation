<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CDN Integration — rewriting, purging, Twig, routes

## Install / enable

`drush en advanced_filesystem_cdn` (only core `file` is required). `.install` `hook_schema()`
defines **`adfs_cdn_purge_log`** (id, provider, action, url, success, http_status, error_message,
timestamp); `update_9001()` creates it on existing sites. The table is also created lazily and every
write is guarded by `tableExists()`.

## Config object `advanced_filesystem_cdn.settings`

Install defaults (`config/install/…settings.yml`), schema in `config/schema/…schema.yml`:

- `enabled` (bool, false) — master switch for rewriting.
- `cdn_base_url` (string) — e.g. `https://cdn.example.com` (saved trimmed, no trailing slash).
- `cdn_path_prefix` (string) — optional prefix inserted after the base URL.
- `strip_files_path` (bool) — drop the public files path before building the CDN URL.
- `public_files_path_override` (string) — override the auto-detected `/sites/default/files`.
- `cache_bust_mode` (`none`|`timestamp`|`hash`) + `cache_bust_param` (string, `v`).
- `allowed_mime_prefixes` (sequence) — whitelist by MIME prefix (empty = rewrite all).
- `excluded_patterns` (string) — newline globs / path prefixes excluded from rewriting.
- `purge` (mapping): `provider` (`none`|`cloudflare`|`bunnycdn`|`fastly`|`cloudfront`|`generic`),
  `auto_on_update`, `auto_on_delete`, `use_queue`, and per-provider credential sub-mappings
  (`cloudflare.{api_token,zone_id}`, `bunnycdn.{api_key,pull_zone_id}`,
  `fastly.{api_key,service_id}`, `cloudfront.{access_key,secret_key,distribution_id}`,
  `generic.{method,headers,purge_all_url}`).

`Form\CdnSettingsForm` manages all of this, shows a live before/after URL preview and a status
banner, and offers a "Test credentials" link carrying a CSRF token to the test route. The CloudFront
secret is a `password` field preserved when left blank; on save it calls `rewriter->resetCache()`.

## Rewriting (`CdnUrlRewriterService`)

- `isEnabled()` — true when `enabled` and `cdn_base_url` is set.
- `rewriteUrl($url)` — parses the path from an absolute or root-relative URL; returns NULL unless
  the path starts with the public files path, passes the MIME whitelist (`isPathAllowed()`) and is
  not excluded (`isPathExcluded()`); then builds `cdnBase + [prefix] + relativePath`, optionally
  stripping the files path, and appends the cache-bust param (`buildBustValue()`: `hash` = 8-char
  md5 of the path, `timestamp` = file mtime else request time).
- `rewriteUri('public://…')` — maps a stream URI to its web path then calls `rewriteUrl()`.
- `getPublicFilesPath()` — override, else derive from `public://` realpath vs. DOCUMENT_ROOT,
  else `/sites/default/files`.

`.module` `hook_file_url_alter(&$uri)` calls `rewriteUrl()` and replaces the URL in place, so the
rewrite applies site-wide to core file-URL generation.

## Twig `adfs_cdn_url`

`AdfsCdnTwigExtension` registers both a filter and a function `adfs_cdn_url`. `cdnUrl($input)`
resolves the input to a URI (`resolveUri()` handles strings, `FileInterface`, entity-reference
items with `->entity`, field items with `->value`, arrays with `['value']`, `__toString`), then:
absolute URL ⇒ `rewriteUrl()` (or return as-is); `public://` ⇒ `rewriteUri()`; else fall back to
`file_url_generator->generateAbsoluteString()`.

## Purging (`CdnPurgeService`)

- `purgeUrls($urls)` — dispatches to the configured provider handler and writes an
  `adfs_cdn_purge_log` row; `purgeUrl()`, `purgeFile($file)` (builds the CDN URL first),
  `buildCdnUrls($file)`, `purgeAll()`.
- Handlers use Drupal's `@http_client`: **Cloudflare** POST `zones/{zone}/purge_cache`
  (`Authorization: Bearer`), **BunnyCDN** GET `api.bunny.net/purge` / POST pull-zone purgeCache
  (`AccessKey`), **Fastly** PURGE at the URL / POST `service/{id}/purge_all` (`Fastly-Key`),
  **CloudFront** POST an invalidation XML body signed with a native AWS SigV4 (`purgeCloudFront()`),
  **generic** the configured method (PURGE/BAN/DELETE) to each URL with optional JSON headers.
- Auto-purge: `.module` `hook_file_update`/`hook_file_delete` → `_advanced_filesystem_cdn_dispatch_purge()`
  which either enqueues `{urls}` or calls `purgeFile()` synchronously depending on `use_queue`.

`Plugin\QueueWorker\CdnPurgeQueueWorker` (id `advanced_filesystem_cdn_purge`) drains queued purge
items on cron. `Controller\CdnCredentialTestController::test()` returns
`{ok, message}` JSON per provider (CloudFront only validates field shape to avoid AWS charges).
`Controller\CdnPurgeLogController::page()` renders a filterable, paginated log (provider/success
filters; URL and error output escaped with `htmlspecialchars`).

## Purge form

`Form\CdnPurgeForm` (route `.purge`) offers four submit handlers: purge-all (with a confirm
checkbox), purge by CDN URLs, purge by Drupal `public://` URIs (converted via `rewriteUri()`), and
purge by comma-separated FIDs (loads each file entity and calls `purgeFile()`).
