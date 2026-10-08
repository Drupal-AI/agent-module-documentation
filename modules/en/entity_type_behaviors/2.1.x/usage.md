Entity Type Behaviors brings Paragraphs-style "behavior" plugins to any fieldable entity type: developers define `EntityTypeBehavior` plugins with a config form and a value form, site builders enable them per entity-type/bundle, content editors fill in the values, and the stored values drive render-time alterations.

---

The module defines an `entity_type_behavior` plugin type (manager `plugin.manager.entity_type_behavior`, discovered under `Plugin/EntityTypeBehavior/`, annotation `@EntityTypeBehavior` with `id`, `label`, `description`, `weight`, `entityTypes`). Each plugin exposes two forms: a per-bundle **config** form (`getConfigForm()`, restricting/parameterizing the behavior) and a per-entity **values** form (`getForm()`, what editors fill in). When behaviors are enabled for an entity-type/bundle, the config is stored in a `entity_type_behaviors.entity_type_bundle.<type>.<bundle>` config object (a `config` blob is PHP-`serialize`d, read back with `unserialize(..., ['allowed_classes' => FALSE])`), and the module dynamically adds a revisionable, translatable **`behaviors` base field** (field type `entity_type_behavior`, a serialized blob) to that entity type; its widget renders each enabled plugin's `getForm()` inside a details element. On `hook_entity_view_alter`, each enabled plugin's `view()` runs and the collected values are placed in `$build['#entity_type_behaviors']`, after which the module invokes a cascade of alter hooks — `hook_entity_type_behaviors_alter__BEHAVIOR`, `…__BEHAVIOR__ENTITY_TYPE`, and `…__BEHAVIOR__ENTITY_TYPE__BUNDLE` (also as theme functions) — so modules/themes can mutate the render array from the behavior's values. The module sets its own weight to 1 so it runs after other modules, adds a config-import step to (un)install behavior base-field schemas, and ships an `entity_type_behaviors_example` submodule plus optional GraphQL Compose plugins. No admin page, no permissions, no Drush — it is a developer framework.

---

- Add a "background color" control to any entity type that developers can read at render time.
- Add configurable margins/padding options to a node or media bundle without a contrib field type.
- Give editors an image-positioning toggle stored per entity and applied via a preprocess hook.
- Bring Paragraphs-style behavior plugins to nodes, media, taxonomy terms, or custom entities.
- Define a behavior once and enable it on many bundles from the entity-type edit form.
- Restrict a behavior to specific entity types via the annotation's `entityTypes`.
- Provide a per-bundle config form that limits which options editors may choose (see the example's color allow-list).
- Store editor-entered behavior values in a revisionable, translatable base field.
- Alter an entity's render array based on behavior values using `hook_entity_type_behaviors_alter__BEHAVIOR`.
- Target alterations to one entity type with the `…__BEHAVIOR__ENTITY_TYPE` hook variant.
- Target alterations to a single bundle with the `…__BEHAVIOR__ENTITY_TYPE__BUNDLE` variant.
- React to behaviors from a theme by implementing the hook as a `THEME_...` function.
- Add CSS classes or attributes to entities conditionally from stored behavior values.
- Override behavior output directly in a plugin's `view()` method.
- Export behavior configuration as normal Drupal config (`entity_type_behaviors.entity_type_bundle.*`).
- Keep behavior base-field schema in sync automatically across config import/export.
- Weight behaviors so they render/appear in a chosen order (annotation `weight`).
- Expose entity behaviors through GraphQL via the optional GraphQL Compose integration.
- Prototype display options quickly using the shipped `entity_type_behaviors_example` module as a template.
- Massage/normalize editor input before storage with `massageValues()`.
- Massage/normalize config before storage with `massageConfig()`.
- Read a single stored value with `getValueByKey()` or config with `getConfigValue()` inside hooks.
- Build reusable, sharable display-behavior packages as small custom modules.
