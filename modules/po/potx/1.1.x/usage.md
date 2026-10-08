<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
The Translation template extractor (potx) scans Drupal source code (PHP, JS, Twig, YAML, `.info.yml`, config schema) and produces Gettext `.pot` translation templates — or, optionally, `.po` translation files — for a chosen module, theme, folder, or file.

---

potx gives translators the raw material for localizing Drupal: it walks a component's files, finds every translatable string (`t()`, `$this->t()`, `format_plural()`, `TranslatableMarkup`, JS `Drupal.t`, Twig `{% trans %}`/`|t`, plugin annotations, YAML `translatable` keys, config schema labels, and shipped default config) and writes them into a standard Gettext template. It works two ways: a **Drush command** (`drush potx`) for command-line extraction in `single`, `multiple`, or `core` output modes, and a **web UI** at *Configuration → Regional → User interface translation → Extract* that lists installed modules/themes as a directory tree so you can pick one and download its template. The extractor targets a Drupal API version (5/6/7/8, default current = 8) which controls which patterns are recognized. potx can emit a language-independent template (`.pot`) or, when a language is selected, a language-dependent template with plural formulas and (optionally) existing translations exported into a `.po` file. Beyond its own UI, potx exposes a reusable procedural API (in `potx.inc`) that other projects — historically the localization server and Coder — call to parse files and collect strings. It depends on core's `locale` module.

---

- Generate a `.pot` template for a contributed module you are translating.
- Extract translatable strings from a custom theme for a translation team.
- Produce a single combined template from every file in a directory with `drush potx single`.
- Build per-module `.pot` files across a code tree with `drush potx multiple`.
- Create Drupal-core-style output where `.info` strings fold into `general.pot` (`drush potx core`).
- Download a template for one module straight from the Extract tab in the admin UI.
- Emit a language-dependent template including the correct plural formula for a target language.
- Export existing translations of a component into a `.po` file (`--translations`).
- Limit extraction to specific files with `drush potx --files=path/to/file.module`.
- Extract from an arbitrary folder with `--folder=` when the code is not an installed component.
- Target an older Drupal API version with `--api=7` when working on legacy code.
- Catch translatable strings in Twig templates (`{% trans %}`, `{{ x|t }}`) as well as PHP.
- Pull translatable labels out of `*.schema.yml` config schema and shipped default config.
- Extract strings from plugin annotations/attributes (`@Translation(...)`).
- Collect JavaScript strings (`Drupal.t`, `Drupal.formatPlural`) from a module's JS.
- Feed a localization workflow / localization server with freshly extracted source strings.
- Audit a module for untranslated user-facing strings before a release.
- Regenerate a template after adding new UI strings to keep translations in sync.
- Provide the string-extraction backend for another tool via the `potx.inc` API.
- Extract from a whole module suite by pointing at its top directory.
- Include context (`@context`) so identically spelled strings translate independently.
- Bootstrap a new language's translation by producing the initial template file.
