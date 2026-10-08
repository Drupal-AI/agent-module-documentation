Entity Options is a developer API for defining per-bundle "options" as plugins and exposing them, per-node, as a computed field on the entity.

---

Entity Options lets a module define named options — either simple on/off "flag" options or configurable multi-field options — as `@EntityOption` annotated plugins. On the node-type edit form it renders an "Entity Options" tab where an administrator enables each option and, when the plugin permits, allows per-node overrides. On the node edit form, options that allow overrides appear (by default in the "advanced" sidebar) so an editor can override them for that node. Values are computed by merging the bundle defaults with any per-node override and are exposed on a computed `entity_options` base field, so consuming code reads them from `$node->entity_options`. Per-node values are persisted in the key-value store keyed by entity type, bundle and entity id, and the bundle defaults live in the node type's third-party settings. The module ships no options of its own — it is infrastructure that other modules extend; only the Node entity type is supported in this release, and it depends on the "FormAlter as Plugin" (`pluginformalter`) module.

---

- Define a simple on/off flag option for a content type by extending `EntityOptionBase` with an `@EntityOption` annotation.
- Define a configurable/parametric option that collects multiple values via a `settingsForm()`.
- Attach an existing option plugin to a content type via the node type edit form's "Entity Options" tab.
- Enable or disable a defined option per content type without writing code.
- Allow editors to override a bundle-level option on individual nodes by enabling "Allow per node overrides".
- Read a node's effective option values in custom code through `$node->entity_options`.
- Store a small amount of per-node configuration without adding a real storage field.
- Provide feature toggles (e.g. "show table of contents", "enable comments banner") that site builders switch per content type.
- Ship a module whose behavior is controlled by opt-in options administrators can turn on per bundle.
- Keep option defaults in the content type config while letting specific nodes deviate.
- Expose option metadata (label, description) automatically on the correct admin forms.
- Let another module react to `hook_entity_options_info` alter to add, remove or change available options.
- Compute merged default-plus-override values automatically on entity load and save.
- Purge a node's stored option values automatically when the node is deleted.
- Build a plugin manager service (`plugin.manager.entity_options`) to enumerate options for a bundle.
- Query all options configured for a content type with `getTypeOptions()`.
- Fetch a single option instance for a content type with `getTypeOption()`.
- Persist per-node overrides in the key-value store rather than in a database field.
- Provide translatable per-language option values (the computed field is translatable).
- Offer flag options that render as a single checkbox on the node-type form with no extra coding.
- Group per-node override widgets into the node form's advanced settings sidebar automatically.
- Migrate bundle-level toggles into a reusable, plugin-based pattern instead of ad-hoc form_alter code.
- Prototype option-driven UI features that other contrib/custom modules consume.
