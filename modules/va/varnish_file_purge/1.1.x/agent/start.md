<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Varnish File Purge (varnish_file_purge) — agent index

Sends a **`PURGE` or `BAN` request straight to a configured Varnish host** for a **file's URL**
whenever the file entity is inserted, updated, or deleted — so a file replaced at an **unchanged
URL** stops being served stale. Version **1.1.4**. Core `^10 || ^11`. Declares `php: 8.1`.
Package "Purge - reverse proxies & CDNs". Config at `/admin/config/development/varnish_file_purge`
(permission `administer site configuration`).

## What it actually does (read the source, not the tagline)
- **It does NOT use the Purge framework.** Despite the package name and the modules it is compared
  to, there is **no `purge` dependency**, no queue, no queuer/processor plugin, and it provides no
  plugin types. It hooks file entity events and issues HTTP requests itself, synchronously, from
  the request that saved the file.
- **Trigger = file entity hooks.** `src/Hook/FileHooks.php` (an OOP `#[Hook(...)]` class, mirrored
  by `#[LegacyHook]` wrappers in `varnish_file_purge.module`) implements `file_insert`,
  `file_update`, `file_delete`. Each first calls `VarnishFilePurger::isConfigured()` (a Varnish
  **host** must be set, else it logs a warning and returns), then `->purge($file)`.
- **Update is content-gated.** `file_update` purges only if `isFileDifferent()` is true: compares
  old vs new `getSize()`, then `getFileUri()`, then a `hash_file('sha256', realpath(...))` of both
  files on disk. This is the whole point — it works with `file_replace`, which keeps the URI stable.
- **What is purged.** `VarnishFilePurger::purge()` (`src/Services/VarnishFilePurger.php`) skips
  `temporary://` files, builds the file's URL with `$file->createFileUrl()`, then for **each** domain
  in the `domains` config (comma-split; falls back to global `$base_url`) issues an async Guzzle
  request: method = configured verb, URL = the file URL, `base_uri` = the Varnish endpoint
  (`scheme + host [+ :port]`), and a **`Host` header set to the domain**. Requests run through a
  Guzzle `Pool` (concurrency 10) and are `wait()`-ed synchronously.
- **Image styles (optional).** If `purge_styles` is on and the file mime is `image/png` /
  `image/jpeg` / `image/jpg`, it loads every image style, and for each derivative that already
  `file_exists()` on disk, purges `$style->buildUrl($file_url)` too.
- **Debug.** When `debug` is on, each successful purge is logged (`URL purged: … on domain: …`);
  failures always log an error. Nothing is queued or retried.

## Config keys (`varnish_file_purge.configuration`)
`host` (required for anything to happen), `port`, `scheme` (`http://`/`https://`), `request_method`
(`purge`|`ban`, default `purge`), `domains` (comma-separated front/back-office hosts), `debug`
(bool), `purge_styles` (bool). Config-install ships only `debug: 0`, `request_method: purge`.

## Gotchas / facts that decide help-vs-break
1. **Establish the site keeps file URLs stable.** Image-style derivatives carry an `itok` and many
   file fields rename on replacement; if URLs change, this module solves a non-problem.
2. **CDN in front of Varnish.** Purging Varnish alone leaves a stale copy at a CDN edge caching the
   same URL. Name every cache between the file and the reader.
3. **Prepare your VCL for the verb.** `PURGE` vs `BAN` behave differently; the module only sends the
   request, your VCL must handle it.
4. **Synchronous cost.** Purges block the save request (Guzzle Pool `wait()`), one batch per file
   save/delete. High-volume file churn pays that latency inline; there is no queue.
5. **Dead code.** `src/EventSubscriber/VarnishFilePurgeEventSubscriber.php` duplicates the hook
   logic but is **not registered** in `varnish_file_purge.services.yml` — it never runs. Ignore it.
6. **Malformed `composer.json`.** The shipped `composer.json` is invalid JSON (the `extra.patches`
   block is not closed before `keywords`); `drush` warns about it. It also declares
   `minimum-stability: dev` and patches Drupal core issue 2551893 via `cweagans/composer-patches`.

## Files
- `src/Hook/FileHooks.php` — the real trigger: `file_insert/update/delete`, `isFileDifferent()`.
- `src/Services/VarnishFilePurger.php` — builds URLs, sends PURGE/BAN via Guzzle per domain, image styles.
- `src/Form/VarnishFilePurgeConfiguration.php` — the settings form (`ConfigFormBase`).
- `src/EventSubscriber/VarnishFilePurgeEventSubscriber.php` — unregistered dead duplicate.
- `varnish_file_purge.module` — `#[LegacyHook]` shims to `FileHooks`.
- `varnish_file_purge.services.yml` — registers `.purger` and `.file_hooks` only.
- `config/{install,schema}/varnish_file_purge.configuration.yml` — defaults + schema.
- `varnish_file_purge.routing.yml`, `.links.menu.yml`, `.links.task.yml` — the admin route/links.

## Solution types
- `agent/config/` — configuring the Varnish connection, domains, verb, and image-style purging.
