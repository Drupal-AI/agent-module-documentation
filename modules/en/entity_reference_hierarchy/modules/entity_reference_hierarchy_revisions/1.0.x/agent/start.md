<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference (with) Hierarchy Revisions (entity_reference_hierarchy_revisions) — agent index

Submodule of **entity_reference_hierarchy**. Adds a **revision-aware** hierarchical field type
built on **Entity Reference Revisions**, so a tree can reference specific entity revisions.
Package *Field types*. Core `^9 || ^10 || ^11`. GPL-2.0-or-later. Version **1.0.1**.

**Dependencies:** `entity_reference_revisions:entity_reference_revisions`,
`entity_reference_hierarchy:entity_reference_hierarchy`.

## What it provides (from source, `modules/entity_reference_hierarchy_revisions/`)

- **Field type** `entity_reference_hierarchy_revisions` (label *Entity reference revisions tree*,
  category *Reference revisions*) — `EntityReferenceHierarchyRevisionsItem` extends
  `entity_reference_revisions`' `EntityReferenceRevisionsItem` and mixes in the parent module's
  `EntityReferenceHierarchyItemTrait` (adds the `depth` column). default_widget
  `entity_reference_hierarchy_revisions_autocomplete`, default_formatter `entity_reference_label`,
  list_class `EntityReferenceHierarchyRevisionsFieldItemList`.
- **List class** `EntityReferenceHierarchyRevisionsFieldItemList` extends
  `EntityReferenceRevisionsFieldItemList` + reuses the parent module's
  `EntityReferenceHierarchyFieldItemListTrait` → same `getFieldHierarchyOutline()`.
- **Widget** `entity_reference_hierarchy_revisions_autocomplete` — extends
  `EntityReferenceRevisionsAutocompleteWidget` + the parent module's
  `EntityReferenceHierarchyWidgetTrait` (adds the depth textfield + tabledrag flag).
- **Formatter** `entity_reference_hierarchy_revisions_entity_view` (*Nested Rendered entity*) —
  extends `EntityReferenceRevisionsEntityFormatter` + parent module's
  `EntityReferenceHierarchyFormatterTrait` (nested `ol`/`ul` output, `list_type` setting).
- **Config schema** `field.storage_settings.entity_reference_hierarchy_revisions`
  (inherits `field.storage_settings.entity_reference_revisions`) and
  `field.formatter.settings.entity_reference_hierarchy_revisions_entity_view`
  (inherits the entity_reference_revisions entity_view formatter settings).
- **No** routes, permissions, services, install file, or Drush. `configure` null.

## How it works

It is the parent module's mechanics applied to revision references: the `depth` column + delta
order encode the tree, the tabledrag tree UI comes from the parent module's preprocess hook
(the parent `hook_field_formatter_info_alter` also opens core entity_reference_revisions
formatters to this type), and rendering reuses `getFieldHierarchyOutline()`. It is the field type
the **Paragraphs** submodule's widget targets.

## Solution doc

- **Field type, widget, formatter & schema details** →
  [fields/revisions-field.md](fields/revisions-field.md)
