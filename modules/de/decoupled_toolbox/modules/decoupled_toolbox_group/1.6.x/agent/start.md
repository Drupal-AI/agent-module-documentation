<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Decoupled Toolbox for Group (decoupled_toolbox_group) — agent index

Sub-module of **Decoupled Toolbox**. Adds a per-group collection endpoint. Package **Decoupled**. Core `>=8`. GPL-2.0-or-later. Version 1.6.0-rc0.

- Depends on: `group` (contrib), `decoupled_toolbox`. Nests `decoupled_toolbox_group_content_menu`.

## What it provides

- Route `decoupled_toolbox.group.entity_decoupled_data.collection` — GET `/decoupled-api/group/{gid}/{type}/{bundle}/collection`, `_permission: 'access decoupled api'` → `GroupEntityDecoupledDataController::collection`.
- `GroupEntityDecoupledDataController` (extends `DecoupledDataControllerBase`, uses `FilterTrait`): loads the group, finds the `GroupContent` plugin matching `{type}`/`{bundle}` via `getInstalledContentPlugins()`, loads the referenced entities (batched by 50), re-applies `filter[...]` conditions in `filterContentByQueryParameters()`, and renders via `decoupled.renderer`.
- Declares an event_subscriber service `decoupled_toolbox_group.event_subscriber` (`DecoupledToolboxGroupSubscriber`) in `decoupled_toolbox_group.services.yml`.
- No permissions/config of its own beyond reusing `access decoupled api`.

## Access model

Like the base endpoint, entity retrieval does not add per-entity access checks beyond the `access decoupled api` permission and Group membership scoping; grant the permission deliberately and see parent [api/endpoints.md](../../../1.6.x/agent/api/endpoints.md).
