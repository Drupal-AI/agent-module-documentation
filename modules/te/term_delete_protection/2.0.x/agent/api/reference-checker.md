# `TermReferenceChecker` service

Service id `term_delete_protection.reference_checker` →
`Drupal\term_delete_protection\Service\TermReferenceChecker` (`src/Service/TermReferenceChecker.php`).
Reusable to answer "is this term (or its descendants) in use?" from your own code.

Constructor deps: `entity_type.manager`, `entity_field.manager`, `module_handler`, `config.factory`.

## Public methods

| Method | Returns | Notes |
|---|---|---|
| `checkTermReferences(TermInterface $term): array` | `['has_references' => bool, 'reason' => string]` | Term is protected if it, or any descendant term, is referenced by an enabled entity type. `reason` is a human message. |
| `isTermReferencedByEntity(int $term_id, string $vocabulary_id): bool` | bool | Direct reference check across the vocabulary's `protected_entity_types` only. |
| `getAvailableEntityTypes(): array` | `[entity_type_id => ['id','label']]` | Content entity types (excluding `file`, `user`, `taxonomy_term`, `menu_link_content`, `shortcut`, `comment`, `path_alias`, `redirect`) that have a `default:taxonomy_term` reference field. Sorted by label. Drives the vocabulary form checkboxes. |
| `getAllRelatedEntities(int $term_id, string $vocabulary_id): array` | entities grouped by entity type | Used to build the warning list on the term edit form. |

Protected/internal helpers: `getProtectedEntityTypes()` (reads config),
`isTermReferencedByEntityType()` (per-type query), `hasDescendantTermsReferencedByEntities()` (recursive
`loadTree` with a `$checked_terms` loop guard), `getAllRelatedEntitiesByType()` / `getEntitiesForTerm()`
(range 0–5, `sort('created','DESC')`), `getParagraphParentEntity()` (resolves a paragraph's
`parent_type`/`parent_id`).

## Reference detection details

- Discovers fields via `entityFieldManager->getFieldMapByFieldType('entity_reference')`, then loads each
  `field_config` and keeps only those with `settings['handler'] === 'default:taxonomy_term'`.
- Entity queries use `->accessCheck(TRUE)` and `->range(0, 1)` for existence (or `0,5` for listings).
- Paragraphs: a referencing paragraph only counts if `getParagraphParentEntity()` resolves a live parent
  (so orphaned paragraphs don't block deletion); the warning links to the parent entity, not the paragraph.

## Example

```php
$checker = \Drupal::service('term_delete_protection.reference_checker');
$term = \Drupal\taxonomy\Entity\Term::load(42);
$result = $checker->checkTermReferences($term);
if ($result['has_references']) {
  // $result['reason'] explains why; block or warn.
}
```
