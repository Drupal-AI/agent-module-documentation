<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference (with) Hierarchy (entity_reference_hierarchy) — agent index

A **field type** that extends core `entity_reference` into a **rooted tree** by adding one
`depth` column per item. Parent/child structure is **derived in-memory** from field **delta
order + depth** — no parent-id column, no join table, no query service, **no SQL**. Package
*Field types*. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version **1.0.1**. No hard
dependencies.

## What it provides (from source)

- **Field type** `entity_reference_hierarchy` — `EntityReferenceHierarchyItem` extends core
  `EntityReferenceItem`; the `EntityReferenceHierarchyItemTrait` adds a `depth` schema column
  (`int`, `tiny`, `unsigned`) and a `depth` integer property. default_widget
  `entity_reference_hierarchy_autocomplete`, default_formatter `entity_reference_label`,
  list_class `EntityReferenceHierarchyFieldItemList`.
- **Widget** `entity_reference_hierarchy_autocomplete` (label *Autocomplete*) —
  `EntityReferenceHierarchyAutocompleteWidget` extends core autocomplete +
  `EntityReferenceHierarchyWidgetTrait` (adds a `depth` textfield per row, flags the multi-value
  table for the tabledrag tree).
- **Formatters** `entity_reference_hierarchy_entity_view` (*Rendered entity (with hierarchy)*) and
  `entity_reference_hierarchy_label` (*Label (with hierarchy)*) — extend the matching core
  formatters + `EntityReferenceHierarchyFormatterTrait`; render a nested `ol`/`ul` `item_list`.
- **List class + tree builder** `EntityReferenceHierarchyFieldItemList` +
  `EntityReferenceHierarchyFieldItemListTrait::getFieldHierarchyOutline()` — the API that turns
  delta+depth into a parent/children outline.
- **Module hooks** (`entity_reference_hierarchy.module`):
  `hook_field_formatter_info_alter` opens all core `entity_reference` formatters to the hierarchy
  types; `hook_preprocess_field_multiple_value_form` rebuilds the multi-value form as a tabledrag
  tree with a Depth column and indentation.
- **Library** `entity_reference_hierarchy/tabledrag.relationship-all` (`js/tabledrag.relationship-all.js`,
  depends on `core/tabledrag`) — adds the `all` tabledrag relationship used for group re-parenting.
- **Config schema** `field.storage_settings.entity_reference_hierarchy` (inherits core
  `field.storage_settings.entity_reference`). **No** routes, permissions, services, install file,
  Drush, or config/install objects. `configure` is null.

## Submodules (documented separately)

- `entity_reference_hierarchy_revisions` — revision-aware field type/widget/formatter on Entity
  Reference Revisions → [../modules/entity_reference_hierarchy_revisions/1.0.x/agent/start.md](../modules/entity_reference_hierarchy_revisions/1.0.x/agent/start.md)
- `entity_reference_hierarchy_ief` — Inline Entity Form complex widget with depth →
  [../modules/entity_reference_hierarchy_ief/1.0.x/agent/start.md](../modules/entity_reference_hierarchy_ief/1.0.x/agent/start.md)
- `entity_reference_hierarchy_paragraphs` — Paragraphs Classic hierarchy widget →
  [../modules/entity_reference_hierarchy_paragraphs/1.0.x/agent/start.md](../modules/entity_reference_hierarchy_paragraphs/1.0.x/agent/start.md)

## Solution docs

- **Field type, widget, storage & how depth becomes a tree** →
  [fields/field-type-and-widget.md](fields/field-type-and-widget.md)
- **The two hierarchy formatters + the formatter_info_alter hook** →
  [fields/formatters.md](fields/formatters.md)
- **`getFieldHierarchyOutline()` — computing parents/children/descendants in code** →
  [api/tree-outline.md](api/tree-outline.md)
