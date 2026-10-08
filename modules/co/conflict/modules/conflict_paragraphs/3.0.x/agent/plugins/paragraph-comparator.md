<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraph reference comparator & merge subscriber

This submodule contributes to the parent Conflict module's plugin/event system. You don't
configure it — enabling it registers the pieces below.

## FieldComparator plugin

- Id: **`conflict_field_comparator_paragraph_ref`**
  (`Plugin/Conflict/FieldComparator/FieldComparatorParagraphReference`).
- Annotation targeting: `entity_type_id = "*"`, `bundle = "*"`,
  **`field_type = "entity_reference_revisions"`**, `field_name = "*"`.
- Because it targets `entity_reference_revisions` (the field type Paragraphs use) more
  specifically than the parent's catch-all `conflict_field_comparator_default` (`field_type="*"`),
  it wins for Paragraph reference fields and compares them by their nested paragraph content /
  structure instead of raw revision ids (implements `FieldComparatorInterface::hasChanged()` /
  `getConflictType()`).

Verify it's registered:

```php
$defs = \Drupal::service('conflict.field_comparator.manager')->getDefinitions();
isset($defs['conflict_field_comparator_paragraph_ref']);   // TRUE when enabled
```

## Event subscriber

- Service `conflict_resolution.merge_remote_paragraph_structure`
  (`ConflictResolution\MergeRemoteStructure`), tagged `event_subscriber`.
- Subscribes to the parent module's `entity_conflict.resolve` event to merge remote changes to the
  **paragraph structure** (added / removed / reordered paragraphs) where they don't clash with
  local edits.

Everything else (resolution UI, `resolution_type` config, discovery pipeline) comes from the
parent Conflict module — see `modules/conflict/3.0.x/agent/`.
