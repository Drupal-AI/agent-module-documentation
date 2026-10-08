<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Merge Filter — agent index

Submodule of **config_merge**. A single Config Filter plugin that applies config_merge's
three-way merge during configuration import, so imports merge with active config instead of
overwriting local customizations. No config, no schema, no UI, no permissions, no Drush.
Requires `config_merge` + `config_filter`.

- **The `config_merge` Config Filter plugin (id, weight, storages, `filterRead` merge logic,
  how to drive it)** → [plugins/merge-filter.md](plugins/merge-filter.md)

Parent module: [../../../../2.0.x/agent/start.md](../../../../2.0.x/agent/start.md) (the `ConfigMerger`
three-way merge this filter calls).

Key fact: `@ConfigFilter` id **`config_merge`**, weight **1000**. `filterRead($name, $data)`
returns `ConfigMerger::mergeConfigItemStates($snapshot, $data, $active)` (snapshot =
`config.storage.snapshot`, active = `config.storage`) when all three exist, else `$data`.
