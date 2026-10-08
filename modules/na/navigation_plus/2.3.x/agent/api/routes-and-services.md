<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Navigation + — routes, controllers, services, hooks

## Routes & permissions (`navigation_plus.routing.yml`)

| Route | Path | Handler | Access |
|---|---|---|---|
| `navigation_plus.settings` | `/admin/config/content/plus-suite` | `Form/SettingsForm` | `administer Navigation + configuration` |
| `navigation_plus.load_editable_page` | `/navigation-plus/load-editable-page/{entity_type}/{entity}/{view_mode}` | `Controller/LoadEditablePage` | `use toolbar plus edit mode` |
| `navigation_plus.mode.enable` | `/navigation-plus/mode/enable/{plugin_id}/{entity_type_id}/{entity_bundle_id}` | `ModeController::enable` | `configure toolbar plus modes` |
| `navigation_plus.mode.disable` | `.../mode/disable/...` | `ModeController::disable` | `configure toolbar plus modes` |
| `navigation_plus.mode.configure` | `.../mode/configure/...` | `Form/ModeConfigureForm` | `configure toolbar plus modes` |
| `navigation_plus.settings.save_user_hotkey` | `/navigation-plus/save-user-hotkey/{tool_id}/{hotkey}` | `Settings::saveHotkey` | `use toolbar plus edit mode` |
| `navigation_plus.settings.remove_media_file_association` | `/navigation-plus/remove-media-file-association/{file_extension}` | `Settings::removeMediaFileAssociation` | `use toolbar plus edit mode` |
| `navigation_plus.settings.save_setting` | `/navigation-plus/setting/{namespace}/{key}/{value}` | `Settings::saveSetting` | `use toolbar plus edit mode` |
| `navigation_plus.replace_media` | `/navigation-plus/replace-media/{entity_type}/{entity}/{view_mode}/{media_reference}/{media_bundle}` | `MediaUpload::replaceMedia` | `_entity_access: entity.update` |
| `navigation_plus.new_media` | `/navigation-plus/new-media/{entity_type}/{entity}/{view_mode}` | `MediaUpload::newMedia` | `_entity_access: entity.update` |
| `navigation_plus.block_plugin.edit` | `/block-plugin/{block}/{view_mode}` | `BlockPluginEdit::render` | `_entity_access: block.update` |

Permissions (`navigation_plus.permissions.yml`): `use toolbar plus edit mode` (editors — the
machine name is flagged with a `# todo` for a rename update hook), `configure toolbar plus modes`
(site builders), `administer Navigation + configuration` (settings page).

## Controllers (`src/Controller/`)

- **`LoadEditablePage`** (`__invoke`) — the AJAX heart. When an editor enters Edit Mode, JS calls
  this to rebuild the current page *with* editing attributes and replace it in-place
  (`getAjaxReplaceResponse`). It checks `isValidViewMode()`, then `$entity->access('update')`, then
  `ensureWorkspace()`, then loads the entity from `tempstore_plus` (in edit mode) and re-renders it.
  Supports an alternate build path (`edit_mode_use_path` query) for a block whose display is managed
  by Layout Builder — that sub-request is run through the router so **access checks still apply**.
- **`MediaUpload`** (`newMedia`, `replaceMedia`) — handle a file dragged onto a dropzone. Both
  routes are gated by `_entity_access: entity.update`. `newMedia` sanitizes the view mode against
  `getViewModes()`; validators are derived from media-type source-field extensions/size
  (`getNewMediaValidators` / `getReplaceMediaValidators`), and the upload goes through core's
  `file.upload_handler` into `public://media` (`uploadFile()`).
- **`ModeController`** (`enable`, `disable`) — flip a mode's `status` third-party setting on a
  bundle and return the refreshed operations dropbutton.
- **`Settings`** (`saveSetting`, `saveHotkey`, `removeMediaFileAssociation`) — per-user preference
  endpoints; each operates only on `$this->currentUser()`'s own `navigation_plus_settings` field.
- **`BlockPluginEdit`** (`render`, `title`) — render a single block (whose display is LB-managed)
  in isolation for editing; `_entity_access: block.update`.
- **`WorkspaceSwitcher`** (extends `entity_workflow_content`'s controller) — wraps the workspace
  switcher form for the edit-mode workspace flow (only registered when `entity_workflow` is present;
  see the service provider).

## Services (`navigation_plus.services.yml`)

- `navigation_plus.ui` (`NavigationPlusUi`) — builds toolbars/sidebars/top bar via
  `hook_preprocess_navigation`, `hook_preprocess_top_bar`, `hook_preprocess_field`; a
  `TrustedCallbackInterface` for the `buildSidebarPanel` lazy builder.
- `plugin.manager.modes` / `plugin.manager.tools` / `plugin.manager.navigation_plus_sidebars` — the
  three plugin managers (see plugins/plugin-types.md).
- `navigation_plus.mode_state` (`ModeState`) — lightweight mode lookup (single source of truth for
  the current mode, so cycle-sensitive consumers avoid the heavy UI service).
- `navigation_plus.editor_settings` (`EditorSettings`) — per-user preference read/write API.
- `navigation_plus.view_mode_tracker` (`ViewModeTracker`).
- `navigation_plus.messenger.edit_mode` (`EditModeMessenger`) — **decorates** core `messenger`
  (priority 100) so status messages are intercepted while in Edit Mode; plus
  `EditModeAjaxMessages` / `EditModeHtmlMessages` and the AJAX commands in `src/Ajax/`.
- `navigation_plus.activation_checker` — decorates `tempstore_plus.activation_checker`.
- `navigation_plus.outbound_path_processor` — `path_processor_outbound` (priority 350).
- Event subscribers (`src/EventSubscriber/`): `EntityUiWrapper`, `ShouldNotEditMode`,
  `NewMediaFileAssociationSettings`, `HotkeySettings`, `InitialMode`.
- `NavigationPlusServiceProvider::alter()` conditionally registers extra subscribers: LB block
  attributes (when `layout_builder` present), replace-media field attributes (always), and the
  `Before`/`After` entity-workflow route enhancers (when `entity_workflow` present).

## Hooks (`navigation_plus.module` + `src/Hook/`)

- `hook_preprocess_navigation/top_bar/field` → `NavigationPlusUi`.
- `hook_entity_view_alter` → `Hooks/EntityViewAlter` (`navigation_plus.entity_view_alter`).
- `hook_form_alter` → bundle-edit alter + a Workspace switcher submit redirect fix.
- `hook_entity_base_field_info` → adds `navigation_plus_settings` (map) to **user**.
- `hook_entity_build_defaults_alter` → tags every entity build with
  `#navigation_plus_entity` metadata and records its view mode in `ViewModeTracker`.
- `hook_element_info_alter` → routes `status_messages` pre-render through `EditModeHtmlMessages`.
- `hook_theme_registry_alter` → ensures the module's navigation/top_bar preprocess runs last and
  enables the `twig_events` `use_twig_events` opt-in per theme hook.

## Edit flow in one paragraph

Entering Edit Mode sets the `navigationMode` cookie; `ModeState`/`NavigationPlusUi::getMode()` read
it. `load_editable_page` re-renders the page against the `tempstore_plus` copy of the entity with
tool/field wrappers; tools mutate the tempstore copy; the top bar's **Save** commits the tempstore
(via `navigation_plus_save_outside_workspace()` so it honours Workspaces) and **Discard** drops it.
Media drag-uploads and block-in-isolation edits reuse the same AJAX replace mechanism.
