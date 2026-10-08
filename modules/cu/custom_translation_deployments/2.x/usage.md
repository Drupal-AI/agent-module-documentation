Ship custom interface-translation `.po` files with your code and have Drupal's locale system import them automatically on a translation update.

---

Custom Translation Deployments makes it possible to keep hand-written or agency/distribution-wide interface-translation `.po` files in your project's translations directory and have them treated as a real translatable "project" by Drupal's locale (interface translation) system. It registers synthetic projects with locale's project storage so that files matching a naming pattern — by default `project_specific-custom.LANGUAGE.po` — are discovered and imported whenever locale translations are updated (for example via `drush locale:update`). A default project ships out of the box, and any module can expose additional file patterns through `hook_custom_translation_deployments_files()`. Because the files live in version control and are imported by an ordinary locale update, this gives you a repeatable, code-driven way to deploy custom string translations and overrides across environments. The module has no UI, routes, permissions, or configuration of its own — only the core `locale` module is required.

---

- Deploy custom UI string translations to a site as part of a normal code deployment rather than exporting/importing `.po` files by hand.
- Override a poor or missing core/contrib translation for a specific string in one language and keep that override under version control.
- Provide an agency- or distribution-wide set of translation overrides that every project built on your base gets automatically.
- Keep translation `.po` files in `PROJECT_ROOT/translations` (or wherever locale's translation path points) so they travel with the repository.
- Use the built-in `project_specific-custom.LANGUAGE.po` file to add project-specific translations without writing any PHP.
- Expose one or more extra custom translation files (e.g. `custom-mycompany.nb.po`) from a company/base module using `hook_custom_translation_deployments_files()`.
- Import all custom and contrib translations in one step in CI/CD by running `drush locale:update` after deploying code.
- Correct a mistranslated menu item, block title, or form label site-wide by adding the corrected string to a deployed `.po` file.
- Maintain per-environment consistency of translations so staging and production always share the same custom strings.
- Add translations for strings that have no upstream translation on localize.drupal.org yet.
- Bundle translation overrides with a feature module so enabling the module and running a locale update applies its strings.
- Provide translations for custom modules' interface strings without publishing them to a translation server.
- Roll back a translation change by reverting the `.po` file in git and re-running a locale update.
- Standardise terminology (brand names, product terms) across a multilingual site by shipping a controlled glossary as `.po` overrides.
- Support multiple languages from a single deployed file set by adding one `.po` file per language code.
- Let Drupal's normal locale update batch/cron pick up the deployed files alongside contrib project translations.
- Avoid manual "Import" steps in the Interface Translation admin UI by making imports part of the automated deploy.
- Give a distribution or install profile a baseline of custom translations that ship with it.
- Use static, non-`dev` version identifiers for your custom projects so locale treats each deployed file set as a stable importable source.
