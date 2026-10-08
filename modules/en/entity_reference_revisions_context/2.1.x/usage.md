<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Revisions Context provides a field formatter that renders an entity_reference_revisions field like the core "Rendered entity" formatter, but tags each item with data-* attributes describing its position within the set.

---

The module ships a single field formatter, "Rendered entity with context" (plugin id `entity_reference_revisions_entity_view_context`), that subclasses the Entity Reference Revisions module's own rendered-entity formatter. After the parent renders each referenced revision (respecting the referenced entities' own view access), it walks the rendered elements and attaches HTML `data-*` attributes to each one: whether it is first or last in the list, the bundle of the previous and next item, an incrementing "group" number that changes whenever the bundle changes, its 1-based position, and whether that position is odd or even. These attributes are aimed at front-end theming and JavaScript that needs to reason about where a paragraph sits within a set — for example alternating layouts, first/last spacing, or grouping consecutive paragraphs of the same type. It depends on the Entity Reference Revisions module and is most commonly used with Paragraphs. It has no configuration form, no settings of its own beyond those inherited from the parent formatter, no permissions, and no routes.

---

- Render a Paragraphs (entity_reference_revisions) field and expose each paragraph's position to CSS/JS.
- Select "Rendered entity with context" on Manage display for an entity_reference_revisions field.
- Style the first paragraph in a set differently using the `data-entity-context-first` attribute.
- Style the last paragraph in a set differently using the `data-entity-context-last` attribute.
- Alternate row backgrounds with the `data-entity-context-odd` / `data-entity-context-even` attributes.
- Add top or bottom spacing only to the first/last item in a stack of paragraphs.
- Detect the bundle of the preceding paragraph via `data-entity-context-prev` for adjacency-based styling.
- Detect the bundle of the following paragraph via `data-entity-context-next` for adjacency-based styling.
- Collapse the gap between two consecutive paragraphs of the same type using prev/next bundle attributes.
- Visually group consecutive same-bundle paragraphs using the incrementing `data-entity-context-group` number.
- Apply zebra striping to grouped sets of paragraphs rather than to individual items.
- Drive JavaScript behaviours that depend on a paragraph's index within its field.
- Target the Nth paragraph in a set with `data-entity-context-position`.
- Build "hero-first" layouts where the first item spans full width and the rest are columns.
- Round the corners of only the first and last card in a stacked list.
- Add separators between groups of differing paragraph types.
- Theme a landing page built from Paragraphs where layout depends on sibling context.
- Provide contextual hooks for animation libraries that stagger items by position.
- Replace brittle nth-child CSS with explicit, bundle-aware position attributes.
- Keep the referenced entities' normal access checks while still adding positional context.
- Use it as a drop-in replacement for the standard ERR "Rendered entity" formatter when sibling context is needed.
- Combine with view modes so each referenced revision still renders in its configured view mode plus context attributes.
