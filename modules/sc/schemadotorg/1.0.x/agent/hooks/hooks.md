# Schema.org Blueprints — hooks

From `schemadotorg.api.php`. Implement these to influence how mappings, bundles, and fields are built.

| Hook | When / what to change |
|---|---|
| `hook_schemadotorg_property_field_type_alter(array &$field_types, string $entity_type_id, string $schema_type, string $schema_property)` | Alter the candidate field types considered for a Schema.org property. |
| `hook_schemadotorg_property_field_prepare(array &$default_field, string $entity_type_id, string $schema_type, string $schema_property)` | Prepare a property's default field data before the mapping form. |
| `hook_schemadotorg_bundle_entity_alter(array &$values, string $schema_type, string $entity_type_id)` | Alter the bundle-entity values (label, description, …) before the bundle is created. |
| `hook_schemadotorg_property_field_alter(string $schema_type, string $schema_property, array &$field_storage_values, array &$field_values, ?string &$widget_id, array &$widget_settings, ?string &$formatter_id, array &$formatter_settings)` | Alter field storage/instance values, widget, and formatter before the field is created. |
| `hook_schemadotorg_mapping_defaults_alter(array &$defaults, string $entity_type_id, ?string $bundle, string $schema_type)` | Alter the computed mapping defaults (fields/properties) before creation. |
| `hook_schemadotorg_mapping_apply(\Drupal\schemadotorg\SchemaDotOrgMappingInterface $mapping)` | React after a mapping has been applied. |
| `hook_ENTITY_TYPE_postsave(EntityInterface $entity)` | Documented convenience post-save hook pattern used by the module. |

These alter hooks are the intended extension mechanism (the module defines no plugin types).
