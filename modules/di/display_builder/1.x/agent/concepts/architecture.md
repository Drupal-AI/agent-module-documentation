<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Display Builder architecture

The base module is an engine. It defines the plugin types, entities and services; the four
submodules plug concrete display kinds and admin screens on top.

## The four moving parts

1. **Buildable** (`display_buildable` plugin type) — *what kind of display* is being built.
   - Manager: `plugin.manager.display_buildable` = `DisplayBuildablePluginManager`
     (`src/DisplayBuildablePluginManager.php`), also aliased to its class name.
   - Attribute `#[DisplayBuildable(id, label, instance_prefix)]`
     (`src/Attribute/DisplayBuildable.php`). ID must equal the group or be prefixed `group:...`.
   - Interface `DisplayBuildableInterface` / base `DisplayBuildablePluginBase`; discovered under a
     module's `Plugin/display_builder/Buildable/`.
   - Each plugin owns an `instance_prefix` (used to build stable instance IDs) and a **static
     `checkAccess(string $instance_id, AccountInterface $account)`** consulted by
     `InstanceAccessControlHandler`. Submodule plugins: `entity_view`, `entity_view_override`
     (display_builder_entity_view), `page_layout` (display_builder_page_layout), `view_display`
     (display_builder_views), plus `FullPageBuilderPageVariant`.

2. **Island** (`db_island` plugin type) — *the builder's UI pieces*: panels, toolbars, buttons.
   - Manager: `plugin.manager.db_island` = `IslandPluginManager`.
   - Attribute `#[Island(id, label, enabled_by_default, description, deriver, type, region, icon,
     modules, attach_to, pane_header)]` (`src/Attribute/Island.php`); `IslandType` enum splits
     islands into View/Button/Floating with regions (sidebar/main, start/end).
   - Interface `IslandInterface` / base `IslandPluginBase`; discovered under
     `Plugin/display_builder/Island/`. ~30 ship: `ComponentLibraryPanel`, `BlockLibraryPanel`,
     `PresetLibraryPanel`, `BuilderPanel`, `TreePanel`, `PreviewPanel`, `StylesPanel`,
     `HistoryButtons`, `StateButtons`, `ViewportSwitcher`, `Collaboration`, `ContextualFormPanel`,
     `ScaffoldPanel`, `VisibilityConditionsPanel`, `Menu`, `SaveStatus`, `DesignTokensPanel`, etc.
   - Which islands appear (and their weight/config) is decided per **Profile**.

3. **Instance** (`display_builder_instance` content entity) — the *working draft* being edited.
   - `src/Entity/Instance.php`, storage `InstanceStorage`, access `InstanceAccessControlHandler`,
     list builder `display_builder_ui`'s `InstanceListBuilder`.
   - Revisionable + translatable. Base fields (see `display_builder.install`): `id` (string),
     `buildable` (a core `plugin` field bound to `plugin.manager.display_buildable`), `sources`
     (unlimited `ui_patterns_source` — the nested source tree), `hash` (int), `published`
     (timestamp), plus standard revision/langcode fields. IDs are string-prefixed by the buildable
     (`instance_prefix`), giving stable, deterministic IDs per display.
   - History for undo/redo/publish lives in `InstanceStorage` (`undo()`, `redo()`, `clearFuture()`)
     and `Instance` methods (`publish()`, `restore()`, `revert()`).

4. **Profile** (`display_builder_profile` config entity) — the *builder configuration*.
   - Decides which islands are enabled and how they are configured for a given builder screen.
   - See [config/profile.md](../config/profile.md).

## Sources (UI Patterns 2)

The content dropped into a display are **UI Patterns 2 sources**, not bespoke objects. The base
module adds source plugins in `src/Plugin/UiPatterns/Source/`:

- `ComponentSource` — an SDC component (with its props/slots).
- `BlockSource` — a block plugin, extending UI Patterns' block source; it swaps unresolvable
  page-chrome blocks (breadcrumb, messages, local tasks/actions, help) for named placeholders
  while inside a builder (`FORCE_PLACEHOLDER`), rendering the real block only on a real page.
- `LayoutSource` — a core Layout plugin as a container.
- `TextareaWidget` — a raw text source.

Helper services: `component_library_definitions` (SDC + source definitions for the component
library), `block_library_sources` (`BlockLibrarySources` — groups/sorts block choices, hides
noisy ones), `slot_sources_proxy`, `summary_collector`.

## Rendering & preview

- `ProfileViewBuilder` renders a builder screen (islands laid out per profile).
- Live preview is an isolated iframe: route `display_builder.preview_island`
  (`ApiPreviewController::getDisplayPreview`) renders just the Preview island, on a bare full page,
  so the display gets its own viewport. A buildable that is "pinned" to a real page
  (`getPreviewPagePath()`) is previewed by issuing a **sub-request** through the real page
  pipeline, carrying the draft as the request attribute `_display_builder_preview_instance`
  (never a query arg — so no public URL/cache entry is created). Page-cache policy
  `DenyPreviewSubRequest` and `LivePreviewChrome`/`FullPageVariantSubscriber` keep the preview
  clean and uncached.

## Events

`DisplayBuilderEvents` names the mutation events (`ON_ATTACH_TO_ROOT`, `ON_ATTACH_TO_SLOT`,
`ON_MOVE`, `ON_DELETE`, `ON_UPDATE`, `ON_HISTORY_CHANGE`, `ON_PUBLISH`, `ON_RESTORE`, `ON_REVERT`,
`ON_PRESET_SAVE`, `ON_ACTIVE`). `DisplayBuilderEventsSubscriber` fans an event out to the enabled
islands so each returns its refreshed HTMX fragment; `FullPageVariantSubscriber` selects the
full-page variant for preview routes. See [api/routes.md](../api/routes.md).
