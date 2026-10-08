# Schema.org Blueprints — config entities & settings

All admin routes require `administer schemadotorg`. Landing: `/admin/config/schemadotorg`.

## Config entities

### `schemadotorg_mapping` (class `Entity\SchemaDotOrgMapping`)
Links one Drupal entity type + bundle to a Schema.org type and records field→property mappings.
Id form: `<entity_type>.<bundle>`. Key data (see `SchemaDotOrgMappingInterface`):
- `target_entity_type_id`, `target_bundle` — the Drupal side.
- `schema_type` — the mapped Schema.org type (e.g. `Person`).
- `schema_properties` — map of `field_name => schema_property`.
- `additional_mappings` — extra Schema.org types layered on (schemadotorg_additional_mappings).
- List/edit/delete UI at `/admin/config/schemadotorg/mappings[/{mapping}[/delete]]`.
  (The **add** form is provided by the `schemadotorg_ui` submodule, not the base module.)

### `schemadotorg_mapping_type` (class `Entity\SchemaDotOrgMappingType`)
Per Drupal entity type (installed for `node` and `user`): which Schema.org types are recommended/default and
how names are generated. Fields include `target_entity_type_id`, `multiple`, `label_prefix`/`id_prefix`,
`recommended_schema_types` (grouped sets like `quick_start`/`common`/`web`/`content`), and default-type maps.
Collection at `/admin/config/schemadotorg/types`.

## Settings — `schemadotorg.settings`

Edited across four forms under `/admin/config/schemadotorg/settings/`:
`general` (`SchemaDotOrgSettingsGeneralForm`), `types`, `properties`, `names`. Notable keys:
- `schema_data.file` — path template to the Schema.org CSV data (`data/[VERSION]/…-[TABLE].csv`).
- `schema_types.default_types` — Schema.org type → default Drupal `{name,label}` (e.g. `WebPage → page`).
- `schema_types.*` — recommended types, subtyping, and default property sets per type.
- `schema_properties.*` — per-property behavior, default field types, and **ignored properties**
  (properties that should never become fields).
- naming rules consumed by `SchemaDotOrgNames` (custom words/abbreviations, e.g. `GTIN`, `RxCUI`).

Separate config `schemadotorg.names` holds `custom_words`/`custom_names` abbreviation maps used to keep
generated machine names within Drupal's length limits.

## Creating a mapping without the UI

Use Drush (`schemadotorg:create-type`) or the mapping manager service — see
[../drush/drush.md](../drush/drush.md) and [../api/services.md](../api/services.md).
