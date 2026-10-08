<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference View Mode provides a compound field type that stores both an entity reference (target id) and a view mode, so an editor can reference another entity and choose which view mode it renders in.

---

It ships a field type (`EntityReferenceViewModeFieldType`), a widget (`EntityReferenceViewModeFieldWidget` + trait) and a formatter (`EntityReferenceViewModeFieldFormatter`), all under `Plugin/Field`, depending only on core `field`. On the entry form the widget presents the entity selection alongside a view-mode selector; on display the formatter loads the referenced entity and renders it through the selected view mode. This is useful when the same reference should appear differently depending on context chosen per item (for example a teaser here, full there), without creating multiple fields or display configurations.

The module defines no routes, permissions, services or config schema of its own — it is purely field plugins, so it has no anonymous endpoints and no server-side I/O. Rendering goes through the standard entity view builder, which applies the referenced entity's own access checks and view-mode display configuration. There is no raw SQL, deserialization of request data, or markup construction outside the render system.

---
- Add an *Entity Reference View Mode* field to a bundle.
- Configure the field's target entity type.
- Select a target entity in the widget when editing content.
- Choose the view mode used to render that reference.
- Render a referenced node as a teaser in one place.
- Render the same entity type as full content elsewhere.
- Vary the display per item without extra fields.
- Use it on nodes, media, taxonomy or other content entities.
- Combine reference + view mode in a single compound value.
- Let editors pick the presentation context per reference.
- Rely on the entity view builder for access-checked rendering.
- Avoid duplicating display configs for different contexts.
- Place the formatter on the parent entity's display.
- Swap the view mode of a reference without recreating it.
- Reference and render across bundles with one field.
