<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Restrict field options per widget

Allowed Options adds a third-party settings section to list/options field widgets so a single field storage's `allowed_values` can be narrowed on a specific form display, without editing the field storage.

## How it works
- `hook_field_widget_third_party_settings_form()` adds an **Allowed options** checkboxes element (keyed by the field storage's `allowed_values`) to supported widgets.
- `hook_field_widget_single_element_form_alter()` reads the widget's `allowed_options` third-party setting and, on non-default-value widgets, intersects the element `#options` down to the selected keys (preserving a `_none` option when present).
- `hook_entity_form_display_presave()` (`allowed_options_entity_form_display_presave`) rewrites the stored setting to an array of selected keys, because keys containing a dot `.` are not allowed by Drupal config storage.

## Supported field types
See `_allowed_options_supported_field_types()` in the `.module` (options/list-style fields such as `list_string`, `list_integer`, `list_float`, and boolean-style options).

## Usage
1. Manage form display for the entity bundle.
2. On a supported field widget open its settings and tick only the options that should appear on this form.
3. Save — other forms/displays keep the full option set.
