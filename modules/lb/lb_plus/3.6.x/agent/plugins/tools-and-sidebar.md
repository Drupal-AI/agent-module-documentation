<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# lb_plus — editor tools & sidebar plugins

The LB+ interface is built as **navigation_plus plugins**, not core Layout Builder UI. lb_plus does not
define its own plugin types; it provides `#[Tool]` and `#[Sidebar]` plugins consumed by
`navigation_plus`'s Edit Mode. JS behaviours live under `js/tools/<tool>/…` and are attached through
the library groups in `lb_plus.libraries.yml` (`editing_ui`, `place_block`, `move`, `layout`, `trash`,
`configure`, `duplicate`).

## Tool plugins (`src/Plugin/Tool/`, attribute `#[Tool(id, label, hot_key, weight)]`)
| id | Class | Hot key | Purpose |
|---|---|---|---|
| `place_block` | `PlaceBlock` | `b` | Open the block/section palette and drag new items in. |
| `move` | `Move` | `m` | Drag existing blocks/sections to a new position or storage. |
| `layout_tool` | `Layout` | `l` | Change a section's layout; enter a Layout Block's nested layout. |
| `configure` | `Configure` | `o` | Open the section/block configuration modal. |
| `duplicate` | `Duplicate` | `d` | Duplicate a block in place. |
| `trash` | `Trash` | `t` | Remove a block/section. |

Each drives the matching AJAX route in `agent/api/layout-editing.md`. Tools declare their icons
(`getIconsPath()` / `lb_plus.icons.yml`) and attach their JS via `addAttachments()`.

## Sidebar plugin (`src/Plugin/Sidebar/PlaceBlock.php`, `#[Sidebar]`)
`id: place_block`, `side: left`, `mode: edit`, `tool: place_block`. Builds the left-rail palette:
**promoted** blocks first, then all other searchable blocks, plus a "Page Layout Section" draggable
and (when nothing is promoted) a link to the promoted-blocks form. Promoted set and icons come from
the `lb_plus.promoted_blocks` / `lb_plus.block_config` third-party settings (see
`agent/config/settings.md`). Re-rendered by `Controller\PlaceBlockSidebar::update`.

## Traits reused across plugins/controllers
`LbPlusToolTrait`, `LbPlusEntityHelperTrait` (derive entity/section-storage from route),
`LbPlusSettingsTrait` (read `lb_plus.settings`), `LbPlusRebuildTrait` (build rebuild AjaxResponses).

## Test block
`src/Plugin/Block/ColorfulTestBlock.php` is a demo/test block (renders a color string); not a
production feature.
