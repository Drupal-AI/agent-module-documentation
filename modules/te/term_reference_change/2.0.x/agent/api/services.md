<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — the two services

Declared in `term_reference_change.services.yml`:

```yaml
term_reference_change.reference_finder:
  class: Drupal\term_reference_change\ReferenceFinder
  arguments: ['@entity_type.manager', '@entity_type.bundle.info', '@entity_field.manager']
term_reference_change.migrator:
  class: Drupal\term_reference_change\ReferenceMigrator
  arguments: ['@term_reference_change.reference_finder']
```

There is **no** interface for the migrator (type-hint the concrete
`Drupal\term_reference_change\ReferenceMigrator`); the finder implements
`Drupal\term_reference_change\ReferenceFinderInterface`.

## ReferenceFinder

### `findTermReferenceFields(): array`

Nested array `[$entity_type_id][$bundle_id] = [field_name, …]`.

A field is included only when **all** of these hold:

- the entity type implements `FieldableEntityInterface`;
- `$field_definition->getType() === 'entity_reference'`;
- `$field_definition->getSetting('target_type') === 'taxonomy_term'`;
- `!$field_definition->isComputed()`;
- the field name is **not** `parent` (hard-coded skip — taxonomy's `parent` field fatals in
  entity queries, see drupal.org/node/2543726).

Note `entity_reference_revisions` and `dynamic_entity_reference` fields are **not** matched
(type must be exactly `entity_reference`). Bundles with no matching field are simply absent.

### `findReferencesFor(TermInterface $term): array`

`[$entity_type_id => [ …loaded entities… ]]`. Implemented as one
`getStorage($type)->loadByProperties([$field_name => $term->id()])` **per field per bundle**,
merged together — so it is O(fields) queries and it fully loads every matching entity.
Entity types with no matches are omitted. Duplicates can appear when the same entity matches
via two fields; the array is `array_merge`d, not keyed by ID.

```php
$finder = \Drupal::service('term_reference_change.reference_finder');
$fields = $finder->findTermReferenceFields();
// e.g. $fields['node']['article'] === ['field_tags']
$refs = $finder->findReferencesFor(Term::load(7));
$node_count = count($refs['node'] ?? []);
```

## ReferenceMigrator

### `migrateReference(TermInterface $source, TermInterface $target, array $limit = []): void`

Rewrites every reference to `$source` so it points at `$target`, then saves each changed
entity. Behaviour worth knowing:

- **`$limit`** is `[$entity_type_id => [$entity_id, …]]`. Empty array (default) = no limit.
  A non-empty `$limit` skips every entity type **not** present as a key, and inside a listed
  type skips any entity whose ID is not in its list.
- Only the fields returned by `findTermReferenceFields()` are touched, and the entity is
  skipped for a field it does not have (`$entity->hasField()`) or where the field is empty.
- Multi-value fields: every delta whose `target_id` equals the source ID is rewritten, then
  `removeDuplicates()` drops any delta whose `target_id` was already seen — so an entity that
  referenced *both* source and target ends up with the target exactly once.
- `$entity->save()` is called **once per changed field**, not once per entity.
- It throws `\Drupal\Core\Entity\EntityStorageException` on save failure. Nothing is wrapped
  in a transaction and there is no rollback.
- The source term is **not** deleted and nothing is logged. Do that yourself afterwards.

```php
use Drupal\taxonomy\Entity\Term;

$migrator = \Drupal::service('term_reference_change.migrator');
$source = Term::load(7);
$target = Term::load(9);

// Everything, everywhere:
$migrator->migrateReference($source, $target);

// Only these two nodes:
$migrator->migrateReference($source, $target, ['node' => [12, 34]]);

// Only nodes at all (any node): pass every node id you care about — an entity type key
// with an empty array skips every entity of that type, it does NOT mean "all".
$migrator->migrateReference($source, $target, ['node' => array_keys($all_nids)]);

$source->delete(); // the module will not do this for you
```

## Practical recipes

Merge term B into term A and delete B, from Drush:

```bash
drush php:eval '
  use Drupal\taxonomy\Entity\Term;
  $s = Term::load(7); $t = Term::load(9);
  \Drupal::service("term_reference_change.migrator")->migrateReference($s, $t);
  $s->delete();
'
```

Count usages before offering a delete:

```php
$refs = \Drupal::service('term_reference_change.reference_finder')->findReferencesFor($term);
$total = array_sum(array_map('count', $refs));
```

Because everything is loaded into memory, chunk large jobs yourself — call
`findReferencesFor()` for a count, then drive `migrateReference()` with `$limit` slices
inside a Batch API operation.
