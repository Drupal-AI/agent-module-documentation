<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Multi Value Field lets you create one field that groups several sub-values together, editable as a set and rendered together.

---

The module implements a Field API triad: a `multivaluefield` FieldType (`src/Plugin/Field/FieldType/MultivaluefieldItem.php`), a matching FieldWidget, and a FieldFormatter, plus a `MultiValueFieldHelper` and a Feeds target (`src/Feeds/Target/MultiValueField.php`) for importing values. A bundled example submodule (`multivaluefield_example`) demonstrates configuration with a sample entity. It attaches its own library for the widget UI.

There are no routes, permissions, controllers, or services — access is governed entirely by the host entity's field access and form/display permissions, exactly like any core field. It is a pure content-modelling building block: define the field on any fieldable entity, arrange its columns via the widget, and theme the grouped output with the formatter.

---
- Store several related values in a single field instead of many separate fields.
- Group sub-values that always belong together (e.g. label + value pairs).
- Add a compact multi-part field to nodes, users, or any entity.
- Import multi-part values through a Feeds target.
- Keep related data atomic within one field for easier theming.
- Render the grouped sub-values together with the provided formatter.
- Edit all sub-values in one coherent widget.
- Model repeating structured data without a paragraph/entity reference.
- Reuse the field type across multiple content types.
- Prototype a content model quickly with the example submodule.
- Reduce form clutter by consolidating related inputs.
- Attach the field to media or taxonomy entities as well as nodes.
- Feed-import structured rows into the compound field.
- Present tabular field data consistently across displays.
- Simplify migrations that map to a single grouped field.
- Keep field configuration self-contained and portable.
