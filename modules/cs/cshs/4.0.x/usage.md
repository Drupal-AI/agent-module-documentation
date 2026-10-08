Client-side Hierarchical Select (CSHS) provides a compact, client-side drill-down select widget for choosing taxonomy terms, showing one dropdown per hierarchy level so editors can pick a deep term without a giant flat list.

---

CSHS replaces the standard term-reference select with a widget that reveals child-level dropdowns as you choose a parent, entirely in the browser. It is implemented as a reusable form element (`cshs`) plus a field widget (`id: cshs`) for `entity_reference` fields that target a taxonomy vocabulary. Widget settings control behavior: save the full lineage of the selection, force the editor to pick the deepest level, restrict the tree to a chosen parent term, and set custom labels per hierarchy level. For display it ships four field formatters — full hierarchy, flexible hierarchy, group-by-root, and specific-taxonomy-level — so the chosen term can be rendered with or without its ancestors. It also provides Views filter plugins (including a "depth"-aware term filter) for building faceted term filters, a Conditional Fields handler, and Twig templates via `hook_theme` for full theming control. It depends only on core Field and Taxonomy. A companion submodule, **cshs_menu_link**, brings the same hierarchical selector to the parent-menu-item picker on node and term forms.

---

- Replace a long flat taxonomy select with level-by-level dropdowns.
- Let editors drill down a deep vocabulary (e.g. category → subcategory → item).
- Require selection of the deepest (leaf) term only.
- Save the full lineage of the chosen term, not just the leaf.
- Restrict a term field's tree to a specific parent branch.
- Give each hierarchy level a custom label ("Region", "Country", "City").
- Use the `cshs` render element in a custom form for hierarchical term picking.
- Display a chosen term with its full ancestor path.
- Render only a specific taxonomy level of the selected term.
- Group displayed terms by their root parent.
- Show a flexible hierarchy formatter that adapts to depth.
- Build a Views exposed filter that drills down through term hierarchy.
- Filter a view by term with depth awareness.
- Improve UX on content types with large geographic or product taxonomies.
- Reduce mistakes from scrolling a huge single select.
- Provide a hierarchical parent picker for menu links (via cshs_menu_link).
- Choose a parent term for a new term on the taxonomy term form.
- Theme the widget markup via the provided Twig templates.
- Use it on any entity_reference field pointing at a vocabulary.
- Combine with Conditional Fields using the bundled handler.
- Keep term selection fast on the client with no extra AJAX round-trips per level.
- Standardize hierarchical term entry across multiple content types.
- Present a cleaner term selector on mobile/narrow screens.
- Force consistent categorization by hiding non-leaf choices.
