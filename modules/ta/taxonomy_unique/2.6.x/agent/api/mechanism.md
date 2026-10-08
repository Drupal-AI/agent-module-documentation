# How enforcement works + API

## The constraint on `name`

`hook_entity_base_field_info_alter()` adds the `taxonomy_unique` validation constraint to the
`name` base field of the `taxonomy_term` entity type:
```php
if ($entityType->id() == 'taxonomy_term' && !empty($fields['name'])) {
  $fields['name']->addConstraint('taxonomy_unique');
}
```
So it runs whenever a term is validated (core entity validation on save).

## The validator

`Plugin/Validation/Constraint/TaxonomyUniqueValidator::validate()`:
1. Loads the term's vocabulary (`taxonomy_vocabulary` storage, keyed by `$term->bundle()`).
2. **Only acts** if `getThirdPartySetting('taxonomy_unique', 'enabled')` is TRUE.
3. Calls `taxonomy_unique.manager->isUnique($term)`; if not unique, reads the vocabulary's
   `message` third-party setting (falls back to the default), sets it as the constraint
   error, and adds a violation with `%term` and `%vocabulary` placeholders.

Constraint plugin: `@Constraint(id = "taxonomy_unique")`, class `TaxonomyUnique`, default
message in `TaxonomyUniqueConstants::NOT_UNIQUE_DEFAULT_ERROR_MESSAGE`.

## The service — `taxonomy_unique.manager`

Class `Drupal\taxonomy_unique\TaxonomyUniqueManager` (constructor arg: `@entity_type.manager`).

```php
public function isUnique(\Drupal\taxonomy\TermInterface $term): bool
```
Runs a term entity query with `accessCheck(FALSE)` and conditions on `vid` (= `$term->bundle()`),
`name` (= `$term->getName()`), `langcode`, tagged `taxonomy_unique` with the term as metadata.
Returns TRUE when no other term matches (an existing match that is the term itself still counts
as unique, so editing/saving an unchanged term is allowed).

Call it directly:
```php
$unique = \Drupal::service('taxonomy_unique.manager')->isUnique($term);
```

## Unique EntityReferenceSelection handler

`Plugin/EntityReferenceSelection/UniqueTermSelection` — plugin
`@EntityReferenceSelection(id = "taxonomy_unique", group = "taxonomy_unique", entity_types = {"taxonomy_term"})`,
extends core `TermSelection`. Its `validateReferenceableNewEntities()` filters out
would-be-**auto-created** terms that are not unique, so an autocomplete "Tags" widget won't
silently create a duplicate. Config schema id: `entity_reference_selection.taxonomy_unique`.
Select it as the reference field's selection handler to opt a reference field into this.

## Notes for agents

- The constraint is a no-op on vocabularies where `enabled` is not TRUE — enabling per
  vocabulary is required (see `configure/vocabulary.md`).
- Matching is a plain DB equality on `name` (case sensitivity follows the DB collation).
- Uniqueness is scoped by language: same name in a different `langcode` is allowed.
