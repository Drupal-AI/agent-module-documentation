# Composite entities & field-item API

## Needs-save flag
`EntityNeedsSaveInterface` (+ `EntityNeedsSaveTrait`) lets a child entity tell its parent it
must be (re)saved when the host is saved:

```php
class MyChild extends ContentEntityBase implements EntityNeedsSaveInterface {
  use EntityNeedsSaveTrait; // provides needsSave() / setNeedsSave(bool)
}
```
ERR's field item list (`EntityReferenceRevisionsFieldItemList`) and entity hooks
(`src/Hook/EntityHooks.php`) inspect this: on host save, referenced entities flagged
`needsSave() === TRUE` get a new revision created and their `target_revision_id` updated.

## Reading / setting a reference item
```php
$item = $host->get('field_children')->get(0);
$targetId    = $item->target_id;
$revisionId  = $item->target_revision_id;   // the pinned revision
$child       = $item->entity;               // loaded target revision

// Point at a child (revision id filled in on save if the child needs saving):
$host->field_children[] = ['entity' => $child];
```

## Composite relationship & orphans
A referenced entity is treated as **composite** (owned by exactly one parent) when its field
definition marks it so. When a host revision stops referencing a child revision, that revision
becomes an **orphan**. `EntityReferenceRevisionsOrphanPurger`
(service `entity_reference_revisions.orphan_purger`) finds and deletes orphans:

```php
$purger = \Drupal::service('entity_reference_revisions.orphan_purger');
$types  = $purger->getCompositeEntityTypes();   // entity types that can be orphaned
$purger->setBatch(['paragraph']);               // queue a purge batch
```
See [../drush/orphan-purge.md](../drush/orphan-purge.md) for the CLI/UI wrappers.
