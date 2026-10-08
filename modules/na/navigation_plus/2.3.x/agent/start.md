<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Navigation + (navigation_plus) — agent index

A pluggable editing UI built on core **navigation**: an Edit Mode, three plugin types
(**Mode / Tool / Sidebar**), per-user hotkeys, and drag-to-upload media. It is the shared
foundation of the +Suite page builder (Edit+, Layout Builder+) — usually arrives as a
**dependency of `lb_plus`/`edit_plus`**, not chosen directly. Package *Page Building*.
Core **`^11` only**. Depends on `navigation`, `twig_events`, `tempstore_plus`. Version **2.3.x**.
Configure at `/admin/config/content/plus-suite` (sets UI accent colors only).

## What it provides

- **Three plugin types** (attribute + interface + base + manager service):
  - **Mode** — `#[Mode]` / `ModeInterface` / `ModePluginBase` / `plugin.manager.modes`. A mode
    replaces the whole Navigation UI. Ships one: `Plugin/Mode/Edit` (id `edit`) + `EditFrontPage`.
  - **Tool** — `#[Tool]` / `ToolInterface` / `ToolPluginBase` / `plugin.manager.tools`. Buttons in
    a mode's toolbar. Ships one: `Plugin/Tool/Pointer` (id `pointer`, neutral default).
  - **Sidebar** — `#[Sidebar]` / `SidebarInterface` / `SidebarPluginBase` /
    `plugin.manager.navigation_plus_sidebars`. Left/right panels bound to a mode and/or tool. Ships
    `Plugin/Sidebar/SettingsSidebar` and `NotificationsSidebar`.
- **`NavigationPlusUi`** (`navigation_plus.ui`) — assembles everything via
  `hook_preprocess_navigation/top_bar/field` and `hook_entity_view_alter`. Also `ModeState`
  (lightweight mode lookup), `EditorSettings` (per-user prefs), `ViewModeTracker`,
  `NavigationPlusServiceProvider` (registers Layout Builder / entity_workflow-conditional services).
- A base field `navigation_plus_settings` (map) added to **user** entities for per-user prefs.
- Config object `navigation_plus.settings` (UI `colors`) + bundle third-party settings under the
  `navigation_plus` namespace (`initial_mode`, `status`, `modes`).

## Permissions

`use toolbar plus edit mode` (editors — note a `# todo` in `navigation_plus.permissions.yml`: the
machine name still carries the module's former "toolbar plus" name and is flagged for a rename
update hook) · `configure toolbar plus modes` (who decides which modes exist per bundle) ·
`administer Navigation + configuration` (settings page).

## Routes (see api/routes-and-services.md)

`navigation_plus.settings` (`/admin/config/content/plus-suite`) ·
`navigation_plus.load_editable_page` (AJAX page rebuild) ·
`navigation_plus.mode.{enable,disable,configure}` (per bundle) ·
`navigation_plus.settings.{save_user_hotkey,remove_media_file_association,save_setting}` (per-user
prefs) · `navigation_plus.{new_media,replace_media}` (drag-upload, `_entity_access` entity.update) ·
`navigation_plus.block_plugin.edit` (`_entity_access` block.update).

## Solution docs

- [config/settings.md](config/settings.md) — install/enable, the settings form + config object,
  per-bundle mode configuration, per-user preferences.
- [plugins/plugin-types.md](plugins/plugin-types.md) — how to add a Mode, Tool, or Sidebar plugin.
- [api/routes-and-services.md](api/routes-and-services.md) — routes, controllers, services, hooks,
  and the tempstore/AJAX edit flow.

## Submodule

`navigation_plus_entity_workflow` is **deprecated** ("functionality has been moved into the main
module … will be deleted soon"). Documented separately under
`modules/navigation_plus_entity_workflow/`. Do not recommend or install it.
