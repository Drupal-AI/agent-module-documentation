<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Conflict Paragraphs — agent index

Submodule of **Conflict** (needs `conflict` + `paragraphs`). Teaches Conflict's field-level
merge to compare/merge **Paragraph reference fields** (`entity_reference_revisions`). No config,
routes, permissions, or Drush — enabling it is the setup.

- **The FieldComparator plugin + merge subscriber it adds** →
  [plugins/paragraph-comparator.md](plugins/paragraph-comparator.md)

Key facts:
- Adds `FieldComparator` plugin `conflict_field_comparator_paragraph_ref`
  (`FieldComparatorParagraphReference`), matching `field_type = entity_reference_revisions`
  (`entity_type_id`/`bundle`/`field_name` = `*`).
- Adds event subscriber `MergeRemoteStructure`
  (`conflict_resolution.merge_remote_paragraph_structure`) on `entity_conflict.resolve`.
- Uses the parent module's `conflict.settings` resolution strategy and event pipeline.
  Parent docs: `modules/conflict/3.0.x/`.
