<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Multiple Selects adds a field widget ("Multiple select list(s)", plugin id `multiple_options_select`) that renders a multi-value options field as one ordinary `<select>` per value instead of a single `<select multiple>` box.

---

The module targets fields with `field_types = {entity_reference, list_integer, list_float, list_string}` whose cardinality is greater than one (fixed or unlimited). It subclasses core's `OptionsSelectWidget`, keeping the field API's own per-delta form structure (table rows, drag-to-reorder weights, "Add another item" button) but forcing each row's element to render as a single, non-multiple select instead of one shared multi-select spanning all deltas. A widget setting, `element_type`, lets the site builder choose between plain `select` and, if the `select2` module is installed, `select2` per row. Because Drupal Core and Select2 represent "nothing chosen" differently (`_none` vs `''`), the widget normalizes both on validation so an unselected row is stored as no value rather than a stray placeholder. When the field is required, a custom `#element_validate` callback checks all deltas together and only raises "field is required" if every row is empty, attaching the error to whichever empty delta has the lowest drag weight. The module ships a config schema for its one setting and a post_update hook that backfills `element_type: select` onto any pre-existing `entity_form_display` components that used the widget before the setting existed.

---

- Give editors one plain `<select>` per tag instead of a scrolling multi-select box for a `field_tags` (taxonomy term reference) field.
- Let editors pick several related products via `entity_reference` using individual dropdowns rather than ctrl/cmd-click multi-select.
- Present a fixed number of category dropdowns (e.g. exactly 3) on a `list_string` field with cardinality set to 3.
- Support "Add another item" so editors can add extra single-select rows on an unlimited-cardinality `list_integer` field.
- Improve accessibility/usability over native `<select multiple>`, which is notoriously awkward on touch devices.
- Replace a multi-select widget on an `entity_reference` field targeting users, nodes, or taxonomy terms.
- Combine with the `select2` module so each individual row becomes a searchable Select2 dropdown instead of a native select.
- Offer a friendlier multi-value picker on a `list_float` field of numeric options (e.g. size ratings).
- Let content editors reorder chosen values using the field API's native drag-and-drop weight handles, one per select row.
- Enforce "at least one value" on a required multi-value field without forcing every row to be filled.
- Migrate an older site's form displays so widgets that predate the `element_type` setting still work, via the module's post_update hook.
- Present per-value dropdowns on a `taxonomy_term` reference field with a large vocabulary that would otherwise render as an unwieldy multi-select box.
- Give each value its own select in a "related content" `entity_reference` field on an article or page content type.
- Configure the widget once on Manage Form Display and have it apply consistently across every row added afterward.
- Swap an existing multi-select widget for individual per-row selects without changing the underlying field storage or data.
- Use the widget on a fixed-cardinality `list_integer` field (e.g. priority 1-3) so editors see exactly the right number of dropdowns.
- Avoid teaching content editors how to multi-select with modifier keys by giving them familiar single-value dropdowns instead.
- Pair the widget with core's field validation so a required field still enforces "choose at least one" across all its rows.
- Offer per-row Select2 autocomplete search only where the `select2` module is enabled, falling back to plain selects elsewhere.
- Let site builders change the rendered element type (select vs. select2) per field via a widget settings form, no code required.
- Present a "skills" or "interests" `entity_reference` field as a stack of single dropdowns instead of one large multi-select.
