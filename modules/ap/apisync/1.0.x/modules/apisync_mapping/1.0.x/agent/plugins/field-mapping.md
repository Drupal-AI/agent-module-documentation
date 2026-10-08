<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# apisync_mapping_field plugins — Drupal ⇄ remote field conversion

Each entry in a mapping's `field_mappings` is an instance of an `apisync_mapping_field` plugin that converts one field value between the Drupal entity and the remote OData object.

## Plugin type
- Dir: `src/Plugin/ApiSyncMappingField`. Manager: `plugin.manager.apisync_mapping_field` = `ApiSyncMappingFieldPluginManager` (extends `DefaultPluginManager`, implements `FallbackPluginManagerInterface`; missing plugins fall back to `broken`).
- Interface: `ApiSyncMappingFieldPluginInterface`; base: `ApiSyncMappingFieldPluginBase`.
- Plugins are declared with the `@Plugin(id=…, label=…)` annotation (e.g. `Properties` → `id = "properties"`).
- A plugin defines the config form for one field row (`buildConfigurationForm()`), the direction it supports, and how it reads/writes the Drupal value vs. the remote value (push params + pull value).

## Shipped plugins
- **`properties`** (`Properties` / `PropertiesBase`) — map to a Drupal entity property/field chosen from a select of available properties. `PropertiesExtended` adds nested/typed-data property paths.
- **`related_properties`** (`RelatedProperties`) — pull/push a property of a referenced entity.
- **`related_ids`** (`RelatedIDs`) — map the ID(s) of a related/referenced entity.
- **`related_term_string`** (`RelatedTermString`) — map a taxonomy term as a string.
- **`token`** (`Token`) — value produced from a Drupal token string (push/drupal→remote).
- **`constant`** (`Constant`) — a fixed constant value.
- **`drupal_constant`** (`DrupalConstant`) — a value from a Drupal constant/config.
- **`broken`** (`Broken`) — fallback for a missing/invalid plugin definition.

## Direction & triggers
Direction constants (`MappingConstants`): `drupal_remote` (push), `remote_drupal` (pull), `sync` (both). Multi-value remote fields use the delimiter `;` (`APISYNC_MAPPING_ARRAY_DELIMITER`). Field-map name max length 128; trigger max length 16.

## How values flow
- **Push**: `ApiSyncMappedObject::push()` asks each field plugin for its push value; the assembled `PushParams` (see `PushParams`/`PushActions`) is sent via the OData client (`objectCreate`/`objectUpdate`). An `ApiSyncPushParamsEvent` lets subscribers alter params.
- **Pull**: `ApiSyncMappedObject::pull()` reads the remote `ODataObject` and, per field plugin, writes the value onto the Drupal entity; `ApiSyncPullEntityValueEvent` / `ApiSyncPullEvent` allow alteration. The mapped Drupal entity is saved with syncing set to avoid a push loop.

## Extending
Add a class in your module's `Plugin/ApiSyncMappingField/` implementing `ApiSyncMappingFieldPluginInterface` (extend `ApiSyncMappingFieldPluginBase`) with a unique `@Plugin` id; it appears as a field-type option in the mapping fields form (`apisync_mapping_ui`).
