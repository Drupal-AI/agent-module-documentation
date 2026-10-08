<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference View Mode (entityreference_view_mode) — agent index

**Compound field = entity reference + chosen view mode; the formatter renders the referenced entity in that view mode.**

- **Version:** 2.x  **Core:** ^8 || ^9 || ^10 || ^11
- **Depends:** field (core)
- **Plugins:** FieldType `EntityReferenceViewModeFieldType`, FieldWidget `EntityReferenceViewModeFieldWidget` (+Trait), FieldFormatter `EntityReferenceViewModeFieldFormatter` (under `src/Plugin/Field`).
- **No** routes, permissions, services or config of its own.
- **Security:** field plugins only — no anonymous endpoints, no server-side I/O, no raw SQL/deserialization. Rendering uses the core entity view builder, which enforces the referenced entity's access and display config.

See [plugins/field.md](plugins/field.md).
