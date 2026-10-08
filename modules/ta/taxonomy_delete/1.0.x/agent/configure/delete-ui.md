<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Taxonomy Delete — admin UI

## Route & access
- Route `taxonomy_delete.ui`, path `/admin/structure/taxonomy/taxonomy-delete`
  (`_admin_route: TRUE`). Form: `Drupal\taxonomy_delete\Form\TaxonomyDeleteUIForm`.
- Requirement: `_permission: 'administer site configuration+delete taxonomy terms'`.
  The `+` means the user must hold **both** permissions to reach the form.
- Also surfaced as an action link and a menu link on the vocabulary collection
  (`entity.taxonomy_vocabulary.collection`), titled "Taxonomy Delete".

## Permission
`taxonomy_delete.permissions.yml` defines one permission:
- `delete taxonomy terms` — "Allows to delete taxonomy terms via UI.", `restrict access: TRUE`.

## Form behavior
- `buildForm()` loads all `taxonomy_vocabulary` entities into a `checkboxes` element
  (`#required`). If none exist it shows a warning linking to the add-vocabulary form and
  returns an empty form.
- `submitForm()` reads the ticked vocabulary ids, then:
  ```php
  $query = $storage('taxonomy_term')->getQuery();
  $query->condition('vid', $vocabularies, 'IN');
  $query->accessCheck(FALSE);   // no per-term access check
  $query->sort('tid');
  $tids = $query->execute();
  ```
- Every matched term id is added as its own Batch operation
  (`TaxonomyDeleteUIForm::deleteTerm`), so large vocabularies delete without timeouts.
  Each callback loads the term and calls `$term->delete()`, catching/logging
  `EntityStorageException`.
- On completion a status message is shown and an info line is written to the
  `taxonomy_delete` logger channel listing the emptied vocabularies. If no terms match,
  a "No taxonomy terms found." warning is shown instead.

## Notes
- There is no stored configuration and no config schema; the form is a one-shot action.
- Deletion is unconditional for the selected vocabularies (query bypasses entity access
  with `accessCheck(FALSE)`); reaching the form already requires the two restricted
  permissions above. There is no per-term confirmation in the UI (unlike the Drush
  command, which prompts) — the submit deletes immediately.
- Term deletion cascades through core the same as deleting a term normally (field data
  referencing the term, hierarchy children re-parented per core behavior).
