<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dark Mode User (dark_mode_user) — agent index

Standalone dark-mode system for Drupal. Sets `data-dmu-mode` (`light`/`dark`) and `data-dmu-source` (`user`/`system`) on the `<html>` element so a theme can style itself; ships **no CSS**. Package `Other`. Core `^11.1`. License GPL-2.0-or-later. Version 1.0.0-beta3. No composer or module dependencies declared (functionally uses core **`user`** — `user.data`).

- **Global settings form, per-user override, config object, JS libraries, and the data attributes** →
  [config/settings.md](config/settings.md)

## What it actually is

- One admin form: `SettingsForm` (`src/Form/SettingsForm.php`, form id `dark_mode_user_settings`), a `ConfigFormBase` editing config object **`dark_mode_user.settings`** at route **`dark_mode_user.settings`** → `/admin/config/user-interface/dark-mode-user`, permission **`administer site configuration`**. Menu link under *Configuration → User interface* (`dark_mode_user.links.menu.yml`).
- One hook class: `DarkModeUserHooks` (`src/Hook/DarkModeUserHooks.php`, OOP `#[Hook]` attributes). Adds a "Dark mode user settings" section to the user edit form, saves the choice to `user.data`, attaches the library on every page, and injects the effective mode into `drupalSettings`.
- One permission: **`access dark mode user`** (`dark_mode_user.permissions.yml`) — gates the per-user override.
- Two JS libraries (`dark_mode_user.libraries.yml`): `dark-mode-user.anti-flicker` (header, reads `drupalSettings.dark_mode_user`, sets the attributes before paint) and `dark-mode-user` (`Drupal.behaviors.darkModeUser`, listens for OS `prefers-color-scheme` changes).
- Config schema in `config/schema/dark_mode_user.schema.yml`; install default `system_default: system` (`config/install/dark_mode_user.settings.yml`).
- No entities, no plugins, no services (hook class is registered by attribute discovery), no Drush.

## Modes

`light`, `dark`, `system` (follow OS/browser). The per-user form adds `global` = "use the site default". Anonymous users and users without a stored preference get the config value `system_default`.
