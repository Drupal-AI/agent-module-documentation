<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Web Admin (webadmin) — agent index

Recipe-driven meta-bundle of administration tools. Version **12.0.1** (dir `12.0.x`).
Core `^11.4 || ^12`. Part of the **Webship** suite. Maintainer: Webship.

## What it is
No routes, services, entities, plugins, permissions or config schema of its own. It ships:
- `webadmin.info.yml` — module definition, no `dependencies`.
- `webadmin.install` — `webadmin_install()` applies `recipes/default` (unless installed via config sync or as part of the recipe itself).
- `recipes/default/recipe.yml` — the only real payload: which modules to enable, which themes to install/set, and config actions (permissions grants, settings).
- `composer.json` — `require` pulls the contrib tools the recipe enables.

## Dependencies
No hard module deps in `info.yml`. The recipe enables core admin modules + these contrib modules (Composer `require`): `automatic_updates`, `coffee`, `drupical`, `project_browser`, `sam` (+ `tagify_user_list` from tagify), `tagify`, `view_password`, `views_bulk_operations`, `views_bulk_edit`, `masquerade`. Also enables core `package_manager`.

## How it works
On install (standalone), `webadmin_install($is_syncing)` calls `RecipeRunner::processRecipe(Recipe::createFromDirectory(__DIR__ . '/recipes/default'))`. When the recipe itself installs the module, the recipe is already applied, so it is not re-run. Config sync skips application.

## Solution docs
- [recipe/default.md](recipe/default.md) — full breakdown of what `recipes/default` enables, imports, and configures (themes, permission grants, settings actions).
