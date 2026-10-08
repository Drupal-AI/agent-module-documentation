<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bulk Paragraph Delete lets an administrator delete several Paragraphs types at once from the admin UI.

---

Bulk Paragraph Delete adds one admin form, at `/admin/structure/paragraphs_type/bulk-paragraph-delete`, that lists every Paragraphs type in a tableselect and deletes the selected ones in a single submit — instead of opening each type's own delete form separately. Before deleting a type it scans all `field_config` entities for a reference handler whose `target_bundles` include that type; any type still referenced by a field is skipped with a warning naming the fields that use it, so the bulk delete never breaks configuration dependencies. Unused types are deleted and a status message reports how many were removed. The form is reached via a "Bulk Delete Paragraphs" action link on the Paragraph types listing and is gated by the Paragraphs module's `administer paragraphs` permission. It requires the Paragraphs module and supports Drupal 10.3+ and 11.

---

- Delete several Paragraphs types in one operation instead of one at a time.
- Clean up unused paragraph types after a site redesign or content model change.
- Remove paragraph types left behind by an abandoned feature or prototype.
- Select which types to delete from a checkbox table with select-all.
- Skip types still referenced by a field, avoiding config-dependency errors.
- See exactly which fields still reference a type you tried to delete.
- Reach the tool from the "Bulk Delete Paragraphs" action link on the Paragraph types page.
- Restrict the operation to users who hold `administer paragraphs`.
- Report how many types were successfully deleted after submit.
- Tidy a large paragraph library down to the types actually in use.
- Reduce the Paragraph types listing to a manageable set.
- Speed up decommissioning of a group of related paragraph types.
- Enforce a dependency check before every bulk deletion.
- Keep configuration exports free of stale paragraph-type definitions.
- Support Drupal 10.3 and Drupal 11 sites that use Paragraphs.
- Operate entirely through the admin UI with no configuration to set up.
- Use as a maintenance step when consolidating overlapping paragraph types.
- Batch-remove test or demo paragraph types before a production release.
- Confirm which paragraph types are safe to remove (unreferenced) at a glance.
- Complement the Paragraphs admin workflow for structure cleanup.
