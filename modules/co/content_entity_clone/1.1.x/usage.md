Content Entity Clone adds a per-bundle "Clone" operation to content entities (nodes, terms, media, etc.), copying selected fields into a new unsaved entity via configurable field-processor plugins.

---

You enable cloning per entity-type bundle on the admin overview at `/admin/config/content_entity_clone` (route `content_entity_clone.overview`, permission `administer entity cloning`); each bundle's settings form (`content_entity_clone.bundle.field_settings/{entity_type}/{bundle}`) lets you turn cloning on, set the clone link label, and choose, per field, a **field processor** that decides how that field's value is carried over. Enabling a bundle writes a config object `content_entity_clone.bundle.settings.<entity_type>.<bundle>` with `enabled: true`, an optional `local_task_label`, and a `fields` map of `<field_name> => { processor: { id, settings } }`. When a user with the `clone content entities` permission views such an entity, the module adds a **Clone** entity operation and a local task; the link opens the entity's creation form with a `?content_entity_clone=<id>` query. `hook_entity_prepare_form()` then, for each configured field, clones the source field, runs its processor's `process()`, and sets the processed values on the new (unsaved) entity — so the user reviews and saves a pre-filled copy. Field processors are a real plugin type (`@ContentEntityCloneFieldProcessor`, manager `plugin.manager.content_entity_clone.field_processor`, namespace `Plugin/content_entity_clone/FieldProcessor`); the module ships `copy_values`, `entity_label_clone_suffix` (appends " [CLONE]" to the label), `clone_referenced_entities`, and `copy_layout`, and other modules can add their own or alter definitions via `hook_content_entity_clone_field_processor_info_alter()`. There are no Drush commands.

---

- Add a "Clone" button to Article nodes so editors can duplicate a page and tweak it.
- Duplicate a complex Media entity, copying all its metadata fields.
- Clone a taxonomy term to seed a similar one.
- Let editors copy a Layout Builder page and keep its layout via the copy_layout processor.
- Append " [CLONE]" to the new entity's title automatically so copies are obvious.
- Restrict which fields are carried over when cloning (omit fields you want blank).
- Deep-clone referenced paragraphs/entities with the clone_referenced_entities processor.
- Enable cloning only for specific bundles, leaving others without a Clone action.
- Give a custom clone-link label like "Duplicate" per bundle.
- Provide a duplicate action for a custom content entity type.
- Copy a product node as a starting point for a variant.
- Clone an event node to create next month's event, then edit the date.
- Let authors branch a draft by cloning the published version.
- Copy a landing page's fields but reset the URL alias (leave that field unprocessed).
- Add cloning to comments or custom entities that lack a native duplicate feature.
- Write a custom field processor to transform a field's values during cloning (e.g. uppercase).
- Alter another module's field-processor definitions via the info_alter hook.
- Ensure a cloned entity starts unsaved so the user can review before committing.
- Gate who can clone via the 'clone content entities' permission, separate from admin.
- Configure clone behavior entirely via exported config for deployment.
- Copy only the body and image of a node while leaving author/date fresh.
- Duplicate a media library item with a modified name.
- Standardize how references are handled on clone across a content type.
- Provide a per-bundle overview of which entity types have cloning enabled.
