<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Merge — agent index

A stateless **three-way merge** for configuration items: reconcile an incoming config update
(`current`) against the last snapshot (`previous`) and the site's active config (`active`),
keeping local customizations. No UI (`configure: null`), no permissions, no Drush, no config
entity. One class + one event.

- **The `ConfigMerger` class (`mergeConfigItemStates`, merge rules, `getLogs()`) and the
  `POST_MERGE` event** → [api/merger.md](api/merger.md)

Submodule (nested docs):
- **config_merge_filter** — a Config Filter plugin that applies the merge during config import →
  [modules/config_merge_filter/2.0.x/agent/start.md](../../modules/config_merge_filter/2.0.x/agent/start.md)

Key fact: `\Drupal\config_merge\ConfigMerger::mergeConfigItemStates($previous, $current, $active)`
returns the merged array; it takes an upstream change only when `active === previous`
(uncustomized), otherwise keeps `active`. Operations are logged as `update` / `ignore` /
`substitute`.
