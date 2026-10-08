<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drush PET extracts translatable strings to PO files project-by-project via POTX and Drush.

---

Potx Extract Translations (PET) provides the `potx:extract-translations` Drush command (alias `pet`) that runs file-by-file PO translation extraction for Drupal projects using the POTX (Translation Template Extractor) engine — making it easy for module/theme/profile developers to generate up-to-date `.po` translation files from source code on the command line. For each matched extension it collects the project's files, runs POTX, and writes a `translations/<project>.<lang>.po` file inside the project directory. It also patches each project's `.info.yml` with the correct `interface translation project` and `interface translation server pattern` so Drupal knows where to load the files.

It's a developer/translation tool with no content or access role of its own. Depends on `potx`; requires Drupal 11.3+ or 12, Drush `^13`, and at least one translatable language configured on the site.

---

- Extract translatable strings to PO files.
- Generate translation files per project (module, theme, profile).
- Run file-by-file extraction via the `potx:extract-translations` Drush command.
- Use the POTX engine from the command line.
- Target a single project by machine name.
- Extract for all custom projects at once.
- Filter projects by type (`--type=module|theme|profile`).
- Filter projects by path segment (`--group=custom|contrib|shared`).
- Extract a single language (`--language=nl`) or all enabled languages.
- Auto-create a `translations/` directory in each project.
- Auto-patch `.info.yml` with the interface translation server pattern.
- Keep translation templates current with source changes.
- Help module/theme developers ship translations.
- Support translation and localization workflows.
- Handle submodules inside a project's own `modules/` directory.
- Support Drupal 11.3+ and 12.
- Aid i18n development.
- Automate extraction in developer scripts.
- Carry no content/access role.
- Act purely as a developer CLI tool.
