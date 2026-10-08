<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drupal CMS Helper is the glue module bundled with Drupal CMS: it ships recipe-developer tooling (a `site:export` Drush command and service that turn a running site into a recipe), a set of config-action plugins, shims for behaviour not yet in Drupal core, and an opt-in anonymous telemetry subsystem. It has no configuration UI of its own and should not be uninstalled on a Drupal CMS site.

---

The module's headline, developer-facing (`@api`) surface is recipe export: the `site:export` Drush command (and the equivalent `SiteExporter` service) serialise the current site's configuration and content into a `Site`-type recipe — writing `recipe.yml`, `composer.json`, a `config/` tree (with core/System/User config converted to config actions) and exported default content. It also adds a `--generic` option to core's `config:export` command that strips the `_core` and `uuid` keys from exported config so the output is recipe-ready. Three `@api` config-action plugins are provided for use inside recipes: `setDefaultImage` (points an image field at a file entity by UUID that may not exist yet), `themeDevelopmentMode` (toggles Twig debug/cache development settings from `system.theme`), and `setComponentTree` (sets a component tree on a Canvas config entity, filling in unpredictable component versions). Beyond the public API, the module carries many internal shims — extra (hidden) Drush commands (`content:export:all`, `content:import`, `site:archive`, `pm:clean`), internal config actions (`grantPermissionsIfExist`, `setComponentTree`'s page-variant decorator), a decorated branding block, and numerous form/render/menu/route alter hooks — all marked `@internal` and slated for removal once the corresponding core issues land. A `/admin/config/development/site-export` route (permission `administer site configuration`) lets an admin download the whole site as a ZIP recipe. New in the 2.2.x line is an opt-in telemetry manager that queues anonymous usage events (site-template install, module install/uninstall, recipe apply, admin-page visits, code-component creation, login, periodic ping) and sends them to Amplitude from cron once an admin opts in via a non-modal dialog.

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
- Set a component tree (content template, page region, page variant, pattern) on a Canvas config entity from a recipe with the `setComponentTree` config action, letting unpredictable component versions be filled in automatically.
- Create a Canvas page variant with a non-empty component tree from a recipe (internal `PageVariantEntityCreate` decorator of core's `create` / `createIfNotExists`).
- Grant permissions to a role while silently ignoring ones that don't exist, with the internal `grantPermissionsIfExist` config action (loose recipe interoperability).
- Export all content of a site to a directory of default-content files with `drush content:export:all <dir>`.
- Import a directory of default-content files with `drush content:import <dir>` (optionally `--skip-existing`).
- Archive a site's config, content and Composer files into a single ZIP with `drush site:archive`.
- Remove Composer packages for disabled extensions with `drush pm:clean` (optionally `--update` to physically remove them).
- Call the `SiteExporter` service programmatically from custom code to build a recipe.
- Compute Composer version constraints for a site's installed extensions via `SiteExporter::getExtensionRequirements()`.
- Locate where Composer installs recipes (the "cookbook" path) via `SiteExporter::getRecipePath()`.
- Let an admin opt in to (or out of) sending anonymous usage telemetry via the dialog on admin pages or the checkbox on the Basic site settings form.
- Rely on the module as a required dependency of Drupal CMS recipes and site templates.
- Keep exported recipes portable by excluding site name/mail, `core.extension`, path aliases and other install-time-only data automatically.
