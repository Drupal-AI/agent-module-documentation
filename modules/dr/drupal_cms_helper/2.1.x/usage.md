<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drupal CMS Helper is the glue module bundled with Drupal CMS: it ships recipe-developer tooling (a `site:export` Drush command and service that turn a running site into a recipe) plus a set of config-action plugins and shims for behaviour not yet in Drupal core. It has no configuration UI of its own and should not be uninstalled on a Drupal CMS site.

---

The module's headline, developer-facing (`@api`) surface is recipe export: the `site:export` Drush command (and the equivalent `SiteExporter` service) serialise the current site's configuration and content into a `Site`-type recipe — writing `recipe.yml`, `composer.json`, a `config/` tree (with core/System/User config converted to config actions) and exported default content. It also adds a `--generic` option to core's `config:export` command that strips the `_core` and `uuid` keys from exported config so the output is recipe-ready. Two `@api` config-action plugins are provided for use inside recipes: `setDefaultImage`, which points an image field at a file entity by UUID that may not exist yet (e.g. shipped as recipe default content), and `themeDevelopmentMode`, which toggles Twig debug/cache development settings from `system.theme`. Beyond the public API, the module carries many internal shims — extra (hidden) Drush commands (`content:export:all`, `content:import`, `site:archive`), internal config actions (`grantPermissionsIfExist`, `overrideMenuLinks`), a decorated branding block, a filtering messenger, and numerous form/render/menu/route alter hooks — all marked `@internal` and slated for removal once the corresponding core issues land. A `/admin/config/development/site-export` route (permission `administer site configuration`) lets an admin download the whole site as a ZIP recipe.

---

- Turn a hand-built Drupal CMS site into a distributable recipe with `drush site:export`.
- Export a site as a site template (`type: Site` recipe) that can be applied at install time.
- Generate a recipe `recipe.yml` whose `install` list and `composer.json` `require` are derived from the site's installed modules and themes.
- Export a site on top of a base recipe with `drush site:export --base=<path>` (reuses the base's assets, regenerates config/content).
- Export in development mode with `drush site:export --dev` so the recipe enables theme development instead of asset aggregation.
- Overwrite a previous export with `drush site:export --overwrite`.
- Download the current site as a ZIP recipe from `/admin/config/development/site-export`.
- Produce recipe-ready configuration by stripping `uuid` and `_core` keys via `drush config:export --generic`.
- Set an image field's default image to a file UUID that does not exist yet, from inside a recipe, with the `setDefaultImage` config action.
- Enable or disable theme development mode (Twig debug, Twig cache, render cache bins) from a recipe with the `themeDevelopmentMode` config action.
- Grant permissions to a role while silently ignoring ones that don't exist, with the internal `grantPermissionsIfExist` config action (loose recipe interoperability).
- Override static menu links (e.g. disable a Navigation link) from a recipe with the internal `overrideMenuLinks` config action.
- Export all content of a site to a directory of default-content files with `drush content:export:all <dir>`.
- Import a directory of default-content files with `drush content:import <dir>` (optionally `--skip-existing`).
- Archive a site's config, content and Composer files into a single ZIP with `drush site:archive`.
- Call the `SiteExporter` service programmatically from custom code to build a recipe.
- Compute Composer version constraints for a site's installed extensions via `SiteExporter::getExtensionRequirements()`.
- Locate where Composer installs recipes (the "cookbook" path) via `SiteExporter::getRecipePath()`.
- Rely on the module as a required dependency of Drupal CMS recipes and site templates.
- Keep exported recipes portable by excluding site name/mail, `core.extension`, path aliases and other install-time-only data automatically.
