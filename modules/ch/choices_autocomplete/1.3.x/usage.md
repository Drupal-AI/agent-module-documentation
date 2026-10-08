<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Choices.js Autocomplete swaps core's select and entity-reference-autocomplete field widgets for ones built on the bundled Choices.js library: a searchable dropdown showing selections as removable chips, with keyboard navigation and tag-style autocreate. It also ships a reusable `choices_autocomplete` render element for custom forms.

---

Core's entity-reference autocomplete is a plain text field that shows selected values inline as text, so a multi-value field is edited as a string like `Item A (12), Item B (7)`; core's `<select>` for list fields becomes unwieldy once the option list is long. This module provides two field widgets — `entity_reference_choices` for `entity_reference` fields and `options_select_choices` for `list_integer` / `list_float` / `list_string` fields — that render the field with Choices.js instead: a separate search box, removable chips, and a filtered dropdown. Configuration is per field on the entity's Manage form display tab (there is no site-wide settings page): you choose the widget and set the placeholder/loading/no-results texts, dropdown position, result-list size, and — for reference fields with an autocreate handler — character and length limits on typed-in tags. Entity-reference search reuses Drupal core's own `system.entity_autocomplete` endpoint, so which entities are suggested is governed by the field's selection handler (standard or Views) exactly as with the core widget; Views handlers additionally let the suggestion and chip labels be rendered as rich HTML. It depends only on core (`^9 || ^10 || ^11`), bundles Choices.js locally rather than loading it from a CDN, and is a pure widget substitution — the field type and stored data are untouched, so you can switch a field to it and back per form display at any time. As with any replacement of a native control, verify keyboard and screen-reader behavior with the assistive technology your editors use before rollout; Choices.js is well regarded, but the accessibility responsibility moves into JavaScript.

---

- Show selected entity references as removable chips instead of inline text.
- Search a long reference list from a filtered dropdown.
- Improve editing of multi-value reference fields.
- Replace comma-separated autocomplete text with discrete tags.
- Give editors keyboard navigation in a reference picker.
- Reduce mistakes when removing one reference from many.
- Turn a taxonomy tagging field into a chip-and-search UI.
- Make a long vocabulary usable in a select widget.
- Apply Choices.js to `list_integer` / `list_float` / `list_string` select fields.
- Autocreate new tag entities inline with character and length limits.
- Restrict typed tag input to letters, numbers, or a custom allowlist.
- Enforce a minimum query length before searching.
- Cap the number of autocomplete suggestions shown.
- Render rich HTML labels for Views-based reference suggestions.
- Position the results dropdown above or below the field.
- Customize the placeholder, loading, and no-results messages per field.
- Match the control's styling to the Claro or Olivero admin theme.
- Add the `choices_autocomplete` element to a custom form.
- Alter the element and its JS settings via `hook_choices_autocomplete_element_alter()`.
- Switch a field to the widget per form display and back with no data change.
- Keep the field type and stored values unchanged while changing the editing UI.
- Support a site still on Drupal 9, 10, or 11 with one module.
- Improve reference entry ergonomics on mobile.
- Speed up tagging on content with many relationships.
