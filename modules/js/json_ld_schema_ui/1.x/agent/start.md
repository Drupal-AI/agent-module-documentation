<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON-LD Schema UI (json_ld_schema_ui) — agent index

A UI for mapping content-entity data to **schema.org** types and emitting the result as a
`<script type="application/ld+json">` block in the page `<head>`. Configure per bundle, store the
mapping in a `schema_content_settings` config entity, and let editors override values per entity.
Depends on the contrib **`entity`** (Entity API) module. Core `^9 || ^10 || ^11`. License
GPL-2.0-or-later. Version 1.0.6 (single `1.x` branch).

- **Bundle mapping, the config entity, routes, permission, forms** →
  [config/bundle-schema.md](config/bundle-schema.md)
- **The `jsonld` field: field type, widget, the computed `processed` value, and the head formatter
  (how the JSON-LD is built and rendered)** → [fields/jsonld.md](fields/jsonld.md)
- **Site settings config object, schema.org fetch/parse services** →
  [config/settings.md](config/settings.md)

## What it actually is

- One config entity type **`schema_content_settings`** (`src/Entity/ContentSchemaSettings.php`,
  admin_permission `administer content schema settings`, config prefix `content_settings`). One row
  per (entity type, bundle, schema type); stores enabled `schema_properties` with default values.
- One field type **`jsonld`** (`no_ui = TRUE`) with widget **`jsonld_default`** and formatter
  **`jsonld_head`**. A hidden `jsonld_schema` field is auto-installed on any bundle that has a
  mapping (via `hook_entity_bundle_field_info` / `ContentSchemaSettings::preSave()`), and
  auto-uninstalled when the last mapping for an entity type is deleted (`postDelete()`).
- One permission: **`administer content schema settings`** (`*.permissions.yml`). It gates the
  settings route, all bundle schema routes, and the `hook_entity_operation` link.
- Services (`*.services.yml`): `json_ld_schema_ui.schemaorg.fetcher` (`RemoteFetcher`),
  `.schemaorg.parser` (`Parser`), `.schema` (`SchemaData`), a config subscriber, and a route
  subscriber. No Drush.

## Routes (from source)

- `json_ld_schema_ui.settings` → `/admin/config/search/schemaorg/settings`
  (`SchemaSettingsConfigForm`), perm `administer content schema settings`. Menu link under
  *Configuration → Search and metadata*; also the module's `configure` route.
- Per bundle, added by `RouteSubscriber` on every entity type that has a `field_ui_base_route`:
  - `entity.<entity_type>.json_ld_schema_ui` → `<field-ui-path>/json_ld_schema`
    (`EntitySchemaConfigurationForm`) — the *Manage JSON LD schema* local task.
  - `entity.<entity_type>.json_ld_schema_ui.add_property` →
    `<field-ui-path>/json_ld_schema/add_property/{schema_type}/{property_path}`
    (`EntitySchemaAddPropertyForm`).
  Both require `administer content schema settings`.
- A `hook_entity_operation` "Manage JSON LD schema" op is added on bundle entities for permitted
  users (`json_ld_schema_ui.module`).

## Mechanism, in one line

Bundle mapping (config entity) + per-entity overrides (field) → `JsonLdProcessed::getValue()` runs
values through `\Drupal::token()->replace()` and `json_encode(..., JSON_UNESCAPED_UNICODE)` into a
schema.org `@context`/`@graph` document → `JsonLdHeadFormatter` attaches it as an `html_head`
`script` tag. See [fields/jsonld.md](fields/jsonld.md).
