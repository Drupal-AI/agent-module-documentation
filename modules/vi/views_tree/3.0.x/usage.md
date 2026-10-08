<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Tree adds Views **style plugins** that render a view's rows as a nested hierarchy (a tree) using the adjacency model — each row names its own unique id and its parent's id, and the module reassembles them into parent/child nesting.

---

Views Tree provides three style plugins registered with Views: `tree` ("Tree (list)", themed as `views_tree`, rendered as a nested `<ul>`/`<ol>`), `tree_table` ("Tree (table)", themed as `views_tree_table`, a core table with an indented hierarchy column), and `tree_entity_reference_selection` ("TreeHelper (Adjacency model)", for entity-reference autocomplete/select widgets). Each style adds two required-ish options, **Main field** (`main_field`, the field holding each row's unique id) and **Parent field** (`parent_field`, the field holding the id of that row's parent); the table style also has **Hierarchy display column** (`display_hierarchy_column`). At render time the `views_tree.tree` service (`TreeHelper`) reads `views_tree_main`/`views_tree_parent` values off each result row, groups rows by parent starting from group `0` (the roots), and recursively builds a `TreeItem` render tree. The list style can be made **collapsible** (`collapsible_tree`: `Off` / `expanded` / `collapsed`) which attaches `views_tree/views_tree` (jQuery-based `collapsible.js`). Data is stored only in the view's own config entity (`views.view.*`) under the display's `style` options; the module defines no settings form, no configure route, no permissions, and no Drush. It also ships an `EntityReferenceSelection` plugin (`views_tree`) so a reference field can pull its options from a tree-styled view with indentation.

---

- Display a taxonomy vocabulary as an indented nested list in a view using the parent term id as the parent field.
- Show an organization chart from a "manager" self-reference on a Person content type.
- Render a threaded/nested comment-like structure where each row references its parent row.
- Build a nested category menu from content that stores a parent category id.
- Present a file/folder-style hierarchy in a table with an indented name column.
- Turn a flat book/page listing into a collapsible outline that editors can expand and collapse.
- Show a product category tree with parent SKUs feeding the hierarchy.
- Create an expandable FAQ tree grouped by parent topic.
- Display nested project → task → subtask rows from a single self-referencing entity.
- Provide a "Tree (table)" report where one column shows depth and the rest show flat columns.
- Populate an entity-reference autocomplete with hierarchically indented options via the `views_tree` selection handler.
- Let editors pick a parent term from a tree-indented select list backed by a view.
- Render a site-section hierarchy (adjacency model) without needing the Taxonomy menu.
- Show a company department → sub-department tree from an org entity.
- Collapse deep hierarchies by default (`collapsed`) so long trees stay scannable.
- Expand all levels by default (`expanded`) for print/export-style pages.
- Build a nested glossary or index grouped by parent letter/topic.
- Represent bill-of-materials assemblies (part → sub-part) from a parent reference.
- Show a multi-level navigation preview in the Views UI live preview.
- Add hierarchy `data-hierarchy-level` attributes to table rows for CSS/JS targeting.
- Style tree rows via the shipped `css/collapsible.css` / `css/table.css` layout libraries.
- Drive a nested content browser where each node references a container node.
- Convert an existing "Unformatted list" of hierarchical data into a proper nested tree by switching the style plugin.
- Reuse a single view as both a flat listing and a tree by cloning the display and changing the style.
