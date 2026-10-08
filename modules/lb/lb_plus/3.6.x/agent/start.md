<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Builder + (lb_plus) — agent index

Drop-in replacement for the core Layout Builder editing UI: drag-and-drop tools, a block-placement
sidebar, and — the substantive addition — **nested sections** (sections inside Layout Blocks).
Version **3.6.x** (`3.6.12`). Core **`^11` only** on the top-level project (submodules allow `^10 || ^11`).

Depends on `layout_builder`, `block`, **`tempstore_plus`**, **`navigation_plus`** (the editing UI is
built out of navigation_plus "Edit Mode" tools/sidebars). Its own `configure` route is shared with
`navigation_plus.settings` (UI colors live there after `lb_plus_update_10000`).

## What it provides
- **Permissions** (`lb_plus.permissions.yml`): `administer layout builder + configuration`,
  `promote layout builder + blocks`.
- **AJAX editing routes** under `/lb-plus/…` (duplicate/move/place/remove blocks, add/move/change
  sections). All gated by core's own `_layout_builder_access: 'view'`. → `agent/api/layout-editing.md`
- **Settings/admin routes & config** (`lb_plus.settings`, per-display default section & promoted
  blocks). → `agent/config/settings.md`
- **Nested-section architecture**: `NestedSectionStorageInterface`, `SectionStorage/TreeIndex`,
  `NestedAwareSectionStorage*`, the `layout_builder_plus` render element, and event subscribers.
  → `agent/architecture/nested-sections.md`
- **Editor tools & sidebar** — navigation_plus `Tool` and `Sidebar` plugins (place-block, move,
  layout, configure, duplicate, trash). → `agent/plugins/tools-and-sidebar.md`
- **Entity handling**: overrides `entity_view_display` with `LayoutBuilderEntityViewDisplay`;
  tracks inline blocks via `InlineBlockEntityOperations` / `InlineBlockUsage`.

## Key classes (in `src/`)
Controllers: `Controller/DropZones`, `DuplicateBlock`, `EditBlockLayout`, `ChangeLayout`,
`PlaceBlockSidebar`. Services: `Dropzones`, `SectionStorage/NestedAwareSectionStorageManager`,
`Config/NoHelpBlock`. Routing: `Routing/LayoutBuilderRouteSubscriber`, `Routing/NestedRouteEnhancer`.

## Submodules (own nested doc trees under `modules/`)
- `lb_plus_section_library` — Section Library support: save a page/section to a reusable template
  and drag templates back in (needs `section_library`, `navigation_plus`).
- `lb_plus_lb_block_decorator` — nested-layout support for the `lb_block_decorator` module.
- `lb_plus_edit_plus` — **deprecated** (`lifecycle: deprecated`). Functionality moved into `lb_plus`;
  it exists only so `lb_plus_edit_plus_update_10001` can uninstall it. Do not recommend it.

**Adoption note:** this pulls in the `navigation_plus` / `tempstore_plus` family that jointly
replace parts of the editing experience — it is a stack decision, not one module.
