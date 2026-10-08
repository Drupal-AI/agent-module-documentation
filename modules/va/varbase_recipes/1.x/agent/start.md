<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Varbase Recipes (varbase_recipes) — agent index

Custom **Drupal Recipes config-action plugins** plus a **Project Browser source + activator** for
`varbase_*` recipes. Part of the Varbase distribution, but installable on any Drupal 11 site.
Package `Varbase`. `core_version_requirement: ~11.4.0`. License GPL-2.0-or-later. Version
1.0.0-beta4 (doc dir `1.x`).

- Module dep (`.info.yml`): **`project_browser`**. Composer also requires `drupal/project_browser:~2`
  and `drupal/varbase_components:~4.0.0`.
- **No routes, no `*.permissions.yml`, no `*.links.*.yml`, no `config/` (no schema), no Drush, no
  submodules.** One `.install` file and one `services.yml`.

## What it actually is (from source)

- **9 config-action plugins** in `src/Plugin/ConfigAction/`, each a `#[ConfigAction(id: …)]`
  implementing `ConfigActionPluginInterface`. Recipes call them from `config.actions` YAML. See
  [config/config-actions.md](config/config-actions.md).
- **Project Browser source** `VarbaseRecipes` (id `varbase_recipes`, `#[ProjectBrowserSource]`) in
  `src/Plugin/ProjectBrowserSource/VarbaseRecipes.php` — scans on-disk `recipe.yml` files whose dir
  starts with `varbase_` and lists them under a "Varbase recipes" tab.
- **Activator** `VarbaseRecipeActivator` in `src/Activator/` — a `project_browser.activator`
  (priority 10, `services.yml`) wrapping core `RecipeActivator`; catches
  `RecipePreExistingConfigException` in `getTasks()`.
- **`RecipeHelper`** static utility in `src/Recipe/` — load/create/modify recipes at runtime.
- See [api/project-browser.md](api/project-browser.md) for the source, activator, `.install`, and
  `RecipeHelper`.

## Install / operate

- `drush en varbase_recipes`. `hook_install()` (`varbase_recipes.install`) auto-registers
  `varbase_recipes` in `project_browser.admin_settings` `enabled_sources` and clears stale
  `project_browser.applied_recipes` state for `varbase_*` paths. `hook_uninstall()` removes the
  source. No configuration UI — the module is driven by recipes and by Project Browser.
- Own logger channel `logger.channel.varbase_recipes` (defined in `services.yml`); every action
  writes info/warning entries there.

## Solution docs

- **The 9 config actions — ids, values, behaviour, recipe YAML** →
  [config/config-actions.md](config/config-actions.md)
- **Project Browser source, activator, RecipeHelper, install/uninstall hooks** →
  [api/project-browser.md](api/project-browser.md)
