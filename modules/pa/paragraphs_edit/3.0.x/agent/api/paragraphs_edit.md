# paragraphs_edit — services, forms, trait

No `*.api.php` and no hooks are invited. The reusable code is two services, three form
classes, and a trait.

## Services (`paragraphs_edit.services.yml`)

### `paragraphs_edit.lineage.inspector` — `ParagraphLineageInspector`
Args: `@entity_type.manager`. Walks/inspects a paragraph's ancestry.

- `getRootParent(ParagraphInterface $p): ContentEntityInterface|null` — walk
  `getParentEntity()` up until a non-paragraph host is reached; returns it (or NULL).
- `getParentField(ParagraphInterface $p): EntityReferenceRevisionsFieldItemList|null` —
  the `entity_reference_revisions` field on the immediate parent that holds `$p`
  (uses the paragraph's `parent_field_name`).
- `getParentFieldItem(ParagraphInterface $p, ?$parentField = NULL)` — the specific field
  **item** referencing `$p`, matched by `target_id` **and** `target_revision_id`.
- `getLineageString(ParagraphInterface $p): string` — human breadcrumb like
  `Host label > Field label #<delta> (Bundle label) > …`; returns "Orphan paragraph" if no
  parent. Used for the edit/clone/delete form titles and messages.

### `paragraphs_edit.lineage.revisioner` — `ParagraphLineageRevisioner`
Args: `@paragraphs_edit.lineage.inspector`, `@entity_type.manager`.

- `shouldCreateNewRevision(EntityInterface $e): bool` — TRUE if the entity's bundle entity
  implements `RevisionableEntityBundleInterface` and is set to create new revisions by
  default.
- `saveNewRevision(ContentEntityInterface $e): int` — saves `$e` as a new revision, then
  walks up the parent chain saving **each ancestor** as a new revision, updating each
  parent field item's `target_revision_id` to keep references consistent. Returns
  `SAVED_NEW`/`SAVED_UPDATED`. (`setNewRevision()` failures on non-revisionable entities are
  caught.)

Example:

```php
$inspector = \Drupal::service('paragraphs_edit.lineage.inspector');
$root = $inspector->getRootParent($paragraph);          // top host entity
$field = $inspector->getParentField($paragraph);        // ERR field on immediate parent
$label = $inspector->getLineageString($paragraph);       // "Article > Body #1 (Text)"

$revisioner = \Drupal::service('paragraphs_edit.lineage.revisioner');
if ($revisioner->shouldCreateNewRevision($root)) {
  $revisioner->saveNewRevision($paragraph);              // saves paragraph + ancestors
}
```

## Form classes (`src/Form/`, registered via `hook_entity_type_build()`)

Registered as paragraph entity form handlers — reach them through the routes, or via
`\Drupal::entityTypeManager()->getFormObject('paragraph', 'entity_edit'|'entity_clone'|'entity_delete')`.

- `ParagraphEditForm` (op `entity_edit`, extends `ContentEntityForm`) — single-paragraph
  edit; translation-aware `init()`; `save()` calls the revisioner when the root parent's
  bundle creates new revisions, else `$entity->save()`.
- `ParagraphCloneForm` (op `entity_clone`) — duplicates then re-parents; extra ctor deps
  `entity_field.manager` and `entity_type.repository`; `getPotentialCloneDestinations()`
  finds valid destination entity-type/bundle/field combos among
  `entity_reference_revisions` fields accepting the paragraph's bundle.
- `ParagraphDeleteForm` (op `entity_delete`, extends `ContentEntityDeleteForm`) — removes
  the item from the parent field and re-saves the parent (revision-aware).

## Trait

`ParagraphFormHelperTrait` (`src/ParagraphFormHelperTrait.php`) — used by all three forms.
Lazy accessors `lineageInspector()` / `lineageRevisioner()`, and an overridden
`buildForm(..., ?EntityInterface $root_parent = NULL)` that stores the `root_parent` route
parameter on `$this->rootParent` for use in `save()`.
