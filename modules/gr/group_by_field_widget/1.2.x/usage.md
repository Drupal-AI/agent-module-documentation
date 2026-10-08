<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Group by Field Widget replaces the flat checkbox/radio list of an entity-reference field with nested, collapsible `details` groups, organising the choices by fields that live on the referenced entities.

---

Drupal's stock entity-reference widgets render every choice as one undifferentiated column, which gets hard to scan when a field references many entities or when those entities naturally belong to categories, departments, venues, or other parent records. This module's `group_by_field_reference_widget` (a single `@FieldWidget` extending `OptionsWidgetBase`, applicable to any `entity_reference` field) keeps the field type and stored values exactly as they are and only changes the form UI: it reads a configured "Group by" path — up to three levels, following entity-reference fields on the referenced entity, e.g. `field_facility.field_campus` — and wraps the options in nested `details` sections titled by the resolved parent entity's label. Multi-value fields render as checkboxes, single-value fields as radios (an optional radio can be cleared by clicking it again, via a small `core/once` behaviour). The selectable options themselves still come from the field's own selection handler, so referenceable-entity and access filtering are untouched; you can switch the widget on or off per form display at no cost. It is core-only, ships no routes/permissions/settings page, and its only configuration is the widget's own settings on *Manage form display*.

---

- Group a "Displays" reference field by Facility, then by Campus.
- Organise a long entity-reference checkbox list into sections.
- Show reference options under their parent record instead of a flat list.
- Group products referenced on a node by their category entity.
- Group employees by their department entity.
- Group locations by region or campus.
- Group events by venue.
- Group equipment by facility.
- Group documents by owning organisation.
- Add up to three nested grouping levels on one reference field.
- Follow an entity-reference chain to group by a grandparent entity.
- Turn a many-option reference field into a scannable picker.
- Reduce mis-selection on a large reference field.
- Render single-value reference fields as grouped radios.
- Render multi-value reference fields as grouped checkboxes.
- Let editors clear an optional radio selection by re-clicking it.
- Open all group sections by default for quick scanning.
- Keep grouping without changing how values are stored.
- Group options coming from a Views-based selection handler by chosen bundles.
- Switch to grouped display per form display, reversibly.
- Give editors parent context to tell similarly named options apart.
- Improve usability of a deeply referenced content model's edit form.
