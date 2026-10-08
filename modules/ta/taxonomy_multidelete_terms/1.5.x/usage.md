Taxonomy Multi-delete Terms adds a checkbox to each row of a vocabulary's term overview page plus a "Delete" button, so an editor can select many taxonomy terms and delete them all at once (via a confirmation form and a batch process) instead of deleting them one by one.

---

The module is a small UI enhancement for core Taxonomy. It implements
`hook_form_FORM_ID_alter()` on `taxonomy_overview_terms` (the *Manage terms* list at
`/admin/structure/taxonomy/manage/{vocabulary}/overview`) to inject a "check-delete" checkbox
into every term row, a "select all" header checkbox (using `core/drupal.tableselect`), and a
"Delete" submit button — but only for users who hold the module's `access taxonomy multidelete terms`
permission and only when the vocabulary list is in its editable (weight-showing) state. On submit
it stores the selected term data in a private tempstore and redirects to a confirmation form
(`DeleteTermsConfirm`, route `taxonomy_multidelete_terms.delete`) that lists the terms and warns
that deleting a term also deletes its children. Confirming runs a Batch API job
(`TaxonomyMultideleteBatch::processTerms`) that loads the selected term entities and deletes them
in one operation, then reports how many terms were deleted. The module has no settings, no config
schema, no services, no Drush commands, and `configure` is null; its only routes are the delete
confirmation form and an override of the vocabulary overview route.

---

- Delete dozens of unused taxonomy terms from a vocabulary in a single action instead of one at a time.
- Clean up an imported vocabulary that arrived with many junk or duplicate terms.
- Select all terms in a vocabulary and remove them at once (with a confirmation step).
- Bulk-remove a subset of tags from a "Tags" vocabulary that are no longer relevant.
- Purge test/demo taxonomy terms after content modelling experiments.
- Delete a branch of a hierarchical vocabulary knowing children are removed along with parents.
- Give content editors a faster term-cleanup workflow without needing Views Bulk Operations.
- Tidy a category vocabulary before a site launch by mass-deleting placeholder terms.
- Remove terms migrated from a legacy system that were flagged for deletion.
- Restrict bulk term deletion to trusted roles via the `access taxonomy multidelete terms` permission.
- Let editors preview exactly which terms will be deleted on a confirmation page before committing.
- Delete many terms via a batch process so large vocabularies don't time out.
- Reduce clicks when maintaining large controlled vocabularies (hundreds of terms).
- Clear out an entire vocabulary's terms while keeping the vocabulary itself.
- Bulk-delete seasonal or campaign tags at the end of a campaign.
- Remove obsolete product-category terms after a catalogue restructure.
- Support editorial governance by making mass term cleanup a permissioned, auditable action.
- Delete selected terms and see a "N terms deleted" confirmation message afterwards.
- Use the standard taxonomy overview UI (no separate admin screen) to perform bulk deletions.
- Avoid writing custom code or a Drush script just to delete a set of terms.
