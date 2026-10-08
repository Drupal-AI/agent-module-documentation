<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Display Builder HTMX API & access model

All routes are in `display_builder.routing.yml`; controllers in `src/Controller/`. Every builder
edit is an HTTP request against an instance; the browser drives them with HTMX
(`options._htmx_route: true`, which only affects rendering — core `HtmxContentViewSubscriber`).

## Access model

- **Mutation** routes require `_entity_access: 'display_builder_instance.update'`.
- **Read / preview-of-instance** routes require `_entity_access: 'display_builder_instance.view'`.
- **Library preview** routes (`api_component_preview`, `api_block_preview`, `api_preset_preview`)
  require only `_role: 'authenticated'`.

`InstanceAccessControlHandler::checkAccess()` gates the instance in two steps:
1. `checkProfileAccess()` — the instance's Profile must pass `view` access
   (`ProfileAccessControlHandler`: `administer display builder profile`, or the per-profile
   "Use the *label*" permission from `ProfilePermissions`). A missing profile → forbidden.
2. `checkBuildableAccess()` — matches the instance ID prefix to a buildable plugin and delegates to
   that plugin's static `checkAccess()` (e.g. the entity-view buildable checks the underlying
   entity/display access). An instance matching no provider (demo/test) is allowed.

The builder *screens* themselves live in the submodules and are gated by admin permissions
(`administer page_layout`, `administer views` + `_entity_access: view.update`,
`administer display builder profile`, `view display builder instance`).

## Mutation endpoints (`ApiController`, `ApiActionsController`, `ApiPublishingController`)

Path base `/api/display-builder/{display_builder_instance}`:

| Route | Method | Controller::method | Effect |
|---|---|---|---|
| `…` (api_root_attach) | POST | `ApiController::attachToRoot` | Attach a source / move a node / attach a preset to the root. |
| `…/_node/{node_id}/{slot}` (api_slot_attach) | POST | `ApiController::attachToSlot` | Same, into a component slot. |
| `…/_node/{node_id}` (api_get) | GET | `ApiController::get` | Return one node's active state (`ON_ACTIVE`). |
| `…/_node/{node_id}` (api_update) | PUT/POST | `ApiController::update` | Validate the contextual form and write a node's source values. |
| `…/_node/{node_id}/settings/{island_id}` (api_third_party_settings_update) | PUT | `ApiController::thirdPartySettingsUpdate` | Write an island's per-node third-party settings. |
| `…/island/{island_id}` (api_island_reload) | GET | `ApiController::reloadIsland` | Re-render one deferred island (only cacheable GET; busts on instance cache tag). |
| `…/undo`, `…/redo` | POST | `ApiController::undo` / `redo` | History via `InstanceStorage`. |
| `…/paste`, `…/duplicate` | POST | `ApiActionsController::paste` | Deep-copy a node (regenerates nested `node_id`s) to root or slot. |
| `…/delete` | POST | `ApiActionsController::delete` | Remove a node. |
| `…/save_as_preset` | POST | `ApiActionsController::saveAsPreset` | Create a `pattern_preset` from a node (label from `hx-prompt` header). |
| `…/paste-styles`, `…/delete-styles` | POST | `ApiActionsController::pasteStyles` / `deleteStyles` | Copy/merge or clear a node's `styles` third-party setting. |
| `…/publish`, `…/restore`, `…/revert` | POST | `ApiPublishingController::publish` / `restore` / `revert` | Draft→published, restore to published, revert an override. |

Each mutation calls `Instance::save()` then `dispatchDisplayBuilderEvent()`
(`ApiControllerBase`), which builds a `DisplayBuilderEvent`, dispatches it to the enabled islands,
records SSE state in the `display_builder_sse` shared tempstore, and returns the islands' HTMX
fragments. `ApiControllerBase::getVisibleIslands()` reads the `X-DB-Visible-Islands` request
header so off-screen islands are deferred.

Contextual-form input (`update`, `thirdPartySettingsUpdate`) is run through the real Form API:
`validateIslandForm()` builds/validates the island's form class
(`ContextualFormPanel::getFormClass()` / the island's `getFormClass()`), strips Form API keys, and
lets a `SourceProcessingDataInterface` source divert its own values before they land in the tree.
Validation errors are surfaced back to the editor; other exceptions are logged (`buildError`).

## Preview endpoints (`ApiPreviewController`)

| Route | Auth | Renders |
|---|---|---|
| `/display-builder/preview/{display_builder_instance}` (preview_island) | `_entity_access: .view` | The instance's Preview island in its own iframe (no_cache). Pinned buildables render via a real-page sub-request carrying the draft attribute. |
| `/api/display-builder/component/{component_id}/preview/{variant_id}` | `_role: authenticated` | An SDC component (from its first story, or example props/slots). Unknown IDs return empty. |
| `/api/display-builder/block/{block_id}` | `_role: authenticated` | A block plugin (as a UI Patterns block source), for the block-library hover preview. |
| `/api/display-builder/preset/{preset_id}` | `_role: authenticated` | A `pattern_preset`'s stored sources. |

## SSE (`ApiSseController::sse`)

`/api/display-builder/{display_builder_instance}/sse` (`_entity_access: .view`) returns an
`EventStreamResponse`. It loops (2s window), and when the shared tempstore shows another **session**
edited this instance recently (within `STALE`), it recomputes the islands
(`ON_HISTORY_CHANGE`) and streams each changed island's rendered `content` back as an
`island-{id}-{island_id}` server event, so a collaborator's panels refresh. The editor's own
session and stale edits are skipped (no feedback loop).
