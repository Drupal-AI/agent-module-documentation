<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference (with) Hierarchy for Paragraphs (entity_reference_hierarchy_paragraphs) — agent index

Submodule of **entity_reference_hierarchy**. Adds a **Paragraphs Classic** widget with a Depth
column so nested paragraph layouts can be authored on one revisioned hierarchy field. Package
*Field types*. Core `^9 || ^10 || ^11`. GPL-2.0-or-later. Version **1.0.1**.

**Dependencies:** `entity_reference_hierarchy:entity_reference_hierarchy_revisions`,
`entity_reference_hierarchy:entity_reference_hierarchy`, `paragraphs:paragraphs`.

## What it provides (from source, `modules/entity_reference_hierarchy_paragraphs/`)

- **Widget** `entity_reference_hierarchy_paragraphs` (label *Paragraphs Classic*) —
  `src/Plugin/Field/FieldWidget/InlineParagraphsHierarchyWidget.php` extends Paragraphs'
  `InlineParagraphsWidget` and reuses the parent module's
  `EntityReferenceHierarchyWidgetTrait`. `field_types = { entity_reference_hierarchy_revisions }`.
  - `formElement()` adds a `depth` textfield per paragraph row (default the item's depth or `0`).
  - `formMultipleElements()` flags `#entity_reference_hierarchy_paragraphs` on the multi-value form.
- **Preprocess hook** (`entity_reference_hierarchy_paragraphs.module`)
  `hook_preprocess_field_multiple_value_form()` — when flagged, appends a **Depth** header,
  indents each row (`#theme => 'indentation'` for depth > 0), moves the depth field into its own
  Depth column, sets the three tabledrag ops (`order`/`all`, `depth`/`group`, `match`/`parent`),
  and attaches `entity_reference_hierarchy/tabledrag.relationship-all`.
- **No** config schema, routes, permissions, services, install, or Drush. `configure` null.

## How it works

Same delta+depth tree encoding as the parent module, applied to the Paragraphs inline widget: each
paragraph row gets a depth control and the multi-value table becomes a drag-and-drop tree. It only
targets the **revisions** hierarchy field type (`entity_reference_hierarchy_revisions`), because
Paragraphs stores target revisions.

## Solution doc

- **Widget & the paragraphs tree table** →
  [fields/paragraphs-widget.md](fields/paragraphs-widget.md)
