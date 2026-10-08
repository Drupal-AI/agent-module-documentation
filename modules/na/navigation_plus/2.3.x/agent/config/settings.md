<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Navigation + — install & configuration

## Install / enable

Drupal 11 only (`core_version_requirement: ^11`). Requires core `navigation` plus contrib
`twig_events` and `tempstore_plus` (Composer: `drupal/twig_events:^1.0`,
`drupal/tempstore_plus:^1.0`). `composer require drupal/navigation_plus` then
`drush en navigation_plus`. Suggests `drupal/edit_plus` and `drupal/lb_plus` — on most sites this
module is pulled in *by* those, not installed alone. Install adds a `map` base field
`navigation_plus_settings` to the **user** entity (`navigation_plus_install()` →
`_navigation_plus_add_settings_field()` in `navigation_plus.install`) and initializes it to `[]`
for existing users.

## Site settings form (accent colors only)

- Route `navigation_plus.settings` → `Form/SettingsForm` (a `ConfigFormBase`), path
  **`/admin/config/content/plus-suite`**, permission `administer Navigation + configuration`. Menu
  link `navigation_plus.settings` ("Plus Suite") under *Configuration → Content*.
- Writes config object **`navigation_plus.settings`**, key `colors` (a mapping `main` /
  `secondary` / `highlight`, all `#type => color` hex). Defaults ship in
  `config/install/navigation_plus.settings.yml` (`#347efe` / `#347efe` / `#16bd00`).
- `NavigationPlusUi::setThemeColors()` emits these as CSS custom properties
  (`--navigation-plus-{main,secondary,highlight}-color`) into a `<style>` tag on the navigation
  when any mode is present. That is the *entire* function of this settings page — it does not
  configure modes or tools.
- Schema: `config/schema/navigation_plus.schema.yml` types `navigation_plus.settings` (a
  `config_object` with a `colors` sequence).

## Per-bundle mode configuration (the real configuration surface)

Which modes are available, and how a bundle behaves, is stored as **third-party settings** in the
`navigation_plus` namespace on the *bundle* config entity (e.g. `node.type.*`,
`block_content.type.*`). Schema key `navigation_plus.bundle.options` defines:

- `initial_mode` (string) — the mode a bundle opens in after its first save (`none` = normal
  Drupal). Set on the bundle edit form.
- `status` (sequence of bool, keyed by mode plugin id) — which modes are enabled for the bundle.
- `modes` (sequence, keyed by mode id) — per-mode config, e.g. Edit Mode's `default_tool`.

`Form/BundleEditFormAlter` (service `navigation_plus.form_alter.bundle_edit`, wired from
`hook_form_alter`) injects a **"Navigation +"** details group into any bundle edit form whose
entity type has the `*.third_party.navigation_plus` schema. It shows an *Initial mode* radio and a
table of modes with **Enable / Configure / Disable** operation links. Those links hit:

- `navigation_plus.mode.enable` / `.disable` — `Controller/ModeController::enable|disable`, which
  flip `status[$plugin_id]` on the bundle entity and save it (via
  `navigation_plus_save_outside_workspace()` so it lands on live config, not a workspace).
- `navigation_plus.mode.configure` — `Form/ModeConfigureForm`, a modal that renders the mode
  plugin's own `buildConfigurationForm()` (Edit Mode exposes a **Default tool** radio, saved to
  `modes.edit.default_tool`; see `Plugin/Mode/Edit`).

All three require `configure toolbar plus modes`.

## Per-user preferences

Stored on the current user's `navigation_plus_settings` map field via `EditorSettings`
(`navigation_plus.editor_settings`), namespaced by the owning module. Endpoints (all permission
`use toolbar plus edit mode`, all acting only on `$this->currentUser()`):

- `navigation_plus.settings.save_setting` → `Controller/Settings::saveSetting($namespace,$key,$value)`
  — generic namespaced pref; reachable from JS `Drupal.NavigationPlus.saveSetting()`.
- `navigation_plus.settings.save_user_hotkey` → `Settings::saveHotkey($tool_id,$hotkey)` — assign a
  keyboard shortcut to a tool (validates `hotkey` against `^[a-z0-9]+$`, tool must exist or be
  `show_all`).
- `navigation_plus.settings.remove_media_file_association` → `Settings::removeMediaFileAssociation()`.

Purely visual client-only toggles are kept in the browser's `localStorage`, not here (see the
`EditorSettings` class docblock).
