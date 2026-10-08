<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Defined in `src/Commands/ConfigLayersCommands.php` (registered via `drush.services.yml`).
These are the primary interface. A layer's DB storage is table `config_layer_<id>`; its file
storage is the layer `path`.

## Lifecycle
- `config-layers:create` — create a layer entity. Options: `--id --label --path --weight
  --reset --source (active|default) --import_mode --export_mode --import_events --export_events`.
- `config-layers:delete <layer> [config_name] [key]` (`cldel`) — with no `config_name`, deletes
  the whole layer **and drops its DB table**; otherwise deletes a config object/key inside the layer.
- `config-layers:enable <layer>` (`clen`) / `config-layers:disable <layer>` (`cldis`) — toggle
  the layer's `status` (disabled layers are excluded from merges).

## Move config in/out
- `config-layers:import <layers>` (`clim`) — import a layer's **source** (its file `path`, or the
  active config when the layer `source`/`--from=active` is set) into the layer's **DB** storage.
  Options: `--source=<dir>` (override path), `--from=active|default`, `--tag=<t1,t2>`,
  `--update-mode=<mode>`, `--synchronize` (also push the merged result into active config).
  Prompts with a change table before applying.
- `config-layers:export <layers>` (`clex`) — write a layer's DB storage out to its file `path`.
  Options: `--destination=<dir>`, `--tag`, `--merge` (export the merged result of all layers),
  `--active-diff` (export only the diff of active config vs. merged layers), `--update-mode`.
- `config-layers:synchronize [layers]` (`clsync`) — merge all active layers and import the result
  into **active** configuration (core `doImport`). With a layer list it does a *partial* sync
  (only those layers' config names), like `drush config:import --partial`.
- `config-layers:reverse-synchronize [layers]` (`clrevsync`) — write each active-config object
  back into the first layer that already contains it (`updateExisting`). Options: `--tag`.

## Inspect / edit a single layer (mirror core `config:*`)
- `config-layers:get <layer> <config_name> [key]` (`clget`) — read a value from a layer's storage.
  `--merged` reads the merged-up-to-this-layer storage instead.
- `config-layers:set <layer> <config_name> <key> <value>` (`clset`) — write a value directly into
  a layer's DB storage (does **not** import into active config). `--input-format=string|yaml`.
- `config-layers:status <layer>` (`clst`) — like `config:status` for the layer; `--state`,
  `--prefix`, `--label`.
- `config-layers:info <layers|*> [config_name]` (`clinfo`) — table of which layers define each
  config object and whether the merged value matches active config (`synced`/`out-of-sync`/`-`).

## Update modes (`--update-mode`, applied by `ConfigLayerManager::combine()`)
`replace` (default: clear target, copy source), `copy` (overlay objects, keep others),
`merge` (merge source onto target), `merge-target` (merge target onto source, write to target),
`deduplicate` (drop from target what already equals source), `deduplicate-source` (inverse).
