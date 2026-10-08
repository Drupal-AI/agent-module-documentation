# Manager service & alter events

## `entity_export_csv.manager` (`EntityExportCsvManager`)

The central service used by the settings/export forms and by exports. Interface
`EntityExportCsvManagerInterface`; useful methods:

- `getSupportedContentEntityTypes($return_object = TRUE)` — all exportable content entity types.
- `getContentEntityTypesEnabled($return_label = FALSE)` — those enabled in settings.
- `getBundlesPerEntityType($entity_type_id, $return_label = TRUE)` — bundles of a type.
- `getBundlesEnabledPerEntityType($entity_type_id, $return_label = FALSE)` — enabled bundles.
- `getBundleFields($entity_type_id, $bundle, $return_field_definition = FALSE)` — all fields.
- `getBundleFieldsEnabled($entity_type_id, $bundle, $return_field_definition = FALSE)` — exportable fields.
- `getBundleFieldDefinitions($entity_type_id, $bundle)` — field definitions.
- `getConfigurations($entity_type_id = '')` — saved `entity_export_csv` config entities.
- `sortNaturalFields(array &$fields, array $default_values)`, `getDelimiters()`.

Constructor args (from `entity_export_csv.services.yml`): `config.factory`,
`entity_type.manager`, `entity.repository`, `language_manager`, `entity_field.manager`,
`plugin.manager.field_type_export`, `current_user`, `entity_type.bundle.info`,
`event_dispatcher`, `queue`, `datetime.time`, `state`.

Batch export is performed by `EntityExportCsvBatch`; the resulting file is streamed by
`Controller\EntityExportCsvDownload::downloadExport` (private filesystem preferred, temporary
as fallback).

## Events (`EntityExportCsvEvents`)

Both let you alter which fields the module offers/exports, per entity type and/or bundle:

| Constant | Event name | Event class | Fired |
|---|---|---|---|
| `ENTITY_EXPORT_CSV_FIELDS_SUPPORTED` | `entity_export_csv.fields_supported` | `EntityExportCsvFieldsSupportedEvent` | before returning the **supported** field list |
| `ENTITY_EXPORT_CSV_FIELDS_ENABLE` | `entity_export_csv.fields_enable` | `EntityExportCsvFieldsEnabledEvent` | before returning the **enabled** field list |

Subscribe with a normal `EventSubscriberInterface` service tagged `event_subscriber` to add
or remove fields from either list.
