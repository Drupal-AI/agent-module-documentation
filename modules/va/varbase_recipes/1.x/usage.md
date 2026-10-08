<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Varbase Recipes ships custom Drupal Recipes config-action plugins plus a Project Browser source and activator that surface and apply `varbase_*` recipes.

---

Varbase Recipes is developer/distribution infrastructure for the Varbase distribution (and any Drupal 11 site). It provides nine custom config-action plugins in `src/Plugin/ConfigAction/` that recipe `config.actions` YAML can invoke to perform setup steps core's built-in actions cannot do cleanly — merging (not replacing) a text format's allowed HTML, enabling or configuring CKEditor 5 plugins and toolbar buttons, repointing Drupal Canvas component trees onto a site template's theme, switching a field's entity-reference handler, and scoping imported AI Context items after content import. It also registers a `project_browser` source plugin (`VarbaseRecipes`) that scans the codebase for `recipe.yml` files whose directory name starts with `varbase_` and lists them under a dedicated "Varbase recipes" Project Browser tab, and an activator (`VarbaseRecipeActivator`) that wraps core's `RecipeActivator` to apply/reapply them while swallowing `RecipePreExistingConfigException` so the list still renders after profile install. A static `RecipeHelper` utility helps update hooks build and modify recipes at runtime. The module has no routes, no permissions, and no config schema of its own; its behaviour is driven entirely by recipes and by Project Browser.

---

- Install alongside the Varbase distribution to get the "Varbase recipes" Project Browser tab.
- Add a "Varbase recipes" tab to Project Browser on any Drupal 11 site that has `varbase_*` recipes on disk.
- Browse, install, and reapply Varbase base recipes from the admin UI without Drush or Composer.
- Use `mergeAllowedHtml` in a recipe to add `<drupal-media>` / `<figure class>` tags to an existing text format without clobbering its current allowed HTML.
- Use `enableCKEditorPlugin` to initialise a buttonless CKEditor 5 plugin (e.g. a paste filter) with its default configuration during a recipe apply.
- Use `addButtonPluginIntoActiveToolbar` to insert a CKEditor 5 toolbar button at a chosen index and register its plugin settings in one action.
- Use `updatePluginSettings` to replace the settings of an already-configured CKEditor 5 plugin.
- Use `setCKEditorMediaEmbedVersion` to record the installed CKEditor Media Embed plugin version during install without triggering a full cache flush.
- Use `setEntityReferenceHandler` to switch a field's entity-reference selection handler (e.g. from an ECA handler back to `default:taxonomy_term`) while merging handler settings.
- Use `setAiContextItemsDefaultScope` to assign Global / Use Case / Tag scopes to `ai_context_item` entities imported by a recipe's content step.
- Use `repointComponentTreeToTheme` so a site template that installs its own theme can rewrite a base recipe's Drupal Canvas component tree onto that theme in one line.
- Use `setComponentTreeIfComponentsExist` to write a Canvas component tree only when every named component already exists, avoiding an aborted install.
- Use `setViewsComponentStyleTheme` to repoint a view's component-based style and exposed-form components onto another theme across all displays.
- Call `RecipeHelper::getRecipeData()` / `getRecipeString()` from an update hook to read a recipe.yml as an array or raw string.
- Call `RecipeHelper::createRecipe()` to build a `Recipe` object programmatically (e.g. to inject a runtime toolbar position) before running it.
- Use `RecipeHelper::getToolbarItemPosition()` / `toolbarItemExists()` to position a toolbar change relative to an existing item.
- Ship base recipes that must not install a theme themselves, deferring theme-specific config to the site template via the Canvas actions.
- Automate post-install setup steps that are unsafe to run as plain Drush commands during Drupal installation.
- Keep recipe applies idempotent — most actions no-op when the target already matches, so re-applying a recipe is safe.
- Provide a common config-action toolkit shared across all Varbase base recipes.
- Install with the Minimal or Standard profile purely for the config actions, without adopting the full Varbase stack.
- Remove the "Varbase recipes" Project Browser source cleanly by uninstalling the module (it de-registers the source on uninstall).
- Diagnose a recipe apply through the `varbase_recipes` logger channel, which each action writes info/warning entries to.
