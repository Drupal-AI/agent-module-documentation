<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Conflict Paragraphs is a submodule of Conflict that teaches the field-level conflict detection/merge system how to handle Paragraphs, so concurrent edits to entities that contain Paragraph reference fields are compared and merged correctly instead of clobbering nested paragraph structure.

---

Paragraphs are stored as `entity_reference_revisions` fields pointing at revisioned Paragraph
entities, which the generic Conflict comparison does not understand well. This submodule adds a
dedicated **`FieldComparator`** plugin, `conflict_field_comparator_paragraph_ref`
(`FieldComparatorParagraphReference`), that matches `field_type = "entity_reference_revisions"`
(any entity type / bundle / field name) and compares Paragraph reference fields by their nested
paragraph content and structure rather than by raw revision ids. It also registers an event
subscriber, `MergeRemoteStructure` (`conflict_resolution.merge_remote_paragraph_structure`,
tagged `event_subscriber`), on the parent module's `entity_conflict.resolve` pipeline to merge
remote changes to the paragraph *structure* (added/removed/reordered paragraphs) where possible.
The submodule has no configuration, routes, permissions, services beyond that subscriber, or
Drush — enabling it (alongside `conflict` and `paragraphs`) is the entire setup; it then plugs
into the parent module's existing discovery/resolution flow and the site's `conflict.settings`
resolution strategy. It is packaged as "Conflict (Experimental)".

---

- Safely handle two editors concurrently editing a node full of Paragraphs.
- Compare Paragraph reference fields by nested content, not just revision ids.
- Auto-merge remote additions/removals/reordering of paragraphs where non-conflicting.
- Prevent one editor's paragraph changes from silently wiping another's.
- Extend Conflict's three-way merge to `entity_reference_revisions` fields.
- Add paragraph-aware conflict resolution to a landing-page content type.
- Keep nested paragraph structure intact during concurrent edits.
- Support Paragraphs in an editorial workflow that relies on Conflict.
- Reuse the site's inline/dialog resolution style for paragraph conflicts.
- Merge structural (order/add/remove) paragraph changes made remotely.
- Reduce data loss on paragraph-heavy pages edited in multiple tabs.
- Provide the `conflict_field_comparator_paragraph_ref` comparator for reference-revisions fields.
- Combine with the parent Conflict module's FieldComparator system for full coverage.
- Enable robust concurrent editing on sites built with Paragraphs + Layout Paragraphs.
- Handle Paragraph reference conflicts without writing custom comparison code.
- Let the parent module's `entity_conflict.resolve` event merge paragraph structure.
- Give content teams confidence editing complex paragraph pages simultaneously.
