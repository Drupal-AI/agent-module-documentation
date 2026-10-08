<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MD Sitemap (mdsitemap) — agent index

Generates a **Markdown sitemap for LLM crawlers**: one endpoint (default `/sitemap-llm`) returns
a `text/markdown` bullet list `- [label](https://host/path<suffix>)` of the canonical URLs of
selected content-entity bundles. Standalone — depends only on core **`system`**. Core
`^10 || ^11`, PHP `>=8.3`, GPL-2.0-or-later. Installed release **1.0.3** (doc dir `1.x`).

## What it actually is (from source)

- **Two routes** (`mdsitemap.routing.yml`):
  - `mdsitemap.sitemap` — default path `/sitemap-llm`, `_controller: SitemapController::build`,
    `requirements._access: 'TRUE'` (**public by design**). The real path is overridden at runtime
    from config by `Routing\RouteSubscriber::alterRoutes()`.
  - `mdsitemap.settings` — `/admin/config/search/md-sitemap`, `_form: SitemapSettingsForm`,
    `_permission: 'administer site configuration'`. Also a menu link (`mdsitemap.links.menu.yml`)
    under *Configuration → Search and metadata*.
- **No permissions.yml, no plugins, no Drush, no entities.** One config object
  `mdsitemap.settings` (schema in `config/schema/mdsitemap.schema.yml`).
- **Services** (`mdsitemap.services.yml`): `mdsitemap.generator` (the generator),
  `cache.mdsitemap` (a dedicated cache bin via `cache_factory`), `mdsitemap.route_subscriber`,
  `mdsitemap.entity_change_subscriber`.

## Mechanism

- `MdsitemapGenerator::generate()` (`src/MdsitemapGenerator.php`) returns the cached string if
  present; otherwise, for each configured `entity_type => [bundles]`, runs an entity query with
  `->condition('status', 1)` (when the type has a `status` key) and **`->accessCheck(TRUE)`**,
  loads each result, and emits `- [label](host + canonical URL + suffix)` for entities whose
  bundle is selected and that have a `canonical` link template. Result cached **permanently**
  (`Cache::PERMANENT`, cid `mdsitemap_sitemap`, tag `mdsitemap`) in the `mdsitemap` bin.
- Cache invalidation: `mdsitemap.module` `hook_entity_insert/update/delete` invalidate tag
  `mdsitemap`; `EntityChangeSubscriber` also `deleteAll()`s the bin; the settings form
  `deleteAll()`s it and rebuilds routes on save. `hook_cron()` pre-warms via `generate()`.

## Solution docs

- **Settings form, config object/schema, routes, path override** →
  [config/settings.md](config/settings.md)
- **The generator, caching, invalidation, cron, output format** →
  [api/generator.md](api/generator.md)
