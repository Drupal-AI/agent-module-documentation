<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Display JSON (entity_display_json) — agent index

Read-only JSON API for Drupal entities driven by **Manage Display** (view-display) config. Three
`GET /ejson/*` routes serialize an entity (or view) using a named display mode; output is
extensible via `FieldValueExtractor` plugins and alter hooks. Package **Web services**. Core
`^10.2 || ^11`. License GPL-2.0-or-later. Version 1.2.0 (version-dir 1.2.x).

- **No required dependencies.** Optional integrations auto-detected when installed: **Views**
  (view + `views_block:*` serialization), **Block Field**, **Paragraphs** (recursive refs),
  **Field Group** (nested groups). Composer `suggest` lists `block_field`, `paragraphs`, `views`.
- **One permission:** `access entity display json` (`entity_display_json.permissions.yml`). No
  settings form (`configure: null`); output is shaped by each entity type's Manage Display config.

## Solution docs

- **Endpoints, routes, permission, controllers, response envelope, param converter** →
  [api/endpoints.md](api/endpoints.md)
- **Serialization mechanism: `EntityJsonBuilder`, access enforcement, recursion, views, field
  groups, per-field third-party settings, config schema** → [api/builder.md](api/builder.md)
- **`FieldValueExtractor` plugin type, the six built-in extractors, and the four alter hooks** →
  [plugins/field-value-extractors.md](plugins/field-value-extractors.md)

## At a glance (from source)

- Routes (`entity_display_json.routing.yml`), all `methods: [GET]`, `_format: json`,
  `_permission: 'access entity display json'`:
  - `entity_display_json.info` `/ejson` → `EntityDisplayJsonInfo::getInfo`
  - `entity_display_json.resolve` `/ejson/resolve` → `EntityDisplayJsonResolver::resolve`
  - `entity_display_json.build` `/ejson/{entity_type}/{uuid}/{display_id}` (default `default`) →
    `EntityDisplayJsonController::build`
- Services (`entity_display_json.services.yml`): `entity_display_json.builder`
  (`EntityJsonBuilder`), `.view_serializer` (`ViewResultsSerializer`), `.path_entity_resolver`
  (`PathEntityResolver`), the three controllers, `.param_converter.display_id`
  (`EntityDisplayIdConverter`, tag `paramconverter`), and the plugin manager
  `plugin.manager.entity_display_json.field_value_extractor` (`FieldValueExtractorManager`).
- Programmatic API: `\Drupal::service('entity_display_json.builder')->serialize($entity, $langcode, $display_id, $cacheability)`
  (`EntityJsonBuilderInterface`, `API_VERSION = '1.0'`).
- Ships optional config: a `json` view mode for node/media/paragraph/taxonomy_term/user
  (`config/optional/core.entity_view_mode.*`). Config schema in
  `schema/entity_display_json.schema.yml` (formatter third-party settings). JSON payload contract
  in `schema/entity-payload.schema.json`.
- Test-only submodule `entity_display_json_test` lives under `tests/` (not a shipped submodule).
