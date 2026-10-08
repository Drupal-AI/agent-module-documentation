<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OpenAPI Decoupled toolbox (openapi_decoupled_toolbox) — agent index

Sub-module of **Decoupled Toolbox** (package **Web Services**). Generates OpenAPI 3.0 docs for decoupled endpoints. Core `>=8`. GPL-2.0-or-later. Version 1.6.0-rc0. `configure`: `openapi_decoupled_toolbox.settings`.

- Depends on: `openapi` (contrib, `>=8.x-2.0-rc1`), `decoupled_toolbox`. composer.json patches OpenAPI.

## What it provides

- Config entity type **`openapi_decoupled_toolbox`** (`ConfigEntityType`, class `OpenApiDecoupledToolbox`): `config_export` fields `id`, `label`, `entity_type`, `bundle` (array), `display` (array). Custom `OpenApiDecoupledToolboxHtmlRouteProvider` + list builder; add/edit/delete/settings forms under `src/Form/`.
- OpenAPI generator plugins in `src/Plugin/openapi/OpenApiGenerator/`: `DecoupledToolboxGeneratorBase`, `DecoupledToolboxGenerator`, `DecoupledToolboxRestGenerator`, `DecoupledToolboxGeneratorInterface`, plus `Plugin/Derivative/OpenAPiDecoupledToolboxDeriver`.
- Block plugin `src/Plugin/Block/MenuBlock.php`; event subscriber `openapi_decoupled_toolbox.subscriber` (`OpenApiDecoupledToolboxSubscriber`, arg `@token`).
- Route `openapi_decoupled_toolbox.settings` (`/admin/config/services/openapi/decoupled-toolbox`, `administer site configuration`) → `OpenApiDecoupledToolboxSettingsForm`; entity CRUD routes via the HTML route provider; menu/task/action links. Config schema provided.
- No permissions of its own beyond core admin permissions.

## Operate

Enable with the OpenAPI module present. Create `openapi_decoupled_toolbox` entities (entity type + bundles + displays) to declare documented endpoints, then view the spec via openapi_ui. See the parent [api/endpoints.md](../../../1.6.x/agent/api/endpoints.md) for the endpoints being documented.
