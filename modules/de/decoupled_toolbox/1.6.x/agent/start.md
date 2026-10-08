<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Decoupled Toolbox (decoupled_toolbox) — agent index

Exposes Drupal entity content as JSON on `/decoupled-api/{type}/{bundle}/collection`, configured
through the Field UI via a generated **Decoupled** view mode (id `decoupled`). Read-only, pull-only.
Package **Decoupled**. Core `>=10.1`. License GPL-2.0-or-later. Version **1.6.0-rc0**.
No module dependencies (base module); sub-modules declare their own.

- **The collection endpoint, REST resource, filter syntax, paging, events, and access model** →
  [api/endpoints.md](api/endpoints.md)
- **Decoupled field formatters, the Decoupled view mode, and the location solver** →
  [fields/formatters.md](fields/formatters.md)
- **Config object, settings form, and the API version mechanism** →
  [config/settings.md](config/settings.md)

## What it actually is

- One route `decoupled_toolbox.entity_decoupled_data.collection` (GET
  `/decoupled-api/{type}/{bundle}/collection`) → `EntityDecoupledDataController::collection`,
  gated by permission **`access decoupled api`**.
- One admin settings route `decoupled_toolbox.settings`
  (`/admin/admin/config/services/decoupled-toolbox`, `administer site configuration`) →
  `DecoupledToolboxSettingsForm`.
- One REST resource plugin `deoupled_toolbox_collection` (`CollectionResource`, note the
  upstream typo in the id) on the same canonical path.
- A set of **field formatter plugins** (`src/Plugin/Field/FieldFormatter/*`) implementing
  `DecoupledFormatterInterface` — `decoupled_generic`, `_text`, `_integer`, `_float`,
  `_boolean`, `_timestamp`, `_link`, `_link_url`, `_path`, `_list_key`, `_json`,
  `_generic_raw`, `_file`, `_image`, `_generic_image`, `_entity_reference`,
  `_entity_reference_id`, `_entity_reference_field`.
- Services: `decoupled.request.entity` (`RequestEntity`, builds+runs the collection query),
  `decoupled.renderer` (`DecoupledRenderer`, renders an entity through its decoupled display),
  `decoupled.entity_view_display.manager` (`EntityViewDisplayManager`, creates the view
  mode/displays), `decoupled.location_solver` (`LocationSolver`), `decoupled.route_subscriber`,
  `logger.channel.decoupled_toolbox`.
- Hooks: `hook_install` and `hook_entity_bundle_create` create the decoupled view mode/displays;
  `hook_form_entity_view_display_edit_form_alter` adds the API-version bump control;
  `hook_help`.
- One permission: **`access decoupled api`**. One config object: `decoupled_toolbox.settings`
  (schema provided). No Drush.

## Sub-modules (each documented in its own nested tree under `modules/<submodule>/1.6.x/`)

- `decoupled_toolbox_comment`, `decoupled_toolbox_color_field`,
  `decoupled_toolbox_duration_field`, `decoupled_toolbox_weight` — extra decoupled formatters
  for those contrib/core field types.
- `decoupled_toolbox_redirect` — computed `redirect_source__path` base field + formatter.
- `decoupled_toolbox_decoupled_router` — filter by path alias via a condition preprocessor.
- `decoupled_toolbox_group` — `/decoupled-api/group/{gid}/{type}/{bundle}/collection` endpoint;
  nests `decoupled_toolbox_group_content_menu`.
- `openapi_decoupled_toolbox` — OpenAPI 3.0 generator + `openapi_decoupled_toolbox` config
  entity describing which endpoints to document.

## Operating notes (from source)

- The collection endpoint (`RequestEntity::getCollection`) emits whatever fields are placed on
  the decoupled display and is gated by the `access decoupled api` permission; it accepts an
  `accessCheck` option and exposes query/processable events for per-entity gating. See
  `agent/api/endpoints.md` → "Access model".
  Grant that permission deliberately and treat the endpoint as returning all entities of the
  bundle (see [api/endpoints.md](api/endpoints.md)).
- Standard core field formatters produce **no** decoupled output — only formatters implementing
  `DecoupledFormatterInterface` are serialized.
