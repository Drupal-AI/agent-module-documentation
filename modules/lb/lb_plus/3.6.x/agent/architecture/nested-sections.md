<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# lb_plus — nested-section architecture

The defining feature is **sections inside sections**, achieved by letting a `Layout Block` (an inline
block_content that itself has a `layout_builder__layout` field) contain its own sections. LB+ wraps the
normal Layout Builder section storage so callers can address any block/section anywhere in that tree by
its `lb_plus`/`uuid` third-party setting.

## Core interfaces & classes (`src/`)
- **`NestedSectionStorageInterface`** — the addressing API over the whole tree. Key methods:
  `getComponent()`, `getSectionByUuid()`, `getSectionFor()`, `getSectionsFor()`, `getPath()`,
  `getNestedContext()` (returns `layoutBlockUuid` for DOM targeting), `isLayoutBlock()`,
  `getBlockContentEntity()`, `bubbleChangesToRoot()`, `invalidateCache()`,
  `mapContextToParentEntity()` / `mapContextBackToLbEntity()` (FieldBlock context remapping across
  storages), `forLayoutBlock()` / `getLayoutBlockScope()`, `isDirty()` / `markDirty()`.
- **`SectionStorage\NestedAwareSectionStorage`** — the wrapper implementation
  (`::wrap($section_storage)`); static helpers `extractBlockContent()` and `pluginIsLayoutBlock()` are
  reused by the clone logic in controllers and `lb_plus.install`.
- **`SectionStorage\NestedAwareDefaultsSectionStorage` / `NestedAwareOverridesSectionStorage`** —
  nested-aware subclasses of core's defaults/overrides storage plugins.
- **`SectionStorage\NestedAwareSectionStorageManager`** — decorates
  `plugin.manager.layout_builder.section_storage` (implements `SupportAwareSectionStorageManagerInterface`,
  `CachedDiscoveryInterface`) so `load()`/`findByContext()` return wrapped storages.
- **`SectionStorage\TreeIndex`** (`TreeIndexInterface`) — flat index mapping every section/block UUID
  to its path in the nested tree, so lookups don't walk the structure each time.
- **`NestedSectionStorageInterface::getPath()`** returns the delta-path; `EditBlockLayout` and the
  controllers use it to scope AJAX rebuilds.

## Render element & rebuild
- **`Element\LayoutBuilderPlus`** provides the `layout_builder_plus` render element (registered via
  `hook_element_plugin_alter`, which swaps core's `layout_builder` element class). It renders the
  editable UI, an optional `#layout_block_uuid` scope for nested editing, contextual links
  (`addContextualLinks()`), and a "blank page" prompt when empty.
- **`LbPlusRebuildTrait`** / **`LbPlusRebuildTrait::rebuildLayout()`** build the `AjaxResponse` that
  replaces `#layout-builder` (root) or `[data-nested-storage-uuid=…]` (a nested layout block).
- **`Dropzones`** service (`lb_plus.dropzones`) — placement engine: `createBlockPlugin()`,
  `createBlockContent()`, `insertBlock()`, `getOrCreateSection()`, `findSectionDeltaInList()`.

## Event subscribers (`lb_plus.services.yml`, `src/EventSubscriber/`)
`EditableUiBuilder` (builds the edit-mode UI), `BlockComponentRenderArray`, `LayoutBlock`,
`NestedLayoutResponseSubscriber` (post-processes nested AJAX responses), `SetInlineBlockDependency`,
`NavigationPlusNewMedia` / `NavigationPlusReplaceMedia` (media integration). Custom events:
`Event\PlaceBlockEvent`, `Event\BlockToolIndicatorEvent`, `Event\SectionToolIndicatorEvent` (the
Section Library submodule subscribes to the last one).

## Entity integration (`lb_plus.module`)
- `hook_entity_type_alter` swaps `entity_view_display` to `Entity\LayoutBuilderEntityViewDisplay`
  (forced to run last via `hook_module_implements_alter`).
- `hook_entity_presave/insert/update` delegate to `InlineBlockEntityOperations` (replacing
  `layout_builder`'s presave) and `InlineBlockUsage` to track inline blocks — including nested ones.
- `ContextProvider\NodeRouteContextOverride` supplies node context for nested layout editing.
