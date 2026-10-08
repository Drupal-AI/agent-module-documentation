<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entities: Profile, Converter, Contextualized Attribute, and the GID field

## maps_sync_profile (config entity)

`src/Entity/Profile.php` — `@ConfigEntityType id = "maps_sync_profile"`, prefix
`maps_sync_profile`, `admin_permission = "administer site configuration"`. Forms: add/edit
(`ProfileForm`), delete, `import` (`ProfileImportForm`), `attribute_import_wizard`
(`ProfileAttributeImportWizardForm`); routes via `ProfileHtmlRouteProvider` under
`/admin/a12s_maps_sync/profile/…`.

`config_export` / schema keys (`config/schema/maps_sync_profile.schema.yml`):
`default_maps_language` (int — MaPS language id), `medias_path` (string — filesystem/stream path
where MaPS media files live), `python_profile_id` (string — the MaPS "python profile" id used in
every API URL, e.g. `<base>/<python_profile_id>/objects`). A profile owns its converters
(`Profile::getConverters()`).

## maps_sync_converter (config entity)

`src/Entity/Converter.php` — `@ConfigEntityType id = "maps_sync_converter"`. One converter maps a
MaPS source (object type / media type / library) to a Drupal `entity_type` + `bundle`. Forms
(local tasks): `edit` (`ConverterForm`), `filters` (`ConverterFiltersForm`), `mapping`
(`ConverterMappingForm`), `auto_config` (`ConverterAutoConfigForm`), `import`
(`ConverterImportForm`), `delete`. Key schema fields
(`config/schema/maps_sync_converter.schema.yml`):

- `profile_id`, `entity_type`, `bundle`, `maps_type`, `handler_id` (which `maps_sync_handler`
  plugin runs the import), `parent`, `weight`.
- `filters` (sequence of `{type, filtering_type, value}`) — narrow which MaPS items import.
- `mapping` (sequence of `{source, target, handler, append, required, requiredBehavior, status,
  options}`) — per-field correspondence; `handler` names a `maps_sync_mapping_handler` plugin.
- `auto_config` (`attribute_sets`, `attributes_deny_list`, `libraries_management`) — feeds
  `AutoConfigManager`.
- Status handling: `published_statuses` / `unpublished_statuses` / `deleted_statuses`,
  `status_management`, `status_property`, `status_property_name`, `media_status_published_value`.
- `gid` (sequence) — properties composing the global identifier; `flush_image_styles`.

`Converter` exposes `rollback()` (delete everything it imported) and `resetLastImportedTime()`
(force a full re-import) used by the Drush commands.

## contextualized_attribute (content entity) + type

`src/Entity/ContextualizedAttribute.php` — `@ContentEntityType id = "contextualized_attribute"`,
base table `contextualized_attribute`, bundle entity `contextualized_attribute_type`,
`field_ui_base_route` set so fields are managed per type. Stores criteria-scoped (contextualized)
attribute values for multi-tree MaPS data. Access is **not** the entity admin permission alone —
`ContextualizedAttributeAccessControlHandler::checkAccess()` gates view/update/delete/create on the
dedicated `… contextualized attribute` permissions (OR `administer contextualized attribute`).

## The GID base field

`Maps\BaseInterface::GID_FIELD` ("MaPS Sync ID", string, max 128, non-translatable) is attached by
`a12s_maps_sync_entity_base_field_info_alter()` to every entity type listed in
`a12s_maps_sync.settings:allowed_entity_types`. It stores the computed global id so a re-import
updates the existing entity instead of creating a duplicate. Enabling a new allowed type on the
settings form installs the field storage via a batch; disabling a type leaves the stored field in
place (with a warning).
