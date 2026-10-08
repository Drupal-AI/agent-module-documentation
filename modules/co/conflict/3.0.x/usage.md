<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Conflict detects and resolves field-level editing conflicts when two people (or processes) save changes to the same entity concurrently, auto-merging non-overlapping changes and offering an inline or dialog UI to resolve the fields that truly clash — instead of silently overwriting one edit.

---

When an entity edit form is submitted, Conflict compares the version the editor started from (the
original/base), the version currently stored (remote), and the submitted (local) values, field by
field. Field comparison is pluggable via **`FieldComparator`** plugins (annotation
`@FieldComparator` with `entity_type_id`/`bundle`/`field_type`/`field_name` targeting; the default
`conflict_field_comparator_default` matches everything). An event pipeline drives it: the
`entity_conflict.discovery` event (subscriber `DefaultConflictDiscovery`) finds conflicting paths,
and the `entity_conflict.resolve` event (subscriber `MergeRemoteOnlyChanges`) auto-merges changes
that only happened remotely, leaving genuine local↔remote clashes for the user. How those
remaining conflicts are presented is controlled by the `conflict.settings` config: a
`resolution_type` map keyed by entity type and bundle whose value is `inline` (embedded in the
form) or `dialog` (modal), falling back through `resolution_type.<type>.<bundle>` →
`resolution_type.<type>.default` → `resolution_type.default.default` (shipped default `inline`).
The module exposes services (`conflict_resolver.manager`, resolution form builders,
`conflict.field_comparator.manager`) and a `hook_conflict_paths_alter()` hook, but has **no admin
UI, configure route, permissions, or Drush** — configuration is done via config. The
`conflict_paragraphs` submodule adds Paragraphs support.

---

- Prevent two editors from silently overwriting each other's changes to the same node.
- Auto-merge non-conflicting field edits when two people save an entity concurrently.
- Show an inline conflict-resolution UI on the edit form when fields genuinely clash.
- Use a modal dialog instead of inline resolution for a given content type.
- Choose the resolution style (inline/dialog) per entity type and bundle via config.
- Protect long-form editorial content where accidental overwrites are costly.
- Add field-aware conflict detection to a custom entity type.
- Write a custom `FieldComparator` plugin for a field type that needs special comparison.
- Treat a specific field as never-conflicting (or always-conflicting) with a targeted comparator.
- Integrate concurrent-edit safety into a content-staging / Deploy workflow.
- Merge remote-only changes automatically so editors only see the fields that truly conflict.
- Alter the set of detected conflict paths programmatically via `hook_conflict_paths_alter()`.
- Resolve conflicts in code with the `conflict_resolver.manager` service (`resolveConflicts()`).
- Detect conflicts in code with `getConflicts()` for a local/remote/base entity triple.
- Support Paragraphs conflict handling by enabling the `conflict_paragraphs` submodule.
- Give a multi-author newsroom safe simultaneous editing of articles.
- Fall back to a sensible default resolution strategy for entity types you didn't configure.
- Keep the base revision an editor started from to compute an accurate three-way merge.
- Reduce data loss from stale edit forms left open in multiple tabs.
- Standardize conflict handling across the site by setting `resolution_type.default.default`.
