<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Recipe config translation writes a recipe's per-language config overrides into the matching language config override collection each time the recipe is applied.

---

Drupal recipes cannot yet apply config language overrides natively (core issue #3453331). This module closes that gap: place override files inside the recipe at `{recipe}/config/language/{langcode}/{config_name}.yml` holding only the keys that differ, and on every recipe-apply path (fresh install, `drush recipe`, Package Manager, Project Browser) the `RecipeAppliedEvent` fires once per recipe — including each nested recipe in a chain — and `RecipeConfigTranslationSubscriber` applies that recipe's overrides.

Writes merge into the `language.{langcode}` override collection with `array_replace_recursive`, so existing overrides are preserved and re-applying is idempotent. Overrides are scoped to installed languages only (an uninstalled langcode dir is skipped). There are no routes, permissions, or user-facing endpoints — the installer runs only in the privileged recipe-apply / CLI context and reads config files that ship inside the recipe on disk. To backfill recipes that were applied before this module was installed, call `recipe_config_translation.installer`'s `installFromDirectory()` or `installAll()` from an update hook.

---
- Ship German (or any language) config overrides inside a recipe and have them applied automatically
- Translate `system.site` name/slogan per language on recipe apply
- Provide per-language overrides for a single config object via `config/language/de/system.site.yml`
- Apply overrides for a chain of nested recipes, each contributing its own language files
- Keep recipe-provided translations idempotent across repeated `drush recipe` runs
- Add language overrides without hand-editing the `language.{langcode}` override collection
- Scope override application to only the languages actually installed on the site
- Merge new overrides on top of existing ones without clobbering unrelated keys
- Backfill overrides for a recipe applied before the module existed via `installFromDirectory()`
- Backfill every top-level recipe under `../recipes` at once via `installAll()`
- Trigger override application from a custom module's update hook
- Apply translations during a fresh site install driven by a recipe
- Apply translations when a recipe is installed through Package Manager
- Apply translations when a recipe is added through Project Browser
- Distribute multilingual defaults as part of a reusable recipe package
- Override field labels or menu strings per language from a recipe
- Test recipe language overrides with the module's kernel test fixtures as a template
- Avoid writing a bespoke event subscriber for each recipe that needs translations
- Ensure a recipe's translated config survives config re-import by shipping it in the recipe
- Verify applied overrides by inspecting the language config override storage after apply