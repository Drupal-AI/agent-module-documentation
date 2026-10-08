# Organigrams — agent index

Turns a taxonomy vocabulary into a CSS org chart. No global config page (`configure` null); a
vocabulary becomes an organigram via the "Add organigram" action, which sets the vocabulary
third-party setting `organigrams.is_organigram` and creates `field_o_*` term fields. Terms = chart
nodes; term hierarchy + weight = layout. Display as page `/organigram/{vocabulary}`, block, or
`[organigrams:{vid}]` token. Dev release (`2.x`).

- **Create/manage an organigram, term fields, and the 3 display methods (page/block/token)** →
  [configure/organigram.md](configure/organigram.md)
- **The 3 permissions and how taxonomy perms interact** → [permissions/permissions.md](permissions/permissions.md)
- **The two alter hooks (`*_taxonomy_term_tree_alter`, `*_taxonomy_term_markup_alter`)** →
  [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Service `organigrams.taxonomy_term_tree` (class `TaxonomyTermTree`) builds the render array;
  `OrganigramsController::viewOrganigram()` attaches the `organigrams/organigrams` CSS library.
- Routes: `entity.vocabulary.add_organigram_form` (create), `organigrams.view` (`/organigram/{vocab}`),
  `organigrams.import_form` (D7 import), `organigrams.import_items_form` / `organigrams.export_items_form`.
- No config schema, no Drush. Tokens/token_filter are optional (only needed for the token display).
