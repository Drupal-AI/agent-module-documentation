<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bundle schema mapping — config entity, routes, forms, field lifecycle

How a bundle gets mapped to schema.org types and how the storage field is created.
Files: `src/Entity/ContentSchemaSettings.php`, `src/Routing/RouteSubscriber.php`,
`src/Form/EntitySchemaConfigurationForm.php`, `src/Form/EntitySchemaAddPropertyForm.php`,
`src/Plugin/JsonLdUiLocalTask.php`, `json_ld_schema_ui.module`, config schema
`json_ld_schema_ui.content_settings.*.*.*`.

## Config entity `schema_content_settings` (`ContentSchemaSettings`)

- `@ConfigEntityType(id = "schema_content_settings", admin_permission =
  "administer content schema settings", config_prefix = "content_settings",
  list_cache_tags = {"entity_field_info"})`.
- `config_export`: `id`, `bundle`, `target_entity_type`, `target_bundle`, `schema_type`,
  `schema_properties`.
  - `id()` = `<target_entity_type>.<target_bundle>.<lowercase schema_type>`; `bundle()` =
    `<target_entity_type>.<target_bundle>`.
  - `schema_properties` is a nested tree (config schema `schema_property_configuration`): each leaf
    has `default_value` (string, tokens allowed), `allow_override` (bool), `allow_multiple` (bool),
    optional `enum_type`; reference properties carry a nested `properties` sequence.
- `getOverridableProperties()` returns the subtree the per-entity widget may expose (leaves with
  `allow_override`, plus non-empty reference branches; `@type` is excluded).
- **Field lifecycle** (the important side effects):
  - `preSave()`: if this is the first mapping for the target entity type, it installs a `jsonld`
    `BundleFieldDefinition` named `jsonld_schema` via `entityDefinitionUpdateManager()
    ->installFieldStorageDefinition()`.
  - `postDelete()`: if the last mapping for an entity type is removed, it uninstalls that field
    storage.
  - `hook_entity_field_storage_info` / `hook_entity_bundle_field_info` (in `.module`) also declare
    the `jsonld_schema` field for entity types/bundles that have `content_settings.*` config, with a
    default `jsonld_head` view display (label hidden) and a configurable form widget at weight 40.
- `hook_entity_bundle_info_alter` builds a synthetic `schema_content_settings` bundle list (used for
  labels); `hook_entity_operation` adds the "Manage JSON LD schema" operation link for permitted users.

## Routes & local tasks (all perm `administer content schema settings`)

`RouteSubscriber::alterRoutes()` iterates entity types with a `field_ui_base_route` and adds two
routes per type (only when the type has a bundle entity type):

- `entity.<entity_type>.json_ld_schema_ui` → `<field_ui_path>/json_ld_schema` →
  `EntitySchemaConfigurationForm`. Surfaced as a local task by the `JsonLdUiLocalTask` deriver
  (`*.links.task.yml`), title "Manage JSON LD schema".
- `entity.<entity_type>.json_ld_schema_ui.add_property` →
  `<field_ui_path>/json_ld_schema/add_property/{schema_type}/{property_path}` →
  `EntitySchemaAddPropertyForm`.

So for nodes the tab lives at e.g. `/admin/structure/types/manage/{node_type}/json_ld_schema`.

## `EntitySchemaConfigurationForm` (the bundle tab)

- "Add a new schema": a select of every schema.org type path (from `SchemaData::getDescendantPaths`
  under the root), plus an "Add schema" button. `validateAddSchema()` blocks duplicate
  (entity type, bundle, type) ids; `submitAddSchema()` creates a `schema_content_settings` entity.
- Per configured type: a details section with a properties table. Each property row edits
  `default_value` (textfield, or select for `enum_type`), `allow_override`, `allow_multiple`, and a
  per-row "Delete property" / "Delete all children" submit. Reference properties get their own
  nested table plus an "Add more properties" link to the add_property route.
- `submitForm()` writes the table values back into each entity's `schema_properties` tree and saves.
  `submitDeleteSchema()` / `submitDeleteProperty()` handle removals. `processSubform()` scopes
  `#limit_validation_errors` so the many nested submit buttons behave.
- If Token is installed a `token_tree_link` for the target entity type is shown.

## `EntitySchemaAddPropertyForm`

- Given `{schema_type}` and `{property_path}`, walks the existing property tree (throws
  `Invalid property path` if the path's `@type` is missing), resolves the active schema.org type,
  and offers a select of that type's still-unused properties grouped by declaring type
  (`SchemaData::getProperties()`). An Ajax "Add property as" select then lets you add the property as
  a simple value, as a nested reference type, or as an enumeration. `submitForm()` inserts the new
  property node into `schema_properties` and saves. Property/type ids and labels come only from the
  parsed schema.org vocabulary, not from free-text input.

## How to operate

1. `drush en json_ld_schema_ui` (pulls in contrib `entity`).
2. Visit a bundle's *Manage JSON LD schema* tab, add a schema type, enable properties, set default
   values (tokens allowed), and tick "Allow override" for anything editors may change per entity.
3. Saving the first mapping auto-creates the hidden `jsonld_schema` field; entities of that bundle
   now render the JSON-LD in `<head>` (see [../fields/jsonld.md](../fields/jsonld.md)).
4. Central management of all bundles' settings is also available from the settings page area
   (see [settings.md](settings.md)).
