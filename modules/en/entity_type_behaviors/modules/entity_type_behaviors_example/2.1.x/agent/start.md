# Entity Type Behaviors Example — agent index

Reference/demo submodule of **entity_type_behaviors**: example `EntityTypeBehavior` plugins + a sample
alter-hook. Depends on `entity_type_behaviors`. No config, permissions, Drush, or admin UI. Read the
parent's docs for the framework; use these plugins as templates.

- Parent framework → [../../../../2.1.x/agent/start.md](../../../../2.1.x/agent/start.md)

Example plugins (`src/Plugin/EntityTypeBehavior/`):
- `Example` (id `example`) — plain `text` textfield values form; no entity-type restriction.
- `ExampleWithConfig` (id `example_with_config`, `entityTypes = {"node","media"}`) — a config checkboxes
  form (`getConfigForm()`) that restricts selectable colors per bundle; `getForm()` shows only allowed
  colors; `massageConfig()` drops unchecked options.
- `ExampleNodeOnly`, `ExampleMediaOnly`, `ExampleAddingClass` — targeting + render-alter demos.

Sample hook (`entity_type_behaviors_example.module`):
- `entity_type_behaviors_example_entity_type_behaviors_alter__example(&$build, $behavior)` adds class
  `example-class-added` when the `example` behavior's `text` value is non-empty.
