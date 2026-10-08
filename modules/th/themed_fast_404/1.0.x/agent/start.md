<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Themed Fast 404 (themed_fast_404) — agent index

Generates a themed static 404 HTML file per language on cron and feeds it into core's
`system.performance.fast_404` via a config override. Depends on core `config` + `file`.
No permissions of its own, no Drush; the settings form uses `administer site configuration`.

- **Settings, cron/regeneration flow, the overridden core keys, verification** →
  [configure/setup.md](configure/setup.md)
- **Services and how to drive/extend generation from code** → [api/services.md](api/services.md)

Key facts:
- Routes: `themed_fast_404.settings` (`/admin/config/system/themed_fast_404`,
  `administer site configuration`) and `themed_fast_404.page_not_found` (`/page-not-found`,
  **`_access: 'TRUE'`** — deliberately public, it is the page cron scrapes).
- Config `themed_fast_404.settings`: `base_url` (''), `use_system_404` (false),
  `404_body` ('The requested page could not be found.'). Schema shipped; `base_url` and
  `404_body` are translatable (`themed_fast_404.config_translation.yml`).
- Static files: `public://page-not-found-{langcode}.html`
  (`ThemedFast404ManagerInterface::PAGE_NOT_FOUND_FILE_PATH = 'public://'`), one per **enabled**
  language, written with `FileExists::Replace`.
- **`ConfigOverrider`** (tagged `config.factory.override`) rewrites `system.performance` on read:
  - `fast_404.html` ← contents of the current language's static file (only when it exists),
  - `fast_404.paths` ← `/\.*$/i` — **every** path, not just asset extensions,
  - `fast_404.exclude_paths` ← `/\/(?:styles)|(?:system\/files)\//` so image derivatives and
    private-file routes are untouched.
  It returns those two path keys **even when no static file has been generated yet**, so enabling
  the module immediately changes core's fast-404 behaviour before the first cron run.
- Generation happens in `hook_cron()` → `ThemedFast404Manager::buildStatic404()`, and also from
  the settings form's rebuild submit handler. `buildStatic404()` fetches over HTTP with
  `@file_get_contents()`; a failed fetch writes an **empty** file rather than erroring.
- `get404Url()` uses the module's own route by default; with `use_system_404` enabled *and*
  `system.site:page.404` set, it scrapes that path instead. `base_url`, when set, is prefixed to
  the relative URL — otherwise an absolute URL is generated from the current request/CLI context.
- The manager service is `lazy: true` and ships a generated `ProxyClass`.
