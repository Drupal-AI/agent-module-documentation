Automatic Translation Template Discovery (ATD) lets custom modules, themes and profiles ship their own interface translations by dropping `.po` files in a `translations/` directory, which Drupal's locale system then discovers automatically.

---

ATD is a lightweight helper for the multilingual/interface-translation workflow. Contributed projects on drupal.org get their translations from the localize.drupal.org translation server, but custom (non-published) modules, themes and profiles have no such server. ATD closes that gap: it implements `hook_system_info_alter()` (in `Drupal\atd\Hook\AtdTranslationInfo`) so that whenever an installed extension contains a `translations/` subdirectory, ATD adds the `interface translation project` and `interface translation server pattern` metadata to that extension's `.info.yml` data at runtime. The pattern points at `translations/%project.%language.po` inside the extension. Drupal's built-in locale importer then treats each such extension as a local translation source, so `drush locale-check` / `drush locale-update` (or the Available translation updates UI) import the strings. Nothing is imported for extensions that lack a `translations/` directory, and ATD itself provides no routes, permissions, config, services or entities — it only annotates info arrays. The module depends only on core `locale`, targets Drupal core `^11.1`, and suggests `drupal/potx` for generating the `.po` templates.

---

- Ship interface translations alongside a custom module by adding a `translations/` folder to its root.
- Provide translations for a custom theme without publishing it on drupal.org.
- Provide translations for a custom install profile using the same convention.
- Name a translation file with the required pattern, e.g. `mymodule.nl.po` for Dutch strings.
- Deliver several languages for one extension, e.g. `mymodule.nl.po`, `mymodule.de.po`, `mymodule.fr.po`.
- Deploy translation updates as code so they version alongside the module, no manual import step per environment.
- Import discovered translations with `drush locale-check` followed by `drush locale-update`.
- Rebuild caches with `drush cr` after adding a `translations/` directory so the altered info metadata is picked up.
- Extract the source template for a custom extension with the Translation template extractor (`potx`) at `admin/config/regional/translate/extract`, then rename the result to the `%project.%language.po` pattern.
- Override or supplement core/contrib interface strings for a custom extension by shipping a corrected `.po`.
- Keep translation `.po` files private from web requests by adding an `.htaccess` file to the `translations/` directory.
- Onboard a new language on a site by dropping the matching `.po` files into each custom extension and running `locale-update`.
- Standardize terminology across a set of custom modules by shipping consistent `.po` translations for each.
- Avoid a bespoke custom translation server for in-house extensions — the local `translations/` directory replaces it.
- Support multisite/distribution builds where custom modules must carry their own localized UI strings.
- Re-run `drush locale-update` after pulling code that changed a `.po` file to refresh the imported strings.
- Test that discovery works by enabling an extension with a `translations/` directory and confirming the strings translate.
- Combine with core Interface Translation (locale) UI at `admin/config/regional/translate` to review imported strings.
