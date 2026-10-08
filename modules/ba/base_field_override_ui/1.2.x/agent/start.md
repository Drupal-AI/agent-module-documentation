<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Base Field Override UI — agent index

Adds a **Base fields Override** tab on each entity type's *Manage fields* page so you can
override the **label** and **description** of code-defined base fields per bundle. Edits core's
`base_field_override` config entity; defines none of its own. Depends on `field_ui`. No
configure route, no config schema, no plugins, no Drush. Uses core permission
`administer <entity_type> fields`.

- **Create/edit/delete a base field override + where it is stored** →
  [configure/override-base-field.md](configure/override-base-field.md)
- **Routes, tabs and helper methods it adds (for linking/automation)** →
  [api/routes.md](api/routes.md)

Key facts:
- Stored config: `core.base_field_override.<entity_type>.<bundle>.<field_name>` (core's own
  entity), with overridden `label` and `description`.
- Tab route id: `entity.base_field_override.<entity_type>.base_field_override_ui_fields` at path
  `<manage-fields-path>/fields/base-field-override`.
- Only entity types with a `field_ui_base_route` get the tab; only display-configurable base
  fields can be overridden.
- Programmatic override: `\Drupal\Core\Field\Entity\BaseFieldOverride::createFromBaseFieldDefinition($def, $bundle)->setLabel(...)->setDescription(...)->save()`.
