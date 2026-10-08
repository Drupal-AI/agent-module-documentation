<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CSS/JS Aggregation Retention (css_js_agg_retention) — agent index

Prevents Drupal from deleting **all** aggregated CSS/JS during a cache rebuild. Decorates core's
CSS and JS collection optimizers so `deleteAll()` removes only aggregate files **older than a
configurable retention window** (default 45 days) instead of wiping the whole `assets://css` and
`assets://js` directories. Package `Performance`. Core `^10.2 || ^11`. License GPL-2.0-or-later.
Version `1.0.0-alpha3`. No module dependencies; no permissions of its own.

- **Config object, settings form, schema, retention behavior** → [config/settings.md](config/settings.md)
- **The service decorators and how deletion is intercepted** → [services/decorators.md](services/decorators.md)
- **Drush purge commands** → [drush/commands.md](drush/commands.md)

## What it provides (from source)

- **Two service decorators** (`css_js_agg_retention.services.yml`):
  `css_js_agg_retention.css_optimizer` decorates `asset.css.collection_optimizer`, and
  `css_js_agg_retention.js_optimizer` decorates `asset.js.collection_optimizer`. Classes
  `CssOptimizerSelectiveDelete` / `JsOptimizerSelectiveDelete`, both extending
  `BaseOptimizerSelectiveDelete` (`src/Asset/`), which implements
  `AssetCollectionGroupOptimizerInterface`.
- **One config object** `css_js_agg_retention.settings` with a single key `retention_days`
  (integer; install default 45). Schema in `config/schema/`, install default in `config/install/`.
- **One route/form** `css_js_agg_retention.settings` at
  `/admin/config/development/performance/css-js-agg-retention`
  (`_permission: administer site configuration`), form `AggRetentionSettingsForm`
  (`src/Form/`). Menu link parented to `system.performance_settings`.
- **Two Drush commands** (`drush.services.yml`, `CssJsAggRetentionCommands` in `src/Commands/`):
  `css-js-agg-retention:purge-old` (alias `cjar:purge-old`) and
  `css-js-agg-retention:purge-all` (alias `cjar:purge-all`).
- **Install hooks** (`css_js_agg_retention.install`): `hook_install`/`hook_uninstall` only emit a
  status message. No schema tables, no update hooks.

## Key mechanism

`BaseOptimizerSelectiveDelete::deleteAll()` is the only overridden behavior. It scans the asset
directory (`assets://css` or `assets://js`) recursively, reads `retention_days` from config
(falling back to the `MAX_AGE = 45 * 86400` constant), and deletes each file whose
`filemtime()` is older than `retention_days * 86400` relative to `time->getRequestTime()`.
`optimize()`, `optimizeGroup()` and `getAll()` are pass-throughs to the decorated inner service.
