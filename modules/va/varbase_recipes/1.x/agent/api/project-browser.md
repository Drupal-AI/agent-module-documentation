<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Project Browser source, activator, RecipeHelper & install hooks

## Source plugin — `VarbaseRecipes`

`src/Plugin/ProjectBrowserSource/VarbaseRecipes.php`, `final`, extends `ProjectBrowserSourceBase`.
Attribute `#[ProjectBrowserSource(id: 'varbase_recipes', label: 'Varbase recipes', local_task: ['weight' => 0])]`
so it renders as its own Project Browser tab.

- `create()` injects `FileSystemInterface`, `cache.project_browser` bin, `ModuleExtensionList`,
  the `app.root` parameter, and `file_url_generator`.
- `getProjects(array $query)`: returns cached results when present; otherwise runs `getFinder()`,
  and for every `recipe.yml` whose **directory basename starts with `varbase_`** builds a
  `Project` (type `ProjectType::Recipe`) using the recipe's `name`/`description` and composer
  package metadata. Results are sorted by title (`strcasecmp`) and cached. Supports
  `query['machine_name']`, `query['search']` (case-insensitive title match), and `page`/`limit`
  pagination via `array_chunk`.
- `getFinder()`: a Symfony `Finder` over core's `Recipes::getRecipesPath()` (unwrapping a `{$name}`
  segment), plus `<app root>/../recipes`, falling back to the app root — `->depth(1)->name('recipe.yml')`,
  `followLinks()`. Reads local files only; **no remote/URL fetch**.
- `getPackageMetadata()`: reads a sibling `composer.json` for `name` (default `varbase/unknown`)
  and `homepage`.
- `getFilterDefinitions()`: a single `search` `TextFilter`.
- Recipe `title`/`description` are passed through `$this->t()` (phpcs `NotLiteralString` suppressed)
  — the text originates from local `recipe.yml` files shipped in the codebase, not user input.

## Activator — `VarbaseRecipeActivator`

`src/Activator/VarbaseRecipeActivator.php`, `final`, `@internal`, implements `TasksInterface` +
`InstructionsInterface`. Registered in `varbase_recipes.services.yml` as a
`project_browser.activator` **priority 10**, constructed with core `RecipeActivator` injected.

- `supports()`: true only for `ProjectType::Recipe` whose `machineName` starts with `varbase_`.
- `getStatus()`, `activate()`, `getInstructions()`: delegate straight to the wrapped
  `RecipeActivator`.
- `getTasks()`: delegates but **catches `RecipePreExistingConfigException` and returns `[]`** — so
  recipes already applied during Varbase profile install don't 500 the Project Browser recipe list.
- Applying/reapplying a recipe is the core `RecipeActivator`'s job; access is governed by Project
  Browser's own admin UI (the Extend/Browse-projects area), not by this module.

## `RecipeHelper` (static utilities)

`src/Recipe/RecipeHelper.php` — helpers for update/install hooks that build or tweak recipes at
runtime. No state, all static.

- `getRecipeString($path)` / `getRecipeData($path)`: read a `recipe.yml` (dir or file path,
  resolved by private `resolveRecipePath()`) as a raw string / decoded array.
- `createRecipe(string|array $data, ?string $machine_name)`: writes YAML to a temp
  `<temp>/recipes/<name-or-uniqid>/recipe.yml` and returns `Recipe::createFromDirectory()`.
- CKEditor 5 toolbar helpers: `getToolbarItemPosition($editorConfigName, $itemName)` (index or
  `-1`), `toolbarItemExists()`, `setAddItemPosition(&$recipeData, …, $position)` (sets
  `addItemToToolbar.position`), `setButtonIndex(&$recipeData, …, $position)` (sets
  `addButtonPluginIntoActiveToolbar.button_index`) — both no-op at `-1`. `blockStylesUnchanged()`
  compares an editor's `settings.plugins.ckeditor5_style.styles` for guard checks in update hooks.

## Install / uninstall — `varbase_recipes.install`

- `hook_install()`: adds `varbase_recipes` to `project_browser.admin_settings` `enabled_sources`
  (if absent). Then clears stale `project_browser.applied_recipes` state entries whose basename
  contains `varbase_`, so the recipe list renders as "Present" without a
  `RecipePreExistingConfigException`.
- `hook_uninstall()`: removes `varbase_recipes` from `enabled_sources`.

## Services (`varbase_recipes.services.yml`)

- `Drupal\varbase_recipes\Activator\VarbaseRecipeActivator` — tagged `project_browser.activator`,
  priority 10, arg = `@Drupal\project_browser\Activator\RecipeActivator`.
- `logger.channel.varbase_recipes` — `parent: logger.channel_base`, channel `varbase_recipes`;
  injected into every config-action plugin.
