# Content Entity Clone — agent index

Adds a per-bundle **Clone** operation/local task to content entities, copying selected fields into a
new unsaved entity via **field-processor plugins**. Defines a plugin type. No Drush.

- **Enable cloning per bundle, the config object shape, admin route, permissions** →
  [configure/bundle-settings.md](configure/bundle-settings.md)
- **The FieldProcessor plugin type: annotation, base class, manager, shipped processors, writing one** →
  [plugins/field-processor.md](plugins/field-processor.md)
- **Hook to alter field-processor definitions** →
  [hooks/hooks.md](hooks/hooks.md)

Key facts: config `content_entity_clone.bundle.settings.<entity_type>.<bundle>` (`enabled`,
`local_task_label`, `fields.<field>.processor.{id,settings}`). Admin overview
`content_entity_clone.overview` at `/admin/config/content_entity_clone`. Permissions:
`administer entity cloning`, `clone content entities`. Cloning is driven by
`hook_entity_prepare_form()` reading `?content_entity_clone=<id>`. Plugin type
`content_entity_clone_field_processor` (manager `plugin.manager.content_entity_clone.field_processor`).
