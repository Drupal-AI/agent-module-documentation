# Programmatic API — bulk term services

## `taxonomy_manager.helper` — `TaxonomyManagerHelper`

The bulk logic behind the UI is a reusable service (`taxonomy_manager.services.yml`).

```php
/** @var \Drupal\taxonomy_manager\TaxonomyManagerHelper $helper */
$helper = \Drupal::service('taxonomy_manager.helper');
```

### Mass-add terms

```php
$too_long = [];
// $input: one term per line; child terms prefixed with '-' (one dash per depth level);
// "name{delimiter}description" splits name/description (delimiter from settings, default '|').
// $parents: array of parent term ids (or 0). $keep_order: sequential weights after last term.
$new_terms = $helper->massAddTerms($input, $vid, $parents, $too_long, $keep_order = FALSE);
// Returns an array of the created Term entities. $too_long collects names truncated to the
// term-name field length (see getFieldNameLength()).
```

### Delete terms (with optional orphan handling)

```php
// $delete_orphans TRUE also deletes orphaned children; FALSE re-parents them (to remaining
// parents, or to root). Returns ['deleted_terms' => [...names], 'remaining_child_terms' => [...]].
$result = $helper->deleteTerms($tids, $delete_orphans = FALSE);
```

Other helpers: `vocabularyIsEmpty($vid)`, `getFieldNameLength()`.

## Entity-reference selection plugin — `filter_existing_terms`

`Drupal\taxonomy_manager\Plugin\EntityReferenceSelection\FilterExistingTermsSelection`
(plugin id `default:filter_existing_terms`) is a term selection handler that can exclude a set
of term ids from autocomplete results — used by the merge form's "existing term" field so you
can't merge a term into itself. Reuse it on an `entity_autocomplete` element via
`#selection_handler => 'default:filter_existing_terms'` with a `filter => ['tid' => [...]]`
selection setting.

## Access checker service

`taxonomy_manager.access_checker` (`TaxonomyManagerAccessCheck`, tag `access_check`,
`applies_to: _taxonomy_manager_access_check`) authorises the delete/move/term-edit routes
against core taxonomy permissions — see [permissions](../permissions/permissions.md).
