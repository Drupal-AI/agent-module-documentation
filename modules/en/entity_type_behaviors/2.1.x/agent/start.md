# Entity Type Behaviors — agent index

A developer framework that brings Paragraphs-style **behavior plugins** to any fieldable entity type:
plugins have a per-bundle config form and a per-entity values form; enabled per entity-type/bundle; stored
in a dynamic `behaviors` base field; values drive render-time alter hooks. No admin page (`configure`
null), no permissions, no Drush. Provides config schema and an `entity_type_behavior` plugin type. Ships
the `entity_type_behaviors_example` submodule.

- **The plugin type, base class, annotation, and writing a behavior plugin** →
  [plugins/entity-type-behavior.md](plugins/entity-type-behavior.md)
- **Enabling behaviors per entity-type/bundle, the config object, and the dynamic `behaviors` base
  field + widget** → [configure/enable-behaviors.md](configure/enable-behaviors.md)
- **The `hook_entity_type_behaviors_alter__…` render-alter hook cascade (and theme functions)** →
  [hooks/preprocess.md](hooks/preprocess.md)

Submodule (own docs):
- `entity_type_behaviors_example` → [../../modules/entity_type_behaviors_example/2.1.x/agent/start.md](../../modules/entity_type_behaviors_example/2.1.x/agent/start.md)

Key facts:
- Manager `plugin.manager.entity_type_behavior`; dir `Plugin/EntityTypeBehavior/`; annotation
  `@EntityTypeBehavior` (`id`, `label`, `description`, `weight`, `entityTypes`); base
  `EntityTypeBehaviorBase`; interface `EntityTypeBehaviorInterface`.
- Config object `entity_type_behaviors.entity_type_bundle.<type>.<bundle>`; each behavior's `config` is
  PHP-`serialize`d, read via `unserialize($v, ['allowed_classes' => FALSE])`
  (`src/Config/BehaviorConfigFactory.php:274`).
- Field type `entity_type_behavior` (`no_ui`, serialized blob) + widget `entity_type_behavior_default`;
  base field `behaviors` added in `entity_type_behaviors_entity_base_field_info()`.
- Render hook cascade fired from `hook_entity_view_alter` → `entity_type_behaviors_hook_callbacks()`.
- Module weight set to 1 on install so its hooks run last.
