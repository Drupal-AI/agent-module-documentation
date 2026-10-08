<!--
SPDX-FileCopyrightText: © 2025 Agent Module Documentation contributors
SPDX-License-Identifier: GPL-2.0-or-later
-->
Term Reference Tree replaces the plain checkbox/select widget on a taxonomy term reference field with a hierarchical, expand/collapse **checkbox tree** that mirrors the vocabulary's parent-child structure, so editors pick terms in context instead of from a flat list. It also ships a matching field formatter that renders the selected terms as a nested tree.

---

The module provides one `@FieldWidget` (id `term_reference_tree`, label "Term reference tree") and one `@FieldFormatter` (id `term_reference_tree`, label "Term Reference Tree"), both for `entity_reference` fields — in practice taxonomy term reference fields (`target_type: taxonomy_term`). The widget declares `multiple_values = TRUE`, so a single tree collects every value of a multi-cardinality field; on single-value fields it renders radio buttons instead of checkboxes. Under the hood the widget builds a custom `checkbox_tree` render element (`src/Element/CheckboxTree.php`) that walks each target vocabulary's term hierarchy and draws collapsible branches with jQuery. Per-field widget settings (on *Manage form display*) are: **start_minimized** (collapse the tree by default), **leaves_only** (only terms without children are selectable), **select_parents** (auto-select ancestors of selected terms — unlimited-cardinality only), **select_all** (add a check/uncheck-all control), **cascading_selection** (on parent toggle, cascade to children: 0 none, 1 select+deselect, 2 only-select, 3 only-deselect — unlimited-cardinality only), and **max_depth** (limit how many levels deep the tree shows; 0 = unlimited). The formatter (*Manage display*) has no settings and themes the stored values through the `term_tree_list` theme hook. There is no global admin settings form (`configure` is null), no permissions, and no Drush commands — everything is per field-display config (schema `field.widget.settings.term_reference_tree`).

---

- Turn a hierarchical taxonomy (e.g. Categories with parent/child terms) into an expand/collapse checkbox tree on the node form
- Let editors see and pick terms in their real hierarchy instead of a flat multi-select list
- Start the tree collapsed on long vocabularies so the form stays compact (start_minimized)
- Restrict selection to leaf terms only, preventing editors from tagging with broad parent categories (leaves_only)
- Automatically include ancestor terms whenever a child is selected (select_parents) for faceted navigation
- Add a "select all / none" control to a tree of options editors frequently bulk-toggle (select_all)
- Cascade a parent checkbox down to all its children on select and deselect (cascading_selection = 1)
- Cascade only on select (2) or only on deselect (3) for finer bulk-tagging behavior
- Limit the tree to the top N levels of a deep vocabulary with max_depth
- Render single-value term reference fields as a tree of radio buttons for one-of-many hierarchical choice
- Display selected terms back to visitors as a nested tree with the matching field formatter
- Replace core's "Check boxes/radio buttons" widget on a term reference field with a hierarchy-aware one
- Improve tagging UX on a product-category reference in a commerce content type
- Build a location picker from a Country → Region → City taxonomy tree
- Provide a department/topic selector on a webform or profile entity reference field
- Give editors a document-taxonomy tree for classifying media or file entities
- Keep large controlled vocabularies usable by collapsing branches until the editor drills in
- Enforce mutually consistent tagging by auto-selecting parents in leaves-only mode
- Migrate a Drupal 7 Term Reference Tree field to Drupal 10/11 with the same tree UX
- Use the `checkbox_tree` render element directly in a custom form for hierarchical taxonomy selection
- Attach the tree widget to a paragraph or inline-entity-form term reference field
- Offer a nested tag tree on an article "Sections" field for site-section classification
- Show a compact, minimized tree on secondary reference fields to keep the edit form scannable
- Cap tagging depth so editors only choose among high-level categories, not every micro-term
- Pair the tree widget (input) with the tree formatter (display) for a consistent hierarchical look
