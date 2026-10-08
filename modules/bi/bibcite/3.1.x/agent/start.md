<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bibliography & Citation (bibcite) core — agent index

The core API of the Bibcite suite: renders bibliographic (CSL) data into formatted citations
using CSL styles, and defines the pluggable **processor** and **format** systems the submodules
extend. Stores no bibliographic content itself (that's `bibcite_entity`).

- **Global settings (`bibcite.settings`: processor / default_style / convert_urls) + CSL style
  config entities** → [configure/settings.md](configure/settings.md)
- **The two plugin types it defines: `bibcite_processor` and `bibcite_format`** →
  [plugins/plugin-types.md](plugins/plugin-types.md)
- **Rendering citations in code: `bibcite.citation_styler` + name parser** →
  [api/citation-styler.md](api/citation-styler.md)

Key facts: config object `bibcite.settings` → `processor` (default `citeproc-php`),
`default_style` (default `apa`), `convert_urls` (bool). CSL styles are `bibcite_csl_style` config
entities (shipped: apa, chicago_author_date, modern_language_association,
modern_language_association_8th_edition, american_medical_association). Admin at
`/admin/config/bibcite` (route `bibcite.settings`, permission `administer bibcite`). Only
permission: `administer bibcite`. No Drush commands.
