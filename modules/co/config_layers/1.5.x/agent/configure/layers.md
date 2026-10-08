<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layer entity + configuration

A **config layer** is a `config_layer` config entity (`config_prefix: layer`,
`src/Entity/ConfigLayer.php`). Create/edit at
**Configuration → Development → Configuration layers** (`ConfigLayerForm`) or with
`drush config-layers:create`. Access to all of this requires the
`administer config layers` permission.

## Fields (exported keys)
- `id` — machine name. Also names the layer's DB table: `config_layer_<id>`.
- `label` — human name.
- `description` — shown on the list page.
- `tags` — free tags; `--tag` on import/export/reverse-synchronize filters layers by tag.
- `path` — directory (relative to Drupal root) that is the layer's `FileStorage` — imported
  from / exported to. Validated so it cannot sit inside the core config sync directory.
- `weight` — merge order (low → high). Each layer is de-duplicated against lower-weight layers.
- `status` — enabled/disabled; disabled layers are skipped in merges.
- `reset` — when TRUE the merge ignores already-merged config and uses this layer's config
  as-is (an "override layer"). Otherwise the layer keeps only what differs from lower layers.
- `source` — import source: `default` (the layer's file `path`) or `active` (the site's active
  config). When `active`, imports are tested/deduplicated against the merged lower layers.
- `import_mode` / `export_mode` — default update mode for this layer (see modes below;
  default `replace`).
- `import_events` / `export_events` — arrays of config event names that auto-trigger this
  layer (see below).

## How merge / storage works
Each layer has a **database storage** (its live content) and a **file storage** (`path`, the
on-disk snapshot). `config-layers:import` moves file → DB; `config-layers:export` moves DB →
file; `config-layers:synchronize` merges all layers in weight order into an in-memory storage
and writes the result into **active** config. Merge/dedupe logic lives in
`ConfigLayerManager` (`mergeLayers`, `processLayer`, `combine`, `getMergedLayer`,
`getConfigDiff`). Storage comparisons use schema-sorted decorators
(`NormalizedStorage` / `ConfigSorter`) so key order never causes false diffs.

### Update modes
`replace`, `copy`, `merge`, `merge-target`, `deduplicate`, `deduplicate-source`
(constants on `ConfigLayer`; see `combine()`). Used as `import_mode`/`export_mode` or the
`--update-mode` Drush option.

## Event-triggered layers (optional automation)
`src/EventSubscriber/ConfigSubscriber.php` listens on `ConfigEvents::SAVE`, `DELETE`, `RENAME`,
and `IMPORT`. For each active layer whose `import_events` contains the fired event, the changed
config is written into the layer's DB storage (and the layers are re-merged); for each layer
whose `export_events` contains it, the layer's config is written back out to its file `path`.
Set these fields to event names like `config.save,config.delete,config.rename`. The subscriber
short-circuits while `\Drupal::isConfigSyncing()` so it does not interfere with a core config
import. It also normalises `core.extension` module order on the import storage transform.
