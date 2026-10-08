Field Inheritance lets a site builder pull ("inherit") the value of a field on one entity into a read-only computed field on another entity — a field-level, configurable alternative to entity reference.

---

Each inheritance is a **config entity** (`field_inheritance`, config prefix
`field_inheritance.field_inheritance`) describing a source (entity type + bundle + field), a
destination (entity type + bundle, optional destination field), an **inheritance strategy** (`type`:
`inherit`, `prepend`, `append`, or `fallback`), and a **plugin** (`default_inheritance` or
`entity_reference_inheritance`). For every destination bundle that has inheritances,
`hook_entity_bundle_field_info_alter()` adds a **computed, read-only** field (named after the
inheritance, with the `<destType>_<destBundle>_` prefix stripped) whose class
(`FieldInheritanceFactory`, or `EntityReferenceFieldInheritanceFactory` for the entity-reference
plugin) computes its value at read time by delegating to the configured FieldInheritance plugin. The
plugin implements the strategy: `inherit` returns the source field's value; `prepend`/`append`
concatenate destination + source (in either order); `fallback` uses the destination value if present
else the source. Field cardinality of the computed field is derived from source/destination
cardinalities per strategy. A `field_inheritance.config` object lists the **`included_entities`**
(default `block_content`, `file`, `node`, `taxonomy_term`) that receive a base `field_inheritance`
map field and appear as inheritance source/destination options; the settings form
(`/admin/structure/field_inheritance/settings`) edits that list (with a confirm step). Inheritances
are managed at `/admin/structure/field_inheritance` (permission **`administer field inheritance`**).
The module defines the `field_inheritance` **plugin type** (attribute-discovered, manager
`plugin.manager.field_inheritance`, alter hook `field_inheritance_info`) so custom strategies can be
added, plus a widget (`field_inheritance_default`), a Views field plugin, and tokens. Two alter hooks
(`hook_field_inheritance_inheritance_class_alter`, `hook_field_inheritance_compute_value_alter`) let
developers override the factory class or the computed value.

---

- Show an Event node's location by inheriting it from a referenced Venue entity, without a second lookup.
- Inherit a taxonomy term's description into nodes tagged with that term.
- Display a source node's body on a related node as a read-only computed field.
- Provide an entity-reference alternative that copies a field's *value* rather than a reference.
- Prepend a destination's own notes to inherited source notes with the `prepend` strategy.
- Append inherited data after a destination field's local value with the `append` strategy.
- Fall back to a source field only when the destination field is empty (`fallback` strategy).
- Inherit an image or file field across entities using the `entity_reference_inheritance` plugin.
- Inherit a paragraph/entity-reference-revisions field into another entity.
- Expose an inherited field in Views via the module's Views field plugin.
- Use inherited values in tokens for messages, mails, or pathauto patterns.
- Restrict which entity types can participate by editing `included_entities` in the settings form.
- Inherit block_content, file, node, or taxonomy_term fields out of the box.
- Build a computed read-only "summary from parent" field on child content.
- Keep a destination field automatically in sync with its source (recomputed at read time).
- Write a custom FieldInheritance plugin for a bespoke merge/transform strategy.
- Override the inheritance computation for one field via `hook_field_inheritance_compute_value_alter()`.
- Swap the factory class used for a field via `hook_field_inheritance_inheritance_class_alter()`.
- Manage all inheritances centrally at /admin/structure/field_inheritance.
- Grant only trusted roles the `administer field inheritance` permission (restricted access).
- Deploy inheritances as configuration (config entities) across environments.
- Derive a field's cardinality automatically from the source and destination fields' cardinalities.
- Inherit data across different bundles of the same entity type (e.g. Article → Page).
- Replace copy-paste duplication of shared field data between related entities.
