<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# lb_plus — AJAX layout-editing routes & controllers

All editing happens through AJAX POST/GET callbacks defined in `lb_plus.routing.yml`. Each takes the
core Layout Builder path parameters `{section_storage_type}/{section_storage}` (the section_storage is
resolved from the shared tempstore: `options.parameters.section_storage.layout_builder_tempstore: TRUE`).
The `Request` body carries JS-supplied UUIDs/destinations. Controllers write back to the tempstore via
`layout_builder.tempstore_repository` and return an `AjaxResponse` that rebuilds the (possibly nested)
layout DOM.

## Access
Every mutation route requires **`_layout_builder_access: 'view'`** — the same requirement core Layout
Builder puts on its own add/move/remove/configure routes. Authority therefore comes from the target
**section storage** (the entity's layout access), not from a new lb_plus permission. There is no
separate "edit layout" permission introduced here.

## Routes → controller methods
| Route id | Path (under `/lb-plus`) | Controller::method |
|---|---|---|
| `lb_plus.contextual_link.duplicate_block` | `/duplicate/block/…/{uuid}` | `Controller\DuplicateBlock::duplicate` |
| `lb_plus.contextual_link.layout_block.edit` | `/edit/block/layout/…/{block_uuid}` | `Controller\EditBlockLayout::nestedLayoutBuilderUIAjaxCallback` |
| `lb_plus.tool_indicator.choose_layout` | `/layout-options/…/{section_uuid}` | `Controller\ChangeLayout::chooseLayout` |
| `lb_plus.js.configure_changed_layout` | `/configure-section-layout-change/…/{section_uuid}/{plugin_id}` | `Controller\ChangeLayout::changeAndConfigureNewLayout` |
| `lb_plus.js.load_place_block_sidebar` | `/load-place-block-sidebar/…` | `Controller\PlaceBlockSidebar::update` |
| `lb_plus.js.place_block` | `/place-block/…` | `Controller\DropZones::placeBlock` |
| `lb_plus.js.move_block` | `/move/block/…` | `Controller\DropZones::moveBlock` |
| `lb_plus.js.move_section_drop_zone` | `/move-section/…` | `Controller\DropZones::moveSection` |
| `lb_plus.js.add_section_drop_zone` | `/add-empty-section/…` | `Controller\DropZones::addEmptySection` |

## Controller behaviour
- **`DropZones`** (`src/Controller/DropZones.php`, uses `LbPlusRebuildTrait`, `LbPlusSettingsTrait`).
  - `placeBlock()` — reads `place_block[destination]`/`plugin_id`, validates `destination.type` is
    `region` or `section`, calls `Dropzones::getOrCreateSection()` + `createBlockPlugin()` +
    `createBlockContent()` + `insertBlock()`. If the placed plugin is a Layout Block it fires
    `LBPlusEditLayout` to open the new nested layout.
  - `moveBlock()` — DB transaction; removes the component from its source section and re-inserts it
    at the destination; remaps `FieldBlock` `context_mapping.entity` when moving across storages
    (`mapContextToParentEntity` / `mapContextBackToLbEntity`).
  - `moveSection()` — DB transaction; moves a section between (possibly nested) section lists using
    `getSectionsFor()` + `findSectionDeltaInList()`.
  - `addEmptySection()` — creates a section via `getOrCreateSection()`, then triggers
    `LBPlusChangeLayout` so the user picks a layout.
- **`DuplicateBlock::duplicate()`** — deep-clones a component and its config; for `InlineBlock`
  layout blocks it recursively `createDuplicate()`s the `block_content` and every nested section
  (`cloneBlock`/`cloneSection`), re-serialising into `configuration['block_serialized']`.
- **`ChangeLayout`** — `chooseLayout()` returns an off-canvas item-list of available layout plugins
  (`layoutManager->getFilteredDefinitions('layout_builder', …)`); `changeAndConfigureNewLayout()`
  rebuilds the section under the chosen `plugin_id`, moves components into the new default region,
  then opens the section-configure modal (`LBPlusConfigureSection`).
- **`EditBlockLayout::nestedLayoutBuilderUIAjaxCallback()`** — renders a `layout_builder_plus`
  element scoped to `#layout_block_uuid`, replacing `[data-block-uuid=…]` so a Layout Block's inner
  layout becomes editable in place; 404s if the UUID isn't a layout block (`isLayoutBlock`).
- **`PlaceBlockSidebar::update()`** — re-renders the place-block sidebar (`updatePlaceBlockSidebar`).

## Contextual links
`lb_plus.links.contextual.yml` re-declares block Configure/Duplicate/Remove and the Layout-Block
"Edit layout" link. `hook_contextual_links_alter` (in `lb_plus.module`) removes core's
`layout_builder_block_*` links in favour of these nested-aware ones, and — inside a nested layout —
strips any contextual link that has not opted in with `supports_nested_layouts: 'true'`.
