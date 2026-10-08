A reference/demo submodule of Entity Type Behaviors that ships example `EntityTypeBehavior` plugins and a sample alter-hook implementation, to copy when building your own behaviors.

---

`entity_type_behaviors_example` depends only on `entity_type_behaviors` and adds nothing to production beyond example code. It provides several behavior plugins under `src/Plugin/EntityTypeBehavior/`: `Example` (a plain text field values form, no entity-type restriction), `ExampleWithConfig` (restricted to `node` + `media`, with a per-bundle config checkboxes form that limits which color options editors may select, plus a `massageConfig()` that drops unchecked options), and `ExampleNodeOnly` / `ExampleMediaOnly` / `ExampleAddingClass` demonstrating `entityTypes` targeting and render alteration. Its `.module` implements `hook_entity_type_behaviors_alter__example()` to add the CSS class `example-class-added` to any entity whose `example` behavior has a non-empty `text` value. Enable it to see behaviors working end to end, or read the plugins as templates. No config schema, permissions, Drush, or admin UI of its own.

---

- Learn the `EntityTypeBehavior` plugin structure from a minimal working example (`Example`).
- See how to restrict a behavior to `node` and `media` with the `entityTypes` annotation.
- Copy the config-form pattern that limits editor options per bundle (`ExampleWithConfig`).
- See `massageConfig()` used to strip unchecked checkbox options before storage.
- See a values `getForm()` that reads `getValueByKey()` for its default value.
- Study `ExampleNodeOnly` / `ExampleMediaOnly` for single-entity-type behaviors.
- Study `ExampleAddingClass` for adding a class from a behavior.
- Read the `.module` for a working `hook_entity_type_behaviors_alter__BEHAVIOR` implementation.
- Enable it to demo enabling behaviors on a content type and entering values.
- Use it as scaffolding when starting a new custom behavior module.
- Verify your Entity Type Behaviors install renders behavior output correctly.
- Reference the color allow-list pattern for constrained editor choices.
- Demonstrate the base `behaviors` field appearing on an entity form.
- Confirm the alter-hook cascade fires by inspecting the added `example-class-added` class.
- Teach new developers the config-vs-values distinction with concrete code.
