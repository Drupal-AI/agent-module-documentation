<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Api Sync Mapping UI (apisync_mapping_ui) — agent index

Submodule of [apisync](../../../../1.0.x/agent/start.md). Admin UI for mappings and mapped objects. Package `Liip`, core `^9.1 || ^10 || ^11`. Depends on `apisync_mapping`. `configure: entity.apisync_mapping.list`. No new entities/permissions — it renders the ones from `apisync_mapping`.

## Routes (apisync_mapping_ui.routing.yml)
Mappings under `/admin/structure/apisync/mappings` (permission `administer apisync mapping` / entity access):
- `entity.apisync_mapping.list` (list), `.add_form`, `.edit_form`, `.fields` (field-map builder), `.delete_form`, `.enable`, `.disable`.
Mapped objects under `/admin/content/apisync` (`administer apisync mapped objects`):
- `entity.apisync_mapped_object.list|canonical|add_form|edit_form|delete_form`.
Mapped-object types under `/admin/structure/apisync/mapped-object-types` (`administer apisync mapped object type`).
- `apisync_mapping.autocomplete_controller_autocomplete` — `/apisync_mapping/autocomplete/{entity_type_id}/{bundle}` (JSON, `administer apisync mapped objects`).

## Forms (src/Form)
`ApiSyncMappingFormBase` / `ApiSyncMappingFormCrudBase`, `ApiSyncMappingAddForm`, `ApiSyncMappingEditForm`, `ApiSyncMappingFieldsForm` (per-field-map rows using `apisync_mapping_field` plugins), `ApiSyncMappingDeleteForm`, `ApiSyncMappingEnableForm`, `ApiSyncMappingDisableForm`; `ApiSyncMappedObjectForm`, `ApiSyncMappedObjectDeleteForm`, `ApiSyncMappedObjectTypeForm`, `ApiSyncMappedObjectTypeDeleteForm`.

## Controllers / list builders / plugins
- Controllers (src/Controller): `ApiSyncMappingController` (title callbacks), `ApiSyncMappedObjectController`, `AutocompleteController::autocomplete()`.
- List builders: `ApiSyncMappingList`, `ApiSyncMappedObjectList`.
- `Routing\RouteSubscriber` (service `apisync_mapping.route_subscriber`) — alters/adds entity routes.
- `Plugin/Derivative/ApiSyncMappingLocalTask`, `Plugin/Menu/LocalAction/ApiSyncMappedObjectAddLocalAction`.

## Config
`config/optional/views.view.apisync_mapped_objects.yml` — optional Views listing of mapped objects (installed when Views is present).

## Links
`*.links.menu.yml`, `*.links.action.yml`, `*.links.task.yml`, `*.links.contextual.yml` wire the admin menu, tabs, and add actions.
