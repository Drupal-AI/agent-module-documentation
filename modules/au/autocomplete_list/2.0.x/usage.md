<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Autocomplete List provides an entity-reference field widget that pairs a single autocomplete box with a list-style display of the references already selected.

---
Core's multi-value entity-reference autocomplete renders one text row per value plus an empty spare, which is clumsy when selecting many references. This widget instead offers a single autocomplete field: each match the user picks is appended to a visible list and can be removed individually, driven by Drupal's AJAX API.

The plugin `EntityReferenceAutocompleteList` (widget id `entity_reference_autocomplete_list`) targets the `entity_reference` field type and is chosen on Manage form display. Its settings mirror the familiar autocomplete options — `match_operator` (`CONTAINS` or `STARTS_WITH`), textfield `size`, and `placeholder`. Selected values are validated against the field's constraints and rendered through `FieldFilteredMarkup`/`Html` for safe output.

Setup: on Manage form display for a bundle, set a multi-value entity-reference field's widget to **Autocomplete (List style)** and configure the match operator, size and placeholder.
---
- Select many referenced entities from one autocomplete box
- Replace core's row-per-value reference widget
- Add references to a running selected-list via AJAX
- Remove a selected reference from the list
- Reference multiple taxonomy terms cleanly
- Reference multiple nodes in one field
- Reference multiple users in one field
- Choose `CONTAINS` autocomplete matching
- Choose `STARTS_WITH` autocomplete matching
- Set the autocomplete textfield width
- Set placeholder text for the autocomplete box
- Improve UX for high-cardinality reference fields
- Apply the widget on Manage form display
- Keep entity-reference validation constraints intact
- Render selected labels with safe filtered markup
- Speed up tagging content with many terms
- Reduce form clutter on multi-value reference fields
- Use with any `entity_reference` field type
- Provide a list-style alternative to select or checkboxes
- Streamline curating related-content reference lists
