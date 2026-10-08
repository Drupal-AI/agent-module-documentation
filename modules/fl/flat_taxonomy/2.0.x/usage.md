<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Flat Taxonomy adds a "Flat taxonomy" checkbox to a vocabulary's settings that forces the vocabulary to be **flat** (non-hierarchical): terms can be reordered but never nested under a parent.

---

The module is a small set of hook implementations plus one service. On the vocabulary add/edit form it adds a **Flat taxonomy** checkbox; when ticked, an entity builder stores a third-party setting `flat_taxonomy.flat` on the `taxonomy.vocabulary.<id>` config entity (schema `taxonomy.vocabulary.*.third_party.flat_taxonomy`, value `1` = flat, `0`/unset = normal) and immediately calls the `flat_taxonomy.taxonomy_flattener` service (`Flattener::flatten()`) to move any existing nested terms up to the root. Once a vocabulary is flat, the module enforces it everywhere: the term add/edit form's **parent** field is hidden and a validate handler rejects any parent, the **"Add child"** operation is removed from the term overview, the overview's drag-and-drop is stripped of its depth/parent grouping so you can reorder but not indent, and `hook_taxonomy_term_presave()` defensively resets `parent` to `0` (logging a warning) if a term is saved with a parent programmatically (migration, REST, etc.). A `hook_requirements()` check warns if both Flat Taxonomy and Hierarchy Manager are configured to manage the same vocabulary. There is no dedicated settings page, no permissions, and no Drush command — the whole feature is the per-vocabulary checkbox and the enforcement hooks. `FlatConstants::FLAT_TAXONOMY_FLAT` (1) / `FLAT_TAXONOMY_NORMAL` (0) name the values.

---

- Force a "Tags" vocabulary to stay flat so editors can't accidentally nest tags.
- Guarantee a vocabulary a site was built to assume is flat never becomes hierarchical.
- Hide the parent field on the term edit form for a chosen vocabulary.
- Remove the "Add child" link from a vocabulary's term overview.
- Prevent drag-and-drop indenting on the term listing while still allowing reordering.
- Flatten an existing nested vocabulary in one step by ticking the Flat checkbox (existing terms are un-nested).
- Reject a parent set via migration/REST by resetting it to root on presave (with a logged warning).
- Keep a "Categories" vocabulary single-level for a clean facet/filter UI.
- Enforce flatness on a vocabulary used by a view that assumes no depth.
- Protect front-end code that iterates terms without handling hierarchy.
- Allow content editors to reorder terms (weights) but not create sub-terms.
- Export the flat flag in config (`third_party_settings.flat_taxonomy.flat`) for deployment.
- Un-flatten a vocabulary later by unticking the checkbox (the third-party setting is removed).
- Detect a conflict where Hierarchy Manager and Flat Taxonomy both manage the same vocabulary.
- Standardise several vocabularies as flat across a site build.
- Avoid confusing contributors who might otherwise pick a parent term.
- Programmatically flatten a vocabulary with the `flat_taxonomy.taxonomy_flattener` service.
- Keep a country/language/currency list strictly single-level.
- Ensure autocomplete/free-tagging vocabularies never gain accidental hierarchy.
- Use it on any custom entity's taxonomy-style vocabulary that must remain flat.
