<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Component Fields computes one field's value from two other fields of the same type.

---

Component Fields **computes a bundle's "final" field from two "component" fields of the same field type**,
recalculating it on every entity save via a chosen compiler plugin (copy component 1 or 2, either with a
fallback to the other, merge multivalue values, or set empty). An optional per-entity override, stored as JSON
in a spare `string_long` field, lets editors pick the compiler case-by-case. It ships a `ComponentFieldsCompiler`
plugin type so developers can add their own logic, and its own admin permission, in the Custom package.

Use it to derive a single usable field value while keeping the source fields separate (e.g. an imported value
plus an editor override). The module renders nothing itself — final values are displayed by their normal field
formatters — and it adds no access control of its own beyond its admin permission; field visibility is left to
core field permissions. Configure it under Configuration → Component Fields.

---

- Compile a field from component parts.
- Build a composite field value.
- Assemble sub-values.
- Provide its own permissions.
- Serve content modeling.
- Structure field content.
- Follow normal field sanitization.
- Have no access-control role beyond permission.
- Configure the component field.
- Handle component fields.
- Compile fields.
- Configure the field.
- Assemble values.
- Handle the field.
- Build fields.
- Configure fields.
- Handle composition.
- Compose values.
- Set the field.
- Provide component fields.
