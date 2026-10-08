<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Multiple Selects — agent index

Adds one field widget, **"Multiple select list(s)"** (plugin id `multiple_options_select`),
for multi-value `entity_reference`, `list_integer`, `list_float`, and `list_string` fields.
Instead of a single `<select multiple>` box, it renders one plain (or Select2) `<select>` per
delta, reusing the field API's own "Add another item" / reorder mechanics. No settings form,
no configure route (`configure: null`), no permissions, no Drush, no hooks of its own — its
only persistent state is the widget's `element_type` setting on an `entity_form_display`
component.

- **Assign the widget to a field and choose `select` vs `select2`** →
  [configure/widget-settings.md](configure/widget-settings.md)
- **How the widget actually works: field_types, per-delta rendering, required-field
  validation, `_none` vs `''` handling** →
  [plugins/widget.md](plugins/widget.md)

Key fact: the widget only applies where field cardinality is greater than 1 (fixed or
unlimited) and the field type is one of the four above — on a single-value field it behaves
like an ordinary single select.
