Entity Attributes ECK is a submodule that lets the Entity Attributes module manage HTML attributes on ECK (Entity Construction Kit) entities.

---

This submodule plugs ECK into the Entity Attributes system. It adds an `eck_entity` EntityAttributes plugin (`EckEntityAttributes`, extending `ContentEntityAttributesBase`) whose `getEntityTypes()` dynamically loads all `eck_entity_type` machine names, so every ECK entity type/bundle can be enabled on the Entity Attributes settings form and get the YAML "Attributes" field. It implements `hook_preprocess_eck_entity` (`entity_attributes_eck\Hook\PreprocessHooks`) which passes each ECK entity to the shared `entity_attributes.processor` service, merging the stored attributes into the entity's template variables. It requires the base `entity_attributes` module and `eck`.

---

- Enable HTML attributes on ECK entity bundles.
- Add a CSS class to individual ECK entity items.
- Give an ECK entity a stable `id` for anchoring or scripting.
- Attach `data-*` attributes to an ECK entity for a JS library.
- Add ARIA/semantic attributes to ECK entity markup.
- Manage ECK attributes from the same UI as nodes, blocks and menus.
- Automatically support any ECK entity type without extra configuration.
- Store per-entity attributes in the standard ECK entity field.
- Let chosen roles edit ECK attributes via the per-bundle permission.
- Print ECK attributes in an ECK Twig template with `{{ attributes }}`.
- Avoid writing custom preprocess code for ECK attribute handling.
- Apply consistent attribute management across ECK and non-ECK entities.
- Turn attribute support on or off per ECK bundle.
- Validate ECK attribute YAML on save.
- Reuse the base module's CodeMirror editor option for ECK attributes.
