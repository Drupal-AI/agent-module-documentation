<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
OptGroup Taxonomy Select adds an "Optgroup Term Select" field widget for taxonomy-term entity-reference fields that renders the term hierarchy as an HTML `<select>` with top-level terms shown as non-selectable `<optgroup>` headings and their children as the selectable options.

---

The module provides a single field widget plugin (`optgroup_term_select`, class `OptgroupTermSelectWidget`, extends core `OptionsWidgetBase`) usable on any `entity_reference` field. You assign it on an entity's *Manage form display* tab; there is no global settings page (`configure` is null) and no permissions or config schema of its own. When building the element it loads the term tree (`loadTree`) for each target vocabulary of the field, uses depth-0 terms as `<optgroup>` labels and deeper terms as options grouped under their parent, producing a grouped select rather than a flat list. It also ships an `EntityReferenceSelection` plugin (`OptGroupEntityReferenceSelection`, extends the core `TermSelection` handler) that constrains the field to a single vocabulary (radios instead of checkboxes in the handler settings form) and builds the grouped, hierarchy-aware, access-filtered options (unpublished terms are hidden from users lacking `administer taxonomy`, and labels are `Html::escape()`d). Intended for term reference fields where editors should pick a child term while seeing its parent category as a heading. Note the widget only groups two levels cleanly (parent heading → child options); deeper trees are flattened under the nearest depth-0 parent.

---

- Render a taxonomy term reference field as a grouped `<select>` with parent categories as optgroup headings.
- Let editors pick a child term while seeing its parent category as a non-selectable heading.
- Replace a long flat term dropdown with a hierarchy-organized one for easier scanning.
- Group products under category headings on a product content type's term field.
- Group articles under topic headings using a "Topics" vocabulary reference.
- Present a location field's cities grouped by their country/region parent term.
- Keep a single-vocabulary term reference field tidy when the vocabulary has many terms.
- Use the widget on any entity_reference field (not just taxonomy) via Manage form display.
- Hide unpublished terms from non-admin editors automatically in the options list.
- Show translated term labels (uses translation-from-context) in the grouped options.
- Provide a "- None -" empty option for non-required single/multi selects.
- Constrain an entity-reference term field to exactly one vocabulary via the OptGroup selection handler.
- Offer a multi-select grouped list for fields allowing multiple term values.
- Indent deeper child terms with dashes in the OptGroup entity-reference selection handler.
- Avoid contrib autocomplete widgets when a simple grouped native select is enough.
- Improve editorial UX for categorization fields with obvious parent/child structure.
- Escape term labels safely (`Html::escape`) while still grouping by parent.
- Migrate a checkboxes/flat-select term widget to a grouped optgroup presentation with no data change.
