<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cloudflare Worker Purge (cloudflare_worker_purge) — agent index

Bridges Drupal's **Purge** pipeline to a custom **Cloudflare Worker** so a site can invalidate the
Cloudflare edge **by cache tag** without a Cloudflare Enterprise plan. It contributes two plugins to
the Purge framework: a **purger** (`cloudflare_worker`) that, when the Purge queue processes tag
invalidations, `POST`s them as JSON `{"tags":[…]}` to an admin-configured Worker URL (via the core
`http_client`, standard TLS verification, optional `Authorization: Bearer <token>`); and a **tags
header** plugin (`cloudflare_worker`) that emits an `X-Cache-Tag` response header (comma-joined tags)
— renamed from `Cache-Tag` because Cloudflare strips `Cache-Tag` before the response reaches the
Worker. The Worker itself (not shipped here) stores the tag↔asset mapping and honors the purge POST.

There is **no route, controller, service, permission, or drush command** in this module and nothing
here triggers a purge from an HTTP request — invalidations are driven entirely by the Purge module's
own queue/processor pipeline. Configuration is a single embedded form surfaced inside `purge_ui`'s
purger dialog, storing two keys (`url`, `token`). The target URL is admin-set (never request-derived),
and the API token is read through the **Key** module when that module is present.

- Depends on: nothing declared in `info.yml`, but in practice needs **`purge`** (plugin base classes)
  and **`purge_ui`** (the config form base). **`key`** is an *optional* soft dependency — the token
  field and the auth header only exist when `key` is enabled (referenced with `NULL_ON_INVALID_REFERENCE`).
- Core: `^10.3 || ^11`. Package: `Purge - reverse proxies & CDNs`. No `composer.json` in the module.
- No dedicated settings page / `configure` route. Config is the `purge_ui` purger dialog for the
  `cloudflare_worker` purger. Provides config schema, **no** permissions, **no** drush, defines **no**
  plugin types (it provides plugin *instances* for Purge's `PurgePurger` and `PurgeTagsHeader` types).

## What you'd do → where

- **Set the Worker URL and the API token (Key entity)** → [configure/settings.md](configure/settings.md)
- **Understand the purger, the tags-header, the invalidate() request contract, chunking and error
  handling** → [api/purge-plugins.md](api/purge-plugins.md)

## Key facts (real machine names)

- Purge purger plugin: id `cloudflare_worker`, class
  `Drupal\cloudflare_worker_purge\Plugin\Purge\Purger\CloudflareWorkerPurger`; `types = {"tag"}`,
  `multi_instance = FALSE`, `configform = CloudflareWorkerPurgeForm`. `getIdealConditionsLimit()` = 300
  (`MAX_TAG_PURGES_PER_REQUEST` 30 × 10); `hasRuntimeMeasurement()` = TRUE.
- Purge tags-header plugin: id `cloudflare_worker`, `header_name = "X-Cache-Tag"`, class
  `…\Plugin\Purge\TagsHeader\CacheTagHeader` (value = `implode(',', $tags)`).
- Config form: `getFormId()` = `cloudflare_worker_purge.purger_configuration_form`, class
  `…\Form\CloudflareWorkerPurgeForm` extends `Drupal\purge_ui\Form\PurgerConfigFormBase`.
- Config object: `cloudflare_worker_purge.settings` — keys `url` (type `uri`), `token` (type `string`;
  holds a **Key entity id**, not the raw secret). Schema in `config/schema/cloudflare_worker_purge.schema.yml`.
- Services consumed (no services *defined*): `config.factory` (→ `cloudflare_worker_purge.settings`),
  `http_client`, `logger.factory` (channel `cloudflare_worker_purge`), `key.repository`
  (`Container::NULL_ON_INVALID_REFERENCE`), `module_handler` (form).
- No `*.routing.yml`, `*.services.yml`, `*.permissions.yml`, `*.links.*.yml`, `.module`, `.install`,
  `composer.json`, or libraries.
