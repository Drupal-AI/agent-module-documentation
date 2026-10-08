<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands — export/import block content

Class `Drupal\block_migration\Commands\BlockMigrationCommands` (`src/Commands/BlockMigrationCommands.php`, extends `Drush\Commands\DrushCommands`). Constructor injects `block_migration.exporter`, `@entity_type.manager`, `@language_manager`. CLI-only; no web-facing surface.

## Install / enable

```
composer require drupal/block_migration   # pulls single_content_sync ^1.4
drush en block_migration -y
drush cr
```
Verify: `drush list | grep block-migration`.

## `block-migration:export-blocks` — `bm-export`, `bm:export-blocks`

`exportBlocks(string $destination, array $options)`. Writes one YAML file per (block × language) to `$destination` (created with `mkdir($destination, 0755, TRUE)` if missing, unless `--dry-run`).

Options (all optional; comma-separated lists trimmed via `explode`):
- `--ids` — internal block IDs, e.g. `54,55,72`. Default: all blocks (`loadMultiple()`).
- `--bundle` — block bundle machine names, e.g. `basic,banner`. Filters via `in_array($block->bundle(), …)`.
- `--languages` — langcodes, e.g. `ca,es,en`. Default: all site languages.
- `--label` — wildcard label filter; `*`→`.*`, `?`→`.` after `preg_quote`, matched case-insensitively (`/^…$/i`).
- `--overwrite` — default `TRUE`; pass `--no-overwrite` to skip files that already exist.
- `--dry-run` — logs what would be written, creates nothing.

Per block, `exportBlock()` iterates languages, skips langcodes with no translation (`hasTranslation`), calls `$this->exporter->buildExportData($block->getTranslation($lang), $lang)`, dumps `Yaml::dump($data, 10, 2)`, and writes `block_content-{ID}-{safe_label}-{langcode}.yml` (label sanitized `preg_replace('/[^a-zA-Z0-9_]/','_', …)`). Emits a per-block/summary log with exported/skipped/error counts.

## `block-migration:import-blocks` — `bm-import`, `bm:import-blocks`

`importBlocks(string $directory, array $options=['override'=>FALSE])`. Globs `block_content-*.yml`, parses each with `Symfony\Component\Yaml\Yaml::parse`, and groups entries by `data['uuid']` → `[langcode => entry]` (langcode from `base_fields.langcode`, default `en`).

For each UUID, `importBlock()` loads existing blocks via `loadByProperties(['uuid' => $uuid])`:
- Existing + no `--override` → **safe mode**: skipped (counts all translations as skipped).
- Existing + `--override` → for each langcode, gets or `addTranslation()`s the translation, runs `updateBlockFields()`, `save()` → updated.
- Not existing → `create(['type'=>bundle,'uuid'=>uuid,'langcode'=>…,'info'=>…,'reusable'=>…])`, `updateBlockFields()`, `save()`, then adds remaining translations.

`updateBlockFields($block, $data)` sets `info` from `base_fields.info` and, for each entry in `custom_fields`, `$block->set($field_name, $field_value)` guarded by `hasField()`. All errors are caught per-item and logged; the command prints an imported/updated/skipped/errors summary.

## Notes for agents
- Import is keyed by **UUID**, not internal ID — the same block on two sites must share a UUID to be recognized.
- Entity-reference/image/file fields carry only `target_id`; referenced entities must already exist with matching IDs on the target site (see `../api/exporter.md`).
- `single_content_sync` is a hard dependency but this command does entity creation itself; the YAML shape is what stays compatible.
