# Content Entity Clone — agent index

Adds a per-bundle **Clone** operation/local task to content entities, pre-filling a new creation
form with the source's field values via **field-processor plugins**. Defines a plugin type
(attribute-based). No Drush. Requires Drupal `^11.4 || ^12`, PHP `>=8.5`.

- **Enable cloning per bundle, config object shape, admin routes, permissions, access flow** →
  [configure/bundle-settings.md](configure/bundle-settings.md)
- **The FieldProcessor plugin type: attribute, base class, manager, shipped processors, writing one** →
  [plugins/field-processor.md](plugins/field-processor.md)
- **Hook to alter field-processor definitions (+ core hooks the module implements as an OOP class)** →
  [hooks/hooks.md](hooks/hooks.md)

Key facts: config `content_entity_clone.bundle.settings.<entity_type>.<bundle>` (`enabled`,
`local_task_label`, `fields.<field>.processor.{id,settings}`). Admin overview
`content_entity_clone.overview` at `/admin/config/content_entity_clone`; per-bundle form
`content_entity_clone.bundle.field_settings` at
`/admin/config/content_entity_clone/field_settings/{entity_type}/{bundle}`. Permissions:
`administer entity cloning`, `clone content entities`. Cloning is driven by an OOP
`hook_entity_prepare_form()` reading `?content_entity_clone=<id>`; the Clone link is built by the
`Drupal\content_entity_clone\CloneLinkGenerator` service, which also enforces target-creation-route
and source-update access. Plugin type discovered by attribute
`#[ContentEntityCloneFieldProcessor]` (manager `Drupal\content_entity_clone\Plugin\FieldProcessorPluginManager`;
deprecated alias `plugin.manager.content_entity_clone.field_processor`).
