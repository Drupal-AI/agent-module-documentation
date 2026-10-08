<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Droost Brain — MCP tools & the project brain

## Install & build
```bash
drush en droost_brain -y
drush droost:brain:build   # alias: drush dbb
```
The three brain tables are created lazily on the first build (there is no `hook_schema`); until then the
tools return a `fail` envelope telling you to run `drush dbb`. `hook_uninstall` drops the tables and the
`droost_brain.fingerprint` / `droost_brain.built` / `droost_brain.built_git_head` State keys.

## The tools (all read-only, gated by mcp_server `access mcp server`)
Each extends `DroostToolBase`, is enabled by default, and returns `{success, message, data}`.

### `droost_architecture` (`src/Plugin/Tool/Architecture.php`)
No input. Returns `drupal_version`, `modules_by_scope` (counts keyed core/contrib/custom), `top_capabilities`
(the 15 highest `count_available` rows) and `stale`. `execute()` fails with "Run drush dbb" when
`BrainStorage::isReady()` is false.

### `droost_capabilities` (`src/Plugin/Tool/Capabilities.php`)
Optional `capability` filter (e.g. `"block"`, `"field.formatter"`). Returns the capability rollup — one row per
capability+provider `{capability, provider_module, kind (plugin|entity_type), count_available}` — plus `stale`.

### `droost_module_patterns` (`src/Plugin/Tool/ModulePatterns.php`)
Required `module` (machine name); optional `kind` filter (`plugin_type` | `plugin_instance` | `entity_type` |
`hook_impl` | `event_listener` | `module_deps`). Returns `defines` (plugin types the module declares, each with
`manager` + a copyable `example_fqcn`, plus its hook impls / listeners / deps) and `provides` (plugin instances +
entity types). `BrainStorage::patternsByModule()` caps at 500 rows; a full result sets `truncated: true` so the
caller narrows with `kind`. `partition()` splits rows into defines vs provides.

## Freshness
`BrainStaleness` compares the current module-set fingerprint and git HEAD against the last build; every tool appends
its `note()` and reports `stale: true` when the set changed. Re-run `drush dbb` after enabling/uninstalling modules.

## Seeding (answers before the first build)
`droost_brain_install()` calls `BrainSeeder::seedOnly()` when a brain-seed dataset is present (e.g. droost_knowledge's
`data/brain-seed/11.yml`), so core-capability questions answer immediately. A real `build()` supersedes the seed;
`droost_knowledge_install()` never clobbers an already-harvested brain (`BrainStaleness::builtTime()` guards it).
