Organigrams turns Drupal taxonomy vocabularies into visual organization charts (organigrams/organograms), rendered as a pure-CSS flex tree from a hierarchical list of taxonomy terms.

---

Enabling the module adds an "Add organigram" action to the taxonomy vocabulary overview. That action creates a normal vocabulary but flags it with the `organigrams` third-party setting `is_organigram` and auto-creates a set of `field_o_*` taxonomy fields (position, image, URL, CSS classes) on the vocabulary via `organigrams_create_term_fields()`. Each term becomes a node in the chart; the term hierarchy (parent/child and term weight) defines the chart layout, and a `field_o_position` value of `s` marks a term as a "staff" function. The `organigrams.taxonomy_term_tree` service builds the hierarchical render array, and `css/orgchart-layout.css` + `css/orgchart-theme.css` (the `organigrams/organigrams` library) draw the tree — no canvas or heavy JS, so the chart is fully CSS-styleable. A completed organigram can be shown three ways: a dedicated page at `/organigram/{vocabulary}`, one auto-derived block per organigram vocabulary (`organigrams_block` derivative), or a `[organigrams:{vid}]` token (needs the token + token_filter modules). Import/export forms move organigram term data as JSON between sites and even from Drupal 7. Three permissions gate creating, importing, and viewing organigrams; because organigrams are vocabularies, core taxonomy permissions also apply. This is a dev release (`2.x`; `minimum-stability: dev`).

---

- Build a company org chart from a taxonomy vocabulary without writing code.
- Visualize a department/team reporting hierarchy as a CSS flex tree.
- Add an "Add organigram" one-click vocabulary that ships with the right fields.
- Mark specific terms as "staff" positions (`field_o_position = s`) shown beside the line.
- Attach a photo to each chart node via the `field_o_image` term field.
- Link each node to a profile or page using the `field_o_url` term field.
- Apply custom per-node CSS classes with `field_o_css_classes` for theming.
- Reorder chart nodes by dragging taxonomy terms (term weight = layout order).
- Show an organigram on a dedicated page at `/organigram/{machine_name}`.
- Place an organigram in any region using its auto-generated block.
- Embed an organigram inside body/content text with the `[organigrams:{vid}]` token.
- Restyle the whole chart (colors, spacing, borders) purely through CSS overrides.
- Grant editors "Create organigrams" without giving full taxonomy admin.
- Limit chart visibility with the "View organigrams" permission.
- Migrate an organigram from a Drupal 7 site by pasting its JSON export.
- Export an organigram's items as JSON for backup or transfer to another site.
- Move organigram vocabularies between environments via config sync (terms via import/export).
- Alter the generated term tree in code with `hook_organigrams_taxonomy_term_tree_alter()`.
- Rewrite a node's markup in code with `hook_organigrams_taxonomy_term_markup_alter()`.
- Present multiple independent org charts (one vocabulary each) on one site.
- Highlight organigram vocabularies in the taxonomy overview (custom list builder).
- Render an org chart in a token-enabled field like a WYSIWYG body.
