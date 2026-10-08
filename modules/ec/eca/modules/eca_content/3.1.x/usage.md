ECA Content adds content-entity events, conditions, and actions to ECA, letting models react to entity lifecycle hooks (create, presave, insert, update, delete) and read, change, load, clone, or save entities and their field values.

---

This is one of the most-used ECA submodules. Its events fire on content-entity operations across all entity types and bundles (create, presave, insert, update, delete, and access/view). Its conditions inspect entities: type and bundle, whether the entity is new, field values (equal, empty, changed vs. original), field/entity accessibility, form display mode, and entity diffs. Its actions do the heavy lifting — load an entity or referenced entity, create a new entity, set/get field values, set new revision, set view/form mode, clone or delete an entity, save the entity, build lists of entities, and set validation errors. Together they let you automate content behavior (auto-fill fields, derive values, cascade changes, enforce rules) without custom entity hooks. It registers into ECA Core's managers and defines no new plugin types.

---

- React when any content entity is created, saved, or deleted.
- Auto-populate a field value on entity presave.
- Copy a value from one field to another on save.
- Set a computed title or slug before the entity is stored.
- Load a referenced entity and read its fields.
- Clone an entity as part of a workflow.
- Delete related entities when a parent is removed.
- Create a new entity from a model.
- Save changes back to an entity.
- Force a new revision on update.
- Change the view mode or form display mode dynamically.
- Check an entity's type and bundle in a condition.
- Detect whether an entity is new vs. existing.
- Compare a field value against the original (changed?) value.
- Act only when a specific field is empty.
- Gate logic on field or entity access.
- Add validation errors to block invalid saves.
- Build and filter lists of entities.
- Get default field values programmatically.
- Enumerate entity types or bundles.
- Cascade updates from one entity to related ones.
- Enforce content business rules without custom code.
- Compute derived fields from other field data.
- Diff an entity's before/after state.
- Trigger custom content events for other models to consume.
