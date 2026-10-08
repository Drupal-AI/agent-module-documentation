<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `term_merge.term_merger` — merging from code

Service id **`term_merge.term_merger`**, class `Drupal\term_merge\TermMerger`, interface
`Drupal\term_merge\TermMergerInterface`. Constructor args (from `term_merge.services.yml`):
`@entity_type.manager`, `@term_reference_change.migrator`, `@event_dispatcher`.

This is the only public API — the wizard forms are just a front end for it.

## Interface

```php
public function mergeIntoNewTerm(array $terms_to_merge, string $new_term_label): TermInterface;
public function mergeIntoTerm(array $terms_to_merge, TermInterface $target_term): void;
```

`$terms_to_merge` is an array of **loaded `TermInterface` objects**, not tids.

## Merge into an existing term

```php
$storage = \Drupal::entityTypeManager()->getStorage('taxonomy_term');
$sources = $storage->loadByProperties(['vid' => 'tags', 'name' => 'Bicycles'])
  + $storage->loadByProperties(['vid' => 'tags', 'name' => 'Bike']);
[$target] = array_values($storage->loadByProperties(['vid' => 'tags', 'name' => 'Bicycle']));

\Drupal::service('term_merge.term_merger')->mergeIntoTerm(array_values($sources), $target);
```

## Merge into a brand-new term

```php
/** @var \Drupal\taxonomy\TermInterface $new */
$new = \Drupal::service('term_merge.term_merger')
  ->mergeIntoNewTerm(array_values($sources), 'Renewable Energy');
print $new->id();   // the newly created, already-saved term
```

`mergeIntoNewTerm()` builds the new term with `['name' => $label, 'vid' => <bundle of the
first source term>]`, then delegates to `mergeIntoTerm()` (which saves it because it is new)
and returns it.

## What `mergeIntoTerm()` actually does, in order

1. `validateTerms()` — see exceptions below.
2. Saves `$target_term` if it `isNew()` (needed to have an id to reference).
3. Rejects a target whose bundle differs from the first source term's bundle.
4. For each source term, `term_reference_change.migrator->migrateReference($from, $to)` —
   this is what rewrites every entity field referencing the old term.
5. Dispatches `TermsMergedEvent` on `TermMergeEventNames::TERMS_MERGED`
   (see [../extend/terms-merged-event.md](../extend/terms-merged-event.md)) — **before**
   deletion, so subscribers can still read the source terms.
6. `$termStorage->delete($terms_to_merge)` — the source terms are gone.

There is no transaction and no undo.

## Exceptions (all `\RuntimeException`)

| Message | When |
|---|---|
| `You must provide at least 1 term` | `$terms_to_merge` is empty |
| `Only merges within the same vocabulary are supported` | sources span more than one `vid` |
| `The target term must be in the same vocabulary as the terms being merged` | target `vid` differs from the sources' |

Note `mergeIntoTerm()` will happily accept a single source term, and does not stop you passing
the target term in the source list — filter it out yourself.

## Failure mode worth knowing: `'<field>' not found` from the reference finder

Step 4 above runs inside `term_reference_change`, and it is the step most likely to blow up on
a large site. `ReferenceFinder::findTermReferenceFields()` collects **every** non-computed
`entity_reference` field targeting `taxonomy_term`, across every bundle of every fieldable
entity type, then queries each entity type with
`getStorage($entityType)->loadByProperties([$fieldName => $tid])`.

If any of those field names cannot be resolved by the SQL entity query — typically a
bundle-level field with no field storage definition, contributed by some other module — the
whole merge dies before anything is deleted:

```
Drupal\Core\Entity\Query\QueryException: '<field_name>' not found
  Drupal\Core\Entity\Query\Sql\Tables->ensureEntityTable()
  Drupal\Core\Entity\EntityStorageBase->loadByProperties()
  Drupal\term_reference_change\ReferenceFinder->loadReferencingEntitiesOfType()
```

It only special-cases `parent` (excluded deliberately, see drupal.org node 2543726); anything
else that the query cannot resolve is fatal. The merge is **not** partially applied — it fails
before `$termStorage->delete()` — but it also cannot be retried until the offending field is
dealt with. Diagnose with:

```php
// which fields will the finder try to query?
print_r(\Drupal::service('term_reference_change.reference_finder')->findTermReferenceFields());
```

## Injecting it

```yaml
# mymodule.services.yml
services:
  mymodule.taxonomy_cleanup:
    class: Drupal\mymodule\TaxonomyCleanup
    arguments: ['@term_merge.term_merger', '@entity_type.manager']
```

```php
public function __construct(
  protected TermMergerInterface $termMerger,
  protected EntityTypeManagerInterface $entityTypeManager,
) {}
```

Type-hint `TermMergerInterface`, not the concrete class.
