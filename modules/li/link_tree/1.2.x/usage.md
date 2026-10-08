<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Link tree extends the core Link field with a hierarchical, indentable tree structure of links.

---

The module adds a field type where multiple link items can be reordered and indented to express parent/child relationships, turning a flat multi-value link field into a nested tree (useful for building menu-like or table-of-contents structures inside content). It integrates with Linkit for autocompleting internal/external link targets. It is a field-types feature and follows the field/entity's normal access.

---

- Add a hierarchical link field to entities.
- Order multiple link items within a field.
- Indent link items to create parent/child levels.
- Build menu-like structures inside content.
- Create nested tables of contents as a field.
- Autocomplete link targets via Linkit.
- Link to internal entities or external URLs.
- Extend the core Link field type.
- Store structured link trees per entity.
- Render the tree with provided templates.
- Reuse across any fieldable entity type.
- Follow the host entity/field access model.
- Support Drupal 9 and 10.
- Avoid building separate menu entities for in-content nav.
- Reorder and re-nest links in the field widget.
- Provide a simple tree field for editors.
