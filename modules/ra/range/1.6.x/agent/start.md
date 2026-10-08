<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Numeric Range — agent index

Three field types that store a **FROM and a TO number in one field item**
(`range_integer`, `range_decimal`, `range_float`), one widget (`range`), five formatters and
Views filter/argument handlers. **No settings form, no configure route** (`configure: null`),
**no permissions, no services, no Drush, no plugin types of its own**. All state lives in
ordinary field / form-display / view-display config.

- **Create a range field, set min/max and the four prefix/suffix pairs, configure the widget
  and the formatters** → [configure/field-and-display.md](configure/field-and-display.md)
- **Plugin inventory: field type / widget / formatter ids, constraints, Views handlers,
  migrate plugins** → [plugins/inventory.md](plugins/inventory.md)
- **Twig templates and theme hooks for the rendered output** →
  [theming/templates.md](theming/templates.md)

Key facts:

- Storage columns are `from` and `to`; `mainPropertyName()` is **NULL**, so `$node->field_x->from`
  and `->to` are both required properties — there is no `->value`.
- Every range item carries the constraints `RangeBothValuesRequired` and `RangeFromGreaterTo`.
- Field settings: `min`, `max`, and four prefix/suffix pairs keyed `field`, `from`, `to`,
  `combined`.
- Every formatter shares `range_separator`, `range_combine` and the four
  `*_prefix_suffix` booleans.
