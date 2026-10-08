<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Sync Mapping (apisync_mapping) — agent index

Submodule of [apisync](../../../../1.0.x/agent/start.md). The data model that binds Drupal entities to remote OData objects. Package `Liip`, core `^9.1 || ^10 || ^11`. Depends on `apisync`, `apisync_logger`, `dynamic_entity_reference`, `typed_data`. `configure: entity.apisync_mapped_object_type.collection` (UI provided by `apisync_mapping_ui`).

## Entities (src/Entity)
- **`apisync_mapping`** (config entity, `ApiSyncMapping`) — `admin_permission = administer apisync mapping`. `config_export`: `type`, `async`, `push_standalone`, `pull_standalone`, `pull_trigger_date`, `pull_where_clause`, `sync_triggers`, `apisync_object_type`, `drupal_entity_type`, `drupal_bundle`, `field_mappings`, `push_limit`, `push_retries`, `push_frequency`, `pull_frequency`. Storage `ApiSyncMappingStorage` (`loadPushMappingsByProperties`, `loadCronPushMappings`, `loadByProperties(['pull_standalone'=>TRUE])`). Key methods: `checkTriggers()`, `doesPush()/doesPull()`, `doesPushStandalone()/doesPullStandalone()`, `getFieldMappings()`, `getPullFields()`, `getPullQuery()` (builds `SelectQuery`).
- **`apisync_mapped_object`** (content entity, `ApiSyncMappedObject`) — revisionable, fieldable; base table `apisync_mapped_object`. `bundle_entity_type = apisync_mapped_object_type`; access handler `ApiSyncMappedObjectAccessControlHandler` (all ops require `administer apisync`). Fields include `drupal_entity` (dynamic entity ref), `apisync_id`, `apisync_link` (OData link item), `last_sync_action/status`. Methods: `push()`, `pushDelete()`, `pull()`, `setDrupalEntity()`, `getMappedEntity()`. Constraints: `MappingApiSyncId`, `MappingEntity`, `MappingEntityType`.
- **`apisync_mapped_object_type`** (config entity, `ApiSyncMappedObjectType`) — bundle of the mapped object; `admin_permission = administer apisync mapped object type`.

## Plugin type `apisync_mapping_field` (src/Plugin/ApiSyncMappingField)
Manager `plugin.manager.apisync_mapping_field` = `ApiSyncMappingFieldPluginManager` (dir `Plugin/ApiSyncMappingField`, `FallbackPluginManagerInterface` → `broken`). Interface `ApiSyncMappingFieldPluginInterface`, base `ApiSyncMappingFieldPluginBase`. Shipped plugins: `properties` (Properties/PropertiesBase/PropertiesExtended), `constant` (Constant), `drupal_constant` (DrupalConstant), `token` (Token), `related_ids` (RelatedIDs), `related_properties` (RelatedProperties), `related_term_string` (RelatedTermString), `broken` (Broken). See [agent/plugins/field-mapping.md](plugins/field-mapping.md).

## Services (apisync_mapping.services.yml)
- `apisync_mapping.mappable_entity_types` (`ApiSyncMappableEntityTypes`), `apisync_mapping.apisync_id_provider` (`ApiSyncIdProvider`), `apisync_mapping.mapped_object_factory` (`ApiSyncMappedObjectFactory`), `apisync_mapping.apisync_delete_provider` (`ApiSyncDeleteProvider`), `plugin.manager.apisync_mapping_field`.

## Events (src/Event via apisync_mapping)
`ApiSyncPushAllowedEvent`, `ApiSyncPushEvent`, `ApiSyncPushOpEvent`, `ApiSyncPushParamsEvent`, `ApiSyncPullEvent`, `ApiSyncPullEntityValueEvent`, `ApiSyncQueryEvent`, `ApiSyncDeleteAllowedEvent`. Constants in `MappingConstants` (trigger + direction strings). Push value objects: `PushParams`, `PushActions`.

## Permissions (apisync_mapping.permissions.yml — all restricted)
`administer apisync mapping`, `view apisync mapping`, `administer apisync mapped objects`, `administer apisync mapped object type`, `view apisync mapped object type`.

## Field type & validation
`Plugin/Field/FieldType/ODataLinkItem(+List)`; constraint validators `MappingEntityTypeConstraintValidator`, `UniqueFieldsConstraintValidator`.

## Drush (drush.services.yml → ApiSyncMappingCommands)
`odata:read-object`, `apisync_mapping:prune-revisions`, `apisync_mapping:purge-drupal`, `apisync_mapping:purge-apisync`, `apisync:purge-mapping`.
