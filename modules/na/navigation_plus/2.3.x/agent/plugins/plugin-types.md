<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Navigation + — the three plugin types

Navigation + is a framework: it ships almost no editing behaviour of its own (one Pointer tool,
one Edit mode, two sidebars). Other modules extend it by adding **Mode**, **Tool**, and **Sidebar**
plugins. Each type has an attribute (`src/Attribute/`), an interface, a base class, and a manager
service (extending `default_plugin_manager`, discovering `Plugin/<Type>/*` classes).

## Mode — replace the whole Navigation UI

- Attribute `#[Mode(id, label, weight)]` (`Attribute/Mode`); interface `ModeInterface` (extends
  `ConfigurableInterface`); base `ModePluginBase`; manager `plugin.manager.modes`
  (`ModePluginManager`).
- A mode contributes a toggle button at the bottom of the Navigation menu (`buildModeButton()`), a
  toolbar shown in place of the Navigation toolbar when active (`buildToolbar()`), and top/side
  bars (`buildBars()`). `applies()` decides whether it is offered on the current request;
  `addAttachments()` attaches its libraries; `getSummary()` labels its per-bundle config row.
- Ships **`Plugin/Mode/Edit`** (id `edit`, label "Edit Mode", weight 100) and
  `Plugin/Mode/EditFrontPage`. `Edit` implements `PluginFormInterface`: its
  `buildConfigurationForm()` exposes a **Default tool** radio, `defaultConfiguration()` defaults to
  `edit_plus` (if installed) else `last`, and its config is stored per bundle under `modes.edit`.
  `Edit::applies()` fires a `ShouldNotEditModeEvent` so other modules can veto edit mode for an
  entity. `Edit::buildToolbar()` renders a tool button per applicable tool (using core's icon
  system) and passes `initialMode` / `defaultTool` / tool-indicator SVGs into `drupalSettings`.

## Tool — a button inside a mode's toolbar

- Attribute `#[Tool(id, label, hot_key, weight)]` (`Attribute/Tool`); interface `ToolInterface`;
  base `ToolPluginBase`; manager `plugin.manager.tools` (`ToolPluginManager`).
- `applies(EntityInterface $entity)` decides whether the tool works on the routed entity (so tools
  filter themselves per entity type). `getIconsPath()` returns the icon pack/id plus optional mouse
  cursor CSS and tool-indicator SVGs. `buildToolTopBarButtons()` / `buildGlobalTopBarButtons()`
  contribute top-bar buttons (the latter shown for every tool); `buildSettings()` contributes to
  the settings sidebar; `subTools()` and `addAttachments()` round it out.
- Ships **`Plugin/Tool/Pointer`** (id `pointer`) — the neutral default tool, active when the
  `activeTool` cookie is unset (`NavigationPlusUi::getActiveTool()` defaults to `pointer`). Editing
  tools (inline edit, layout) come from `edit_plus` / `lb_plus`.
- `NavigationPlusUi::getToolPlugins()` instantiates every tool definition and keeps those whose
  `applies()` returns TRUE for the entity derived from the route
  (`NavigationPlusUi::deriveEntityFromRoute()`).

## Sidebar — a left/right panel

- Attribute `#[Sidebar(id, label, side, weight, sidebar_type='default', mode=NULL, tool=NULL,
  use_lazy_builder=FALSE)]` (`Attribute/Sidebar`); interface `SidebarInterface`; base
  `SidebarPluginBase`; manager `plugin.manager.navigation_plus_sidebars` (`SidebarPluginManager`).
- **Two axes** (documented on the interface): `applies()` decides whether the panel exists in the
  DOM at all (presence); the attribute binding (`mode`/`tool`) plus the side's `{side}_sidebar`
  cookie decide whether a present panel is *visible*. Panels are rendered present-but-hidden and
  revealed client-side, so the wrappers never re-render on a mode or tool switch — see
  `NavigationPlusUi::buildSidebars()`, `buildSidebarPanel()`, `isSidebarVisible()`.
- `id` is the panel's single identity: it is used verbatim as the DOM id **and** as the value the
  `{side}_sidebar` cookie holds while this panel is open. `build()` returns only the inner render
  array (core wraps it). `buildToggleButton()` owns the open/close button; a mode-bound panel's
  toggle is collected into that mode's top bar, an always-on (mode `NULL`) panel gets a standalone
  floating toggle. `use_lazy_builder` streams a panel in under BigPipe (opt-in — e.g. a deferred
  custom-element chat panel).
- Ships `Plugin/Sidebar/SettingsSidebar` and `Plugin/Sidebar/NotificationsSidebar`. The stable
  `navigation-plus-{side}-sidebar` wrapper id is a cross-module contract: modules whose panels are
  dynamic/per-request (can't be static `#[Sidebar]` plugins) append into that wrapper by id at
  runtime.

## Events (extension hooks for the above)

`src/Event/` defines dispatched events consumers subscribe to: `ShouldNotEditModeEvent` (veto edit
mode), `EditableFieldAttributes` / `EditableUiBuilder` (add editing markup to fields/UI),
`LoadEditablePageEvent`, `SettingsSidebarEvent`, `LayoutBuilderNewMedia` /
`LayoutBuilderReplaceMedia` (media drag-upload responses). The module's own subscribers live in
`src/EventSubscriber/`.
