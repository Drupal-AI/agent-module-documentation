<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Taxonomy Depth Widget adds two field widgets for taxonomy term reference fields that filter which hierarchy levels are offered and indent each option label by its depth, configured per field in the form display.

---

The module ships two `OptionsWidgetBase` field widgets for `entity_reference` fields — **"Term Depth Select list"** (`term_depth_options_select`, a `<select>`) and **"Term Depth Check boxes/radio buttons"** (`term_depth_options_buttons`, checkboxes when multi-valued, radios otherwise). You assign either under **Manage form display** on a field that references `taxonomy_term`. Instead of core's flat option list, the widget calls the term storage's `loadTree()` on each target vocabulary and builds the options itself, so two things happen at once: each label is prefixed with a run of hyphens equal to the term's depth (`str_repeat('-', depth) . name`) to visually convey the tree, and terms outside the configured depth are omitted entirely. Three mutually-exclusive depth modes are set in the widget settings form: **Depth/max depth** (`depth`, `0` = every level, `1..15` = only terms shallower than that cutoff via `loadTree`'s max-depth argument); **Deepest elements** (`deepest`, scans the tree, finds the greatest depth present, and offers only terms at that level — the leaves); and **Set range between depths** (`depth_range` with `min_depth`..`depth`, keeping only terms whose depth falls in that band, with an element-validate rule rejecting `min_depth > depth`). Version **2.1.2** on core `^10 || ^11`, depending only on core `taxonomy`; it ships no config schema of its own, no permissions, and no services beyond `entity_type.manager`. Two caveats matter. **It is a widget, so it constrains the edit form and nothing else** — a migration, a JSON:API/REST write, a second form display, or a different widget can still store any term at any depth; a site that needs the rule *enforced* rather than *suggested* needs a field constraint, not this. And **the depth math assumes a uniform tree**: `deepest` keys only off the single greatest depth found across all target vocabularies, so in an irregular taxonomy (some branches three deep, others two) it hides the leaves of the shallow branches — check the real vocabulary, not the intended one. For a non-taxonomy target type the widget falls back to core's normal options, so it is only meaningful on term references.

---

- Offer only the leaf terms of a deep vocabulary in a select list.
- Stop editors selecting a top-level grouping term.
- Show a taxonomy hierarchy indented by dashes in an option list.
- Restrict a location field to only cities (the deepest level).
- Offer only second- and third-level terms via a depth range.
- Limit a product-category widget to subcategories.
- Cap a term reference at a maximum tree depth.
- Present a vocabulary as indented radio buttons.
- Present a multi-value term field as indented checkboxes.
- Hide intermediate/grouping terms from selection.
- Improve tagging accuracy in a nested classification.
- Constrain a subject taxonomy to its answer-level terms.
- Reduce editorial mistakes when picking from a large tree.
- Restrict a region field to districts only.
- Offer only terms between depth 2 and depth 4.
- Guide editors visually toward the intended level.
- Fix listings that miss content tagged at the wrong level.
- Convey parent/child structure without an autocomplete.
- Set the depth rule per field display, not globally.
- Support a deep vocabulary's usability on the node form.
- Offer the deepest level across several target vocabularies at once.
- Replace core's flat term select with a depth-aware one.
