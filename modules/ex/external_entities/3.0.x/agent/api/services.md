# API: services, storage/query, tokens

## Services (`external_entities.services.yml`)

| Service id | Class | Use |
|---|---|---|
| `plugin.manager.external_entities.storage_client` | `StorageClient\StorageClientManager` | Storage-client plugins |
| `plugin.manager.external_entities.data_aggregator` | `DataAggregator\DataAggregatorManager` | Aggregator plugins |
| `plugin.manager.external_entities.field_mapper` | `FieldMapper\FieldMapperManager` | Field-mapper plugins |
| `plugin.manager.external_entities.property_mapper` | `PropertyMapper\PropertyMapperManager` | Property-mapper plugins |
| `plugin.manager.external_entities.data_processor` | `DataProcessor\DataProcessorManager` | Data-processor plugins |
| `entity.query.external` | `Entity\Query\External\QueryFactory` | Backend for entity queries against external entity types (`backend_overridable`) |
| `external_entities.response_decoder_factory` | `ResponseDecoder\ResponseDecoderFactory` | Collects `external_entity_response_decoder`-tagged decoders (e.g. `serialization.xnttjson`) |
| `external_entities.rest.http_client_factory` | `GuzzleHttp\DebugClientFactory` | Builds the debug Guzzle client |
| `external_entities.rest.debug_client` | `GuzzleHttp\DebugClient` | Logs HTTP traffic when a type's `debug_level` > 0 |
| `logger.channel.external_entities` | logger channel | Module logger |
| `route_processor_external_entity_type` | `RouteProcessor\RouteProcessorExternalEntityType` | Outbound route processing for per-type routes |
| `external_entities.route_update_subscriber` | `EventSubscriber\RouteUpdateSubscriber` | Rebuilds routes on type changes |
| `external_entities.external_entities_subscriber` | `EventSubscriber\ExternalEntitiesSubscriber` | Core event subscriber |

## Storage & entity API

- Storage handler `Drupal\external_entities\ExternalEntityStorage` (`ExternalEntityStorageInterface`)
  is the `storage` handler of every derived entity type. Load via
  `\Drupal::entityTypeManager()->getStorage('<type_id>')->load($id)` / `loadMultiple()` — data is
  fetched live from the storage clients, not the DB.
- Entity class `Entity\ExternalEntity` (`ExternalEntityInterface`). Useful methods:
  `getExternalEntityType()`, `toRawData()`, `getOriginalRawData()`, `mapAnnotationFields()`.
- Config entity `Entity\ExternalEntityType` (`ConfigurableExternalEntityTypeInterface`): programmatic
  API for mapping — `getDataAggregator()`, `getDataAggregator()->getStorageClients()`,
  `getFieldMapper($field)`, `getMappableFields()`, `getEditableFields()`, `getSavableFields()`,
  `getRequiredFields()`, `isReadOnly()`, `isAnnotatable()`, `getDerivedEntityTypeId()`.
- Entity queries use `entity.query.external` (`Entity\Query\External\Query`), translating conditions
  to source filters via the storage client. `isCountable()` reflects whether the source can count.
- Access: `ExternalEntityAccessControlHandler` (entity-type-granular). Translation:
  `ExternalEntityTranslationHandler`.

## Hooks the module implements (integration points)

Defined in `.module` / `Hook\ExternalEntityHooks`: `hook_entity_type_build` (derives one content
entity type per `external_entity_type`), `hook_entity_operation(_alter)`,
`hook_entity_bundle_field_info_alter` (annotation title field), `hook_entity_view_alter` +
`hook_theme` (`external_entity` template + suggestions), `hook_form_alter` (adds the `id` field on
external-entity forms), `hook_entity_insert/update/delete` (auto-saves the annotated external entity),
`hook_cron` (prunes `xntt_rest_queries`), `hook_field_storage_config_presave` /
`hook_field_config_presave` (adds config dependency on the owning type).

## Tokens

`hook_token_info` / `hook_tokens` (legacy in `.module`, and `Hook\ExternalEntityHooks` for Drupal
11.2+) expose external-entity tokens, and the `EXTERNAL_ENTITY_TOKEN` event
(`external_entity.token`) lets modules add/alter token content. Storage clients replace Drupal tokens
in endpoint URLs, headers, and parameters.
