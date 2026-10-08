Content Entity Clone adds a per-bundle "Clone" operation/local task to content entities (nodes, terms, media, custom entities, etc.), pre-filling a new creation form with the source entity's field values via configurable field-processor plugins.

---

You enable cloning per entity-type bundle on the admin overview at `/admin/config/content_entity_clone` (route `content_entity_clone.overview`, permission `administer entity cloning`); each bundle's settings form (`content_entity_clone.bundle.field_settings`, path `/admin/config/content_entity_clone/field_settings/{entity_type}/{bundle}`) lets you turn cloning on, set the clone link label, and choose, per field, a **field processor** (or "Skip field"). Enabling a bundle writes config `content_entity_clone.bundle.settings.<entity_type>.<bundle>` with `enabled: true`, an optional `local_task_label`, and a `fields` map of `<field_name> => { processor: { id, settings } }`. A shared `CloneLinkGenerator` service builds the Clone entity operation and local task only when the current user has `clone content entities`, cloning is enabled for the bundle, the user can reach the target entity's **creation route**, and the user has **update** access to the source; the link points to the creation form with `?content_entity_clone=<id>` (and `content_entity_clone_language=<langcode>`). An OOP `hook_entity_prepare_form()` implementation (ordered first) then re-checks the permission and the source's update access, clones each configured field, runs its processor's `process()`, and copies the processed values onto the new **unsaved** entity, so the user reviews and saves a pre-filled copy. Field processors are a real plugin type declared with the PHP attribute `#[ContentEntityCloneFieldProcessor]` (namespace `Plugin/content_entity_clone/FieldProcessor`, manager `Drupal\content_entity_clone\Plugin\FieldProcessorPluginManager`); the module ships `copy_values`, `entity_label_clone_suffix` (appends " [CLONE]" to the label), `clone_referenced_entities`, and `copy_layout` (Layout Builder, deep-cloning inline content blocks). Other modules add their own processors or alter definitions via `hook_content_entity_clone_field_processor_info_alter()`. There are no Drush commands. This 2.x major requires Drupal `^11.4 || ^12` and PHP `>=8.5`.

---

- Add a "Clone" button to Article nodes so editors can duplicate a page and tweak it.
- Duplicate a complex Media entity, copying all its metadata fields.
- Clone a taxonomy term to seed a similar one.
- Let editors copy a Layout Builder page and keep its layout via the copy_layout processor.
- Deep-clone the inline content blocks inside a cloned Layout Builder layout so copies are independent.
- Append " [CLONE]" to the new entity's label automatically so copies are obvious.
- Restrict which fields are carried over when cloning (choose "Skip field" for the rest).
- Deep-clone referenced paragraphs/entities with the clone_referenced_entities processor.
- Enable cloning only for specific bundles, leaving others without a Clone action.
- Give a custom clone-link label like "Duplicate" per bundle.
- Provide a duplicate action for a custom content entity type with a creation form.
- Copy a product node as a starting point for a variant.
- Clone an event node to create next month's event, then edit the date.
- Let authors branch a draft by cloning the published version.
- Add cloning to comments or custom entities that lack a native duplicate feature.
- Write a custom field processor to transform a field's values during cloning (e.g. uppercase).
- Alter another module's field-processor definitions via the info_alter hook.
- Ensure a cloned entity starts unsaved so the user can review before committing.
- Gate who can clone via the `clone content entities` permission, separate from admin.
- Require that cloners have edit access to the source entity before values are copied.
- Configure clone behavior entirely via exported config for deployment.
- Copy only the body and image of a node while leaving author/date fresh.
- Duplicate a media library item with a modified name.
- Standardize how references are handled on clone across a content type.
- Provide a per-bundle overview of which entity types have cloning enabled.
