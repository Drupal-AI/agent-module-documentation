<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Termcase lets site administrators enforce a consistent text-case convention on taxonomy term names within a vocabulary.

---

The module adds a "Term case settings" fieldset to each vocabulary edit form offering five modes: none, ucfirst (first character uppercase), lowercase, uppercase, and propercase (first letter of each word). The chosen mode is stored per vocabulary in `termcase.settings`. On `hook_ENTITY_TYPE_presave` for taxonomy terms it rewrites the term name to the configured case (via multibyte-safe helpers), and it invokes a `hook_termcase_convert_string_alter` so other modules can layer their own formatting on top before save. The term add/edit form also shows a note describing which conversion will be applied.

Existing terms are not changed automatically, but the vocabulary form offers an "convert existing terms immediately" checkbox that runs a Batch API job over all terms in the vocabulary, and the module ships a Drush command to do the same from the CLI. Configuration is purely administrative (it hooks the core vocabulary and term forms, which require the standard taxonomy administration permissions); there are no routes, services or public endpoints of its own.

---
- Force all terms in a vocabulary to lowercase.
- Force all terms in a vocabulary to UPPERCASE.
- Capitalize the first letter of each term (ucfirst).
- Apply proper/title case to multi-word terms.
- Choose "no conversion" to disable formatting for a vocabulary.
- Set the case convention per-vocabulary on its edit form.
- Convert all existing terms in a vocabulary immediately via a checkbox.
- Run the bulk conversion from the CLI with the bundled Drush command.
- Keep tag casing consistent across editors and imports.
- Normalize imported/migrated term names to a house style.
- Preview which conversion applies via the note on the term form.
- Layer custom formatting using `hook_termcase_convert_string_alter`.
- Ensure multibyte/accented term names are cased correctly.
- Clean up inconsistently-cased legacy vocabularies in batches.
- Automatically re-case terms every time they are saved.
