# How bulk term deletion works

No public service/API — the module is a form alter + confirm form + batch. This doc maps the flow
so you don't have to read the source.

## Routes (`taxonomy_multidelete_terms.routing.yml`)

- `taxonomy_multidelete_terms.delete` — path
  `/admin/structure/taxonomy/manage/{taxonomy_vocabulary}/overview/delete`, form
  `Drupal\taxonomy_multidelete_terms\Form\DeleteTermsConfirm`, permission
  `access taxonomy multidelete terms`. The confirmation page.
- `taxonomy_multidelete_terms.overview_form` — path
  `/admin/structure/taxonomy/manage/{taxonomy_vocabulary}/overview` (the vocabulary overview; used
  as the cancel/redirect target).

## Flow

1. **Form alter** — `taxonomy_multidelete_terms_form_alter()` targets form id
   `taxonomy_overview_terms`. For permitted users it adds a `check-delete` checkbox to each term
   row, a "select all" header (`core/drupal.tableselect`), and an `actions][delete]` submit button
   with its own submit + validate callbacks. Only added when the term rows show a `weight` element
   (i.e. the vocabulary list is in editable state).
2. **Validate** — `taxonomy_multidelete_terms_taxonomy_overview_terms_validate()` errors if no term
   was selected.
3. **Submit** — `taxonomy_multidelete_terms_taxonomy_overview_terms_submit()` writes the selected
   `terms` values and the vocabulary id into the private tempstore
   (`\Drupal::service('tempstore.private')->get('taxonomy_multidelete_terms')`, keys `deletedterms`
   and `vocabulary`) and redirects to the confirm route.
4. **Confirm** — `DeleteTermsConfirm` reads the tempstore, lists the selected terms, warns that a
   term's children are deleted too, and on confirm sets up a Batch.
5. **Batch** — `Drupal\taxonomy_multidelete_terms\TaxonomyMultideleteBatch`:
   - `processTerms($tids, &$context)` — `loadMultiple($tids)` then `->delete($entities)` on the
     `taxonomy_term` storage.
   - `finishProcess()` — shows a "N term(s) deleted" message.

## To delete terms programmatically instead

You do not need this module to delete terms in code — it just provides the UI. Equivalent:

```php
$storage = \Drupal::entityTypeManager()->getStorage('taxonomy_term');
$storage->delete($storage->loadMultiple([$tid1, $tid2, $tid3]));
```
