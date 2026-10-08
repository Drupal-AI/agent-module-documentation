<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Aggregation JS CSS async defer (agg_jscss_asyncdefer) — agent index

Attaches **`async`/`defer`** to any Drupal asset **library's** JS/CSS — per library or forced across
all JS/CSS — and makes core emit **a separate aggregate per attribute**. Version **1.0.1**, core
`^10 || ^11`, package `Performance`, license GPL-2.0-or-later. **No module dependencies, no
composer requirements, no permissions of its own, no Drush.**

- **Config object, keys, the settings form, the service swaps, aggregate grouping, and operating it
  safely** → [config/settings.md](config/settings.md)

## What it actually is (from source)

- Owns **no hooks**. `src/AggJscssAsyncdeferServiceProvider.php` (`::alter()`) **swaps three core
  services**: `asset.resolver` → `AssetResolverAggJscssAsyncdefer`, `asset.css.collection_grouper`
  → `CssCollectionGrouperAggJscssAsyncdefer`, `asset.js.collection_grouper` →
  `JsCollectionGrouperAggJscssAsyncdefer`.
- The resolver subclass reimplements core `getCssAssets()` / `getJsAssets()` and, reading config
  `agg_jscss_asyncdefer.settings`, injects `$options['attributes']['async'|'defer'] = TRUE` on
  matching assets; the grouper subclasses add the attribute name to the aggregation group key.
- **Config route** `agg_jscss_asyncdefer.settings` at
  `/admin/config/development/performance/agg-jscss-asyncdefer`, permission **`administer site
  configuration`** (menu/task under Configuration ▸ Development ▸ Performance).
- Config object **`agg_jscss_asyncdefer.settings`**: `js_all` / `css_all` (`none|async|defer`),
  `libraries` (`{async: [...], defer: [...]}`). Schema in
  `config/schema/agg_jscss_asyncdefer.settings.schema.yml`; no default config ships.

## Files

- `src/AggJscssAsyncdeferServiceProvider.php` — container service swaps.
- `src/AssetResolverAggJscssAsyncdefer.php` — attribute injection + `preprocess` handling.
- `src/CssCollectionGrouperAggJscssAsyncdefer.php`, `src/JsCollectionGrouperAggJscssAsyncdefer.php`
  — per-attribute aggregate grouping.
- `src/Form/SettingsForm.php` — settings form; `agg_jscss_asyncdefer.libraries.yml` (`form` CSS).
- `agg_jscss_asyncdefer.routing.yml`, `.links.menu.yml`, `.links.task.yml`.

See [../usage.md](../usage.md) for prose and use cases.
