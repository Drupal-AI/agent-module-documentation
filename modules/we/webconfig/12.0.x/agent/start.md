<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Web Config (webconfig) — agent index

Config-management **meta-package** in the Webship / `web*` suite. Version **12.0.1** (dir `12.0.x`).
Core `^11.4 || ^12`. License GPL-2.0-or-later. Security advisory coverage: not-covered.

## What it is
A thin recipe wrapper. The whole project is three files: `webconfig.info.yml`, `webconfig.install`,
and `recipes/default/recipe.yml`. It provides **no** PHP classes, routes, permissions, services,
plugins, or config schema. Its job is to install and enable the standard Drupal config-management
toolkit in one step.

## Install behaviour
`webconfig_install($is_syncing)` (in `webconfig.install`) returns early during a config sync
(`\Drupal::isConfigSyncing()`), otherwise applies the bundled recipe with
`RecipeRunner::processRecipe(Recipe::createFromDirectory(__DIR__ . '/recipes/default'))`.
When a parent recipe installs `webconfig`, that recipe has already been applied, so the hook is a
no-op there.

## Bundle (from composer.json `require`, minus php/core)
- `vardot/entity-definition-update-manager` ~1.0, `vardot/module-installer-factory` ~1.0 (build helpers)
- `drupal/config_update` ~2.0, `drupal/config_filter` ~2.0, `drupal/config_split` ~2.0,
  `drupal/config_ignore` ~3.0, `drupal/config_inspector` ~2.0, `drupal/config_rewrite` ~1.0,
  `drupal/config_import_single` ~2.0.0

## Modules enabled by `recipes/default/recipe.yml`
`config` (core), `config_update`, `config_update_ui`, `config_split`, `config_ignore`,
`config_inspector`, `config_rewrite`, `config_import_single`, then `webconfig` itself.
`config_filter` is pulled in transitively as a Config Split dependency. The recipe imports the
default config (`config.import: '*'`) of `config_update`, `config_split`, `config_ignore`,
`config_inspector`, `config_rewrite`, and `config_import_single` (`strict: false`).

## Notes / changes vs 11.0.x
- Core requirement widened to `^11.4 || ^12` (adds Drupal 12).
- `provides_config_schema` corrected to **false** (no `config/schema` dir ships).
- Bundle versions unchanged from 11.0.x.

## Solution docs
- [recipes/default.md](recipes/default.md) — what the recipe installs/imports and how to run the resulting config workflow.
