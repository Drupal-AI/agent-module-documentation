Synlang bulk-imports interface (locale) and configuration translations into a Drupal site from a remote YAML file, using either an admin form or Drush commands.

---

Synlang (package "Synapse") is a small multilingual utility that reads a YAML mapping of source strings to per-language translations from a URL and writes them into Drupal's locale string storage — creating the source strings and their translations for the languages you select. It ships a single admin form at `/admin/config/system/synlang` (route `synlang.translate_form`, permission `administer synlang configuration`) with a "Check" action that reports how many translations the source contains per language and an "Update" action that performs the import over AJAX. The same import is available from the command line through two Drush commands: `synlang:slupdate` (interface strings) and `synlang:slupdate_config` (configuration values). It depends only on core `locale`. It defines no entities, plugins, config objects, or config schema; its core service is `synlang.service` (`UpdateTranslations`), which wraps `locale.storage` and `config.factory`.

---

- Bulk-load interface translations for many strings at once instead of translating them one by one in the core Locale UI.
- Import a curated set of translations maintained in an external Git repository or any HTTP(S)-reachable YAML file.
- Preview how many source strings and per-language translations a source file contains before importing (the "Check" button).
- Add brand-new source strings to locale storage during import (the "Add new expressions" = Yes option).
- Update translations only for existing source strings, without adding new ones ("Add new expressions" = No).
- Choose exactly which enabled languages receive translations, via the language table-select on the form.
- Keep a multilingual site's UI wording consistent across environments by importing the same translation YAML into each.
- Seed a fresh environment's translations from a known-good source URL after a site install.
- Re-run an import to refresh translations after the upstream YAML changes.
- Import configuration translations (e.g. overriding config values per default language) from the command line with `synlang:slupdate_config`.
- Script translation imports in CI or deployment pipelines using `drush synlang:slupdate <url>` (alias `slupdate`).
- Apply a vendor- or agency-maintained translation pack to client sites in the Synapse ecosystem.
- Populate translations for languages that lack complete community `.po` files on localize.drupal.org.
- Centralize custom-module string translations that are not shipped as interface translation packages.
- Distribute organization-specific terminology (product names, legal phrasing) across all site languages.
- Quickly correct or override existing interface strings by importing a small YAML with just the changed strings.
- Provide a single, repeatable translation source for teams so translations are version-controlled in Git.
- Restrict translation-import access to trusted administrators via the `administer synlang configuration` permission.
- Fill in translations for newly added languages by re-running the import with the new language selected.
- Audit a translation source's coverage per language using the Check output before committing to an import.
