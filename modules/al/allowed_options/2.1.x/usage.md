<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Allowed Options limits the available options of a list/options field at the individual form-display widget level, without changing the shared field storage.

---
A list field's `allowed_values` are defined once on the field storage and shared everywhere the field is used. When one form should offer only a subset of those options — for example a simplified editor form, or a specific bundle — there is normally no way to narrow the choices without cloning the field. Allowed Options solves this per widget instance.

It adds an **Allowed options** checkboxes control to supported widgets via `hook_field_widget_third_party_settings_form()`, storing the chosen keys as a widget third-party setting. At render time `hook_field_widget_single_element_form_alter()` intersects the element's `#options` down to just the selected keys (keeping `_none` where relevant), and only for real edit widgets (not the default-value widget). Because Drupal config storage rejects keys containing a dot, `hook_entity_form_display_presave()` normalizes the stored value to an array of selected keys. The full option list still lives on the field storage; the restriction is presentational per form display.

Setup: on Manage form display for the bundle, open a supported field widget's settings, tick only the options to expose there, and save.
---
- Show only a subset of a list field's options on one form
- Narrow options per form display without cloning the field
- Simplify an editor form to a few relevant choices
- Offer different option subsets on different bundles
- Restrict a `list_string` field's options per widget
- Restrict a `list_integer` field's options per widget
- Restrict a `list_float` field's options per widget
- Keep the full option set on the field storage untouched
- Preserve the `_none` empty option when restricting
- Configure allowed options in Manage form display
- Avoid duplicating fields just to vary their options
- Prevent editors from selecting deprecated option values
- Roll out a new option to only some forms first
- Hide legacy options from new content forms
- Keep option restrictions out of the field storage schema
- Apply restrictions only to real edit widgets, not default-value widgets
- Store selected keys safely despite config dot-key limitations
- Curate select-list choices per content workflow
- Reduce editor error by hiding irrelevant options
- Combine with existing list fields without data migration
