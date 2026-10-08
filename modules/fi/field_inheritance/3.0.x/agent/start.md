# Field Inheritance — agent index

Inherit a field's **value** from a source entity into a **read-only computed field** on a destination
entity — a configurable, field-level alternative to entity reference. Each inheritance is a config
entity; a computed field is added to the destination bundle and evaluated at read time by a plugin.

- **Config entity shape, the `included_entities` setting, and creating an inheritance (UI/drush)** →
  [configure/inheritance.md](configure/inheritance.md)
- **The `field_inheritance` plugin type: the two shipped plugins and how to write one** →
  [plugins/field-inheritance-plugins.md](plugins/field-inheritance-plugins.md)
- **The two alter hooks (`*_inheritance_class_alter`, `*_compute_value_alter`)** →
  [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Config entity: `field_inheritance` (prefix `field_inheritance.field_inheritance.<id>`). On save the
  id is auto-prefixed `<destinationEntityType>_<destinationEntityBundle>_`.
- Strategy (`type`): `inherit`, `prepend`, `append`, `fallback`.
- Plugin: `default_inheritance` (any field) or `entity_reference_inheritance` (entity_reference/image/
  file/webform/paragraphs/entity_reference_revisions).
- `field_inheritance.config:included_entities` = which entity types can be source/destination
  (default `block_content`, `file`, `node`, `taxonomy_term`); edited at
  `/admin/structure/field_inheritance/settings`.
- Configure route: `field_inheritance.field_inheritance` (`/admin/structure/field_inheritance`).
- Permission: `administer field inheritance` (restricted). Plugin manager:
  `plugin.manager.field_inheritance` (alter hook `field_inheritance_info`).
- Also ships: widget `field_inheritance_default`, a Views field plugin, and tokens.
