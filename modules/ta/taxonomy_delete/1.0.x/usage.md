<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Taxonomy Delete is a utility module that bulk-deletes every term in one or more vocabularies, from either an admin UI or a Drush command.

---

The module adds a single admin form at `/admin/structure/taxonomy/taxonomy-delete` (route `taxonomy_delete.ui`, also linked as an action/menu item on the vocabulary collection page). The form lists all vocabularies as checkboxes; on submit it queries every `taxonomy_term` whose `vid` is in the selected set and deletes them through a Batch API process (`TaxonomyDeleteUIForm::deleteTerm()` / `BatchService::deleteTerm()`), one term per operation. For developers it also ships a Drush command `taxonomy-delete:term-delete` (alias `tdel`) that takes a comma-separated list of vocabulary machine names, prompts for confirmation, then runs the same batch delete. Access is gated by the permission `delete taxonomy terms` (marked `restrict access`), combined on the route with `administer site configuration` (`_permission: 'administer site configuration+delete taxonomy terms'`, i.e. the user needs BOTH). The term query runs with `accessCheck(FALSE)`, so once a user reaches the form every term in the chosen vocabularies is removed regardless of per-term entity access. There is no config schema and no stored settings — the module is purely an action tool. It is aimed at clearing out large/imported/test term sets that are tedious to delete one by one in core.

---

- Delete every term in a vocabulary in one action instead of removing them individually.
- Clear out a large imported or test taxonomy before re-importing clean data.
- Empty several vocabularies at once by ticking multiple checkboxes on the delete form.
- Wipe terms created by a migration trial run during development.
- Reset a "Tags" vocabulary that has accumulated junk or spam terms.
- Remove all terms via Drush in CI or a deployment script: `drush tdel my_vocab`.
- Delete terms from multiple vocabularies in one Drush call: `drush taxonomy-delete:term-delete tags,categories`.
- Script taxonomy teardown as part of an automated test-data reset.
- Free an editor from clicking "Delete" on hundreds of terms manually.
- Provide site builders a safe, permission-gated button to purge a vocabulary.
- Batch-delete a huge term set without PHP timeouts (processed one term per batch operation).
- Confirm before destructive deletion when run from the command line (interactive prompt).
- Log which vocabularies were emptied (writes an info entry to the `taxonomy_delete` logger channel).
- Purge terms left behind after deleting the fields that referenced them.
- Give QA a quick way to reset a vocabulary between test runs.
- Remove demo/sample terms shipped with a starter kit or recipe.
- Clean up a vocabulary before uninstalling the module that created it.
- Delete terms from a vocabulary that the core UI struggles to paginate.
- Restrict who can bulk-delete terms via the dedicated `delete taxonomy terms` permission.
- Add a "Taxonomy Delete" action link directly on the Taxonomy vocabularies admin page.
