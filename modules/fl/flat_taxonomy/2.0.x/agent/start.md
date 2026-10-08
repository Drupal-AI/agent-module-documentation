<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Flat Taxonomy — agent index

Adds a **"Flat taxonomy"** checkbox to a vocabulary so it stays **flat** (non-hierarchical):
terms can be reordered but never nested. No settings page, no configure route, no permissions,
no Drush, no plugins. Its only persistent state is a **third-party setting** on the vocabulary
config entity. (Operates on core Taxonomy, which must be enabled.)

Key facts:
- Setting path: `taxonomy.vocabulary.<id>` → `third_party_settings.flat_taxonomy.flat` (`1` = flat).
  Schema `taxonomy.vocabulary.*.third_party.flat_taxonomy`. Constants:
  `FlatConstants::FLAT_TAXONOMY_FLAT = 1`, `FLAT_TAXONOMY_NORMAL = 0`.
- When flat: term form's parent field hidden + validated, "Add child" op removed, overview
  drag-drop nesting stripped, `hook_taxonomy_term_presave` forces `parent = 0`.
- Service `flat_taxonomy.taxonomy_flattener` (`Flattener::flatten($vocabulary)`) un-nests existing terms.

- **Make a vocabulary flat / where it is stored / what it enforces** → [configure/flat.md](configure/flat.md)
- **Flattener service, presave enforcement, constants** → [api/flattener.md](api/flattener.md)
