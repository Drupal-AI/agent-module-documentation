<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference (with) Hierarchy for Inline Entity Form (entity_reference_hierarchy_ief) — agent index

Submodule of **entity_reference_hierarchy**. Adds an **Inline Entity Form** complex widget that
lets you create/edit referenced entities inline while building the tree, with a **Depth** column.
Package *Field types*. Core `^9 || ^10 || ^11`. GPL-2.0-or-later. Version **1.0.1**.

**Dependency:** `inline_entity_form:inline_entity_form`.

## What it provides (from source, `modules/entity_reference_hierarchy_ief/`)

- **Widget** `inline_entity_form_hierarchy` (label *Inline entity form*) —
  `src/Plugin/Field/FieldWidget/InlineEntityFormHierarchy.php` extends IEF's
  `InlineEntityFormComplex`, `multiple_values = true`, `field_types = { entity_reference_hierarchy,
  entity_reference_hierarchy_revisions }`.
  - `formElement()` adds a `depth` textfield (`#size 3`, class `ief-entity-depth`, `#weight 100`)
    to **every** inline entity row, and flags `$element['entities']['#entity_reference_hierarchy_ief']`.
  - `massageFormValues()` reads the raw submitted values via `NestedArray::getValue()` and copies
    each row's `depth` onto the corresponding field delta before save.
- **Preprocess hook** (`entity_reference_hierarchy_ief.module`)
  `hook_preprocess_inline_entity_form_entity_table()` — when the table is flagged and the inline
  form handler reports `isTableDragEnabled()`, it appends a **Depth** header, injects
  `#theme => 'indentation'` per row (depth > 0), moves the depth field into a Depth cell, sets the
  three tabledrag ops (`order`/`all`, `depth`/`group`, `match`/`parent` on `ief-entity-delta` /
  `ief-entity-depth`), and attaches `entity_reference_hierarchy/tabledrag.relationship-all`.
- **No** config schema, routes, permissions, services, install, or Drush. `configure` null.

## How it works

Same tree encoding as the parent module (depth + row order), but the rows are IEF's inline entity
rows rather than autocomplete fields — so children are created/edited in place. Depth is captured
per row and merged back into the field values on submit.

## Solution doc

- **Widget, depth capture & the IEF table integration** →
  [fields/ief-widget.md](fields/ief-widget.md)
