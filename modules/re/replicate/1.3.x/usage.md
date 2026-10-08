Replicate is a developer-only API to clone (duplicate) any content entity in code, firing events so other code can control exactly how each entity type and each field type is duplicated. It has no user interface.

---

Replicate exposes a single service, `replicate.replicator` (`Drupal\replicate\Replicator`), that duplicates a fieldable content entity via Drupal core's `$entity->createDuplicate()` and then dispatches a series of events so modules can customise the result. `cloneEntity()` (or `cloneByEntityId()`) returns an unsaved clone; `replicateEntity()` (or `replicateByEntityId()`) clones and saves it. During a clone it fires `replicate__entity__{entity_type_id}` (a `ReplicateEntityEvent` carrying the original), then per field a `replicate__entity_field__{field_type}` (a `ReplicateEntityFieldEvent` carrying that field's item list on the clone), then `replicate__alter` (a `ReplicateAlterEvent` with both clone and original) before save, and finally `replicate__after_save` (an `AfterSaveEvent`) once saved. Subscribing to the field- or entity-specific event lets you decide referenced-entity handling — copy a reference by ID (shallow) or recursively replicate the referenced entity (deep) — while writing the least code needed. The module ships two built-in subscribers: one clears `path` field alias/pid so clones don't collide, and one (loaded only when Layout Builder is enabled) deep-clones inline block content referenced by a Layout Builder layout. It targets developers who need full control over a cloning/duplication workflow; higher-level clone UIs such as Quick Node Clone and Entity Clone build on top of this kind of event-driven duplication. It has no config, no permissions, and no admin UI.

---

- Clone a content entity in code without saving it, via `Replicator::cloneEntity($entity)`.
- Clone and immediately save a duplicate, via `Replicator::replicateEntity($entity)`.
- Clone by type + ID without loading the entity first, via `cloneByEntityId('node', 1)`.
- Clone and save by type + ID, via `replicateByEntityId('node', 1)`.
- Duplicate a node, taxonomy term, comment, file, or any fieldable entity type generically.
- Append a suffix like " [clone]" to a cloned node's title by subscribing to `replicate__entity__node`.
- Control how one specific field type is duplicated by subscribing to `replicate__entity_field__{field_type}`.
- Reset unique per-item field data on a clone (the built-in `path` subscriber clears alias/pid).
- Deep-clone a referenced entity (recursively replicate it) instead of copying the reference by ID.
- Keep a reference shallow (share the same target) by leaving the field untouched.
- Point cloned entity references at translated content rather than the original targets.
- Run final cross-field adjustments on the whole clone before it is saved, via `replicate__alter`.
- React after a replica is saved (e.g. logging, queueing, notifications), via `replicate__after_save`.
- Deep-clone Layout Builder inline blocks so a duplicated layout gets its own block content.
- Build a higher-level clone UI or workflow on top of the service (as Quick Node Clone / Entity Clone do).
- Batch-duplicate several entities in an update hook or custom command by looping over the service.
- Seed staging or demo content by replicating existing production entities.
- Implement a multilingual publishing workflow that clones and adapts content per language.
- Partially clone a field via the public `postCloneEntityField()` / `cloneEntityField()` helpers.
- Validate that a cloned field is compatible with its target (the service throws on violations).
- Extend cloning support to a custom field type by subscribing to its `replicate__entity_field__` event.
- Extend cloning support to a custom entity type by subscribing to its `replicate__entity__` event.
- Inject `replicate.replicator` into your own service to duplicate entities as part of a larger operation.
- Skip cloning entirely for non-fieldable config entities (field events fire only for fieldable entities).
