<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate Hierarchical Taxonomy (migrate_hierarchical_taxonomy) — agent index

A single Migrate **process plugin**, `hierarchical_taxonomy`, that imports nested taxonomy terms to
**unlimited depth**: it walks an ordered list of source level values, looks up or creates a term at each
level under the previously resolved parent, and returns the deepest term's ID. For migrations where a row
carries a full term path (e.g. `Continent > Country > City`) and you need the parent/child tree preserved.

- **Machine name:** `migrate_hierarchical_taxonomy` · **Version:** 2.0.0 (2.0.x) · **Package:** Migrate · **License:** GPL-2.0-or-later
- **Core:** `^10.6 || ^11.4` · **PHP:** `>=8.2`
- **Dependencies (`.info.yml`):** `drupal:migrate`, `migrate_plus:migrate_plus (>=6.0.6, <7.0)`, `drupal:taxonomy`.
- **Composer `require`:** `php >=8.2`, `drupal/core ^10.6 || ^11.4`, `drupal/migrate_plus ^6.0.6`.
- No admin UI, no routes, no permissions, no Drush commands, no `config/`, no config schema, no submodules.
  Only a `hook_help` implementation (OO `Hook` class + a `LegacyHook` wrapper for Drupal 10).

## Solution docs

- [plugins/hierarchical_taxonomy.md](plugins/hierarchical_taxonomy.md) — the process plugin: config keys
  (`bundle`, `source`, `ignore_case`), the per-level lookup/create algorithm, behavior details, and a full
  migration YAML example.

## What it actually is (from source)

- One class: `HierarchicalTaxonomy` (id **`hierarchical_taxonomy`**),
  `src/Plugin/migrate/process/HierarchicalTaxonomy.php`, declared with the attribute
  `#[MigrateProcess(id: 'hierarchical_taxonomy')]`, **extending**
  `Drupal\migrate_plus\Plugin\migrate\process\EntityGenerate`.
- `create()` pins the inherited lookup properties to the taxonomy term entity:
  `lookupValueKey = 'name'`, `lookupBundleKey = 'vid'`, `lookupEntityType = 'taxonomy_term'`.
- `transform()` reads `configuration['source']` (ordered level list) and `configuration['bundle']`
  (vocabulary `vid`); for each non-empty level it loads that parent's immediate children
  (`taxonomy_term` storage `loadTree($bundle, $parent, 1, TRUE)`), matches by trimmed name, and on a miss
  sets `configuration['parent']` and calls the inherited `generateEntity()`. The resolved/created term ID
  becomes the next level's parent; the final ID is returned.
- `entity()` overrides the parent to build the create values `['name' => …, 'vid' => …, 'parent' => …]`.
- `migrate_hierarchical_taxonomy.module` / `src/Hook/MigrateHierarchicalTaxonomyHooks.php` provide only
  `hook_help` for `help.page.migrate_hierarchical_taxonomy`.

## Running it

Developer/migration tool — no runtime UI. Install with `composer require drupal/migrate_hierarchical_taxonomy`
then `drush en migrate_hierarchical_taxonomy -y`, define the migration YAML (see the plugin doc), and run it
with `migrate_tools` (`drush migrate:import <id>`, `drush migrate:status`). Validate source data first.

## 8.x-1.x → 2.0.x (material changes)

Platform/signature modernization only — the public process ID and migration config keys are unchanged.
Core is now `^10.6 || ^11.4` (Drupal 8/9 and <10.6 dropped), PHP `>=8.2`, Migrate Plus pinned `>=6.0.6, <7.0`
(Migrate Plus 5 shim removed). The plugin now uses the `#[MigrateProcess]` attribute instead of an
annotation, `help` moved to an OO `Hook` class with a `LegacyHook` wrapper, and subclass contracts tightened
to `create(..., ?MigrationInterface $migration = NULL): self` and `entity($value): array`.
