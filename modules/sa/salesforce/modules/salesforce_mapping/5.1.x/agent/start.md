# Salesforce Mapping — agent index

Defines how Drupal entities map to Salesforce objects. Provides the `salesforce_mapping`
config entity (the map), the `salesforce_mapped_object` content entity (a record link), and
the field-mapping plugin type. Pure configuration — `salesforce_push`/`salesforce_pull` do the
I/O. Depends on `salesforce`, `dynamic_entity_reference`, `typed_data`.

- **The `salesforce_mapping` config entity: keys, sync_triggers, field_mappings, mapped objects, permissions** →
  [configure/mapping.md](configure/mapping.md)
- **The `salesforce_mapping_field` plugin type (properties, record_type, …)** →
  [plugins/field-plugins.md](plugins/field-plugins.md)

Key facts:
- Config entity `salesforce_mapping` keys: `id`, `label`, `type`, `key`, `async`,
  `always_upsert`, `push_standalone`, `pull_standalone`, `sync_triggers`,
  `salesforce_object_type`, `drupal_entity_type`, `drupal_bundle`, `field_mappings`,
  `push_limit`, `push_retries`, `push_frequency`, `pull_frequency`, `pull_where_clause`,
  `pull_trigger_date`, `pull_record_type_filter`.
- `sync_triggers` booleans: `push_create`, `push_update`, `push_delete`, `pull_create`,
  `pull_update`, `pull_delete`.
- Content entity `salesforce_mapped_object` (Drupal entity ↔ SFID, revisioned).
- Plugin type `salesforce_mapping_field` (`plugin.manager.salesforce_mapping_field`,
  `@SalesforceMappingField`): `properties`, `properties_extended`, `record_type`, `broken`.
- Permissions: `administer salesforce mapping`, `view salesforce mapping`,
  `administer salesforce mapped objects`.
- Build maps via `salesforce_mapping_ui`.
