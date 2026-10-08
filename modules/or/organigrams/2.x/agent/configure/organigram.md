# Creating and displaying an organigram

There is no settings form. An organigram is a taxonomy vocabulary marked with the module's
third-party setting; its terms are the chart nodes.

## Create an organigram vocabulary
- UI: *Structure → Taxonomy* → action link **Add organigram** (route
  `entity.vocabulary.add_organigram_form`, permission `create organigrams`).
- This opens the normal vocabulary add form. On submit, `organigrams_vocabulary_form_submit()`:
  1. calls `organigrams_create_term_fields($vid)` to create the `field_o_*` term fields, and
  2. sets `$vocabulary->setThirdPartySetting('organigrams', 'is_organigram', TRUE)`.
- The `is_organigram` third-party setting is what marks a vocabulary as an organigram
  (`OrganigramsController::isOrganigram()` is the `_custom_access` check on the view/import/export routes).

## Term fields created on the vocabulary
Created from `config/optional/` (storage) + `config/taxonomy_fields/` (instances):
- `field_o_position` — chart position; value `s` marks a **staff** function (prepended "Staff:" in the
  term overview, drawn to the side of the line).
- `field_o_image` — image shown in the node.
- `field_o_url` — link target for the node.
- `field_o_css_classes` — extra CSS classes applied to the node for theming.

Build the chart by adding terms to the vocabulary; parent/child relationships and term **weight**
(drag order) define the tree layout.

## Three ways to display
1. **Dedicated page** — `/organigram/{taxonomy_vocabulary}` (route `organigrams.view`, permission
   `view organigrams`). `viewOrganigram()` returns the tree and attaches library `organigrams/organigrams`.
2. **Block** — one block per organigram vocabulary via the `organigrams_block` derivative
   (`Plugin/Derivative/OrganigramsBlocks`). Block access requires `view organigrams`. Place it on
   *Structure → Block layout*.
3. **Token** — `[organigrams:{vid}]` (from `hook_token_info()`/`hook_tokens()`); requires the
   contrib **token** and **token_filter** modules to render inside a text field.

## Import / export (data migration)
- Export: `/admin/structure/taxonomy/manage/{vocab}/export` (`organigrams.export_items_form`) dumps all
  terms as JSON (tid exported as `iid`, `field_o_` prefixes stripped).
- Import items: `/admin/structure/taxonomy/manage/{vocab}/import` (`organigrams.import_items_form`).
- Import D7 organigram: `/admin/structure/taxonomy/import/d7-organigram` (`organigrams.import_form`,
  permission `import organigrams`). Accepts both 7.x and 8.x JSON.
- Vocabularies (config) sync via config export; terms are content, so use the import/export forms.

Styling: override `css/orgchart-layout.css` (structure) and `css/orgchart-theme.css` (colors/borders)
in your theme — the v2 chart is pure CSS (no canvas).
