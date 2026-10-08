<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands — css_js_agg_retention

Registered via `drush.services.yml` (service `css_js_agg_retention.commands`, tag
`drush.command`), class `Drupal\css_js_agg_retention\Commands\CssJsAggRetentionCommands`
(`src/Commands/`), a `DrushCommands` subclass. Constructor args:
`@asset.css.collection_optimizer`, `@asset.js.collection_optimizer`, `@file_system` — note the
two optimizer args resolve to the **decorated** services, so they carry this module's selective
deletion logic.

## `css-js-agg-retention:purge-old` (alias `cjar:purge-old`)

`purgeOld()`. Calls `cssOptimizer->deleteAll()` then `jsOptimizer->deleteAll()`. Because the
injected optimizers are the decorators, this runs the **age-based** sweep: only aggregates older
than `retention_days` are removed. Use it to manually reclaim disk without wiping recent
aggregates.

```bash
drush css-js-agg-retention:purge-old
# or
drush cjar:purge-old
```

## `css-js-agg-retention:purge-all` (alias `cjar:purge-all`)

`purgeAll()`. Ignores retention entirely: `fileSystem->deleteRecursive('assets://css')` and
`fileSystem->deleteRecursive('assets://js')` — deletes the whole aggregate directories.
Emergency/full-cleanup command.

```bash
drush css-js-agg-retention:purge-all
# or
drush cjar:purge-all
```

Both commands only write progress lines to stdout; there is no batch, no confirmation prompt, and
no arguments/options. They are CLI-only (no HTTP route). `purge-old` emits the same
`css_js_agg_retention` log notice as an automatic rebuild sweep.
