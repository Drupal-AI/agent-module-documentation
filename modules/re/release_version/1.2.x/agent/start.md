<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Release Version (release_version) — agent index

Reads a version string from a **configurable environment variable** and displays it in the Drupal
**admin toolbar** (and via an optional block). Depends only on core **`toolbar`**. Core requirement
`^8.8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.2.0.

- **The service, config, settings form, block, toolbar hook and the alter** →
  [config/settings.md](config/settings.md)

## What it actually is

- One service **`release_version.provider`** → `Drupal\release_version\ReleaseVersionProvider`
  (`src/ReleaseVersionProvider.php`). `getVersion()` reads the env-var name from
  `release_version.settings:environment_variable_name`, returns `getenv($name)` or the translated
  string `"Version not found"`, then runs `moduleHandler->alter('release_version', $version)`.
- One block plugin **`release_version_version`** (`src/Plugin/Block/VersionBlock.php`, category
  *System*, label *Version*) rendering `#theme => 'release_version_block'` with `#version` from the
  provider.
- `hook_toolbar()` in `release_version.module` adds a toolbar item `version` (cache context
  `user.permissions`) showing the same value. `hook_theme()` registers `release_version_block`
  (template `templates/release-version-block.html.twig`, just `{{ version }}`). `hook_help()`
  provides the help page.
- Settings form `ReleaseVersionSettings` (`src/Form/ReleaseVersionSettings.php`, `ConfigFormBase`)
  at route **`release_version.settings_form`** = `/admin/config/release_version/settings`.
- **No** database tables, `.install`, Drush, config schema, config/install defaults, plugin types,
  submodules, or external libraries. No `composer.json` in the project.

## Config, routes, permissions

- Config object **`release_version.settings`**, single key `environment_variable_name` (string).
  No schema file ships (`provides_config_schema = false`) — the module writes/reads this key directly.
- Route `release_version.settings_form` requires **`access administration pages`** AND the module's
  **`access_release_version_settings`** permission (`release_version.permissions.yml`), `_admin_route: TRUE`.
- Menu link `release_version.settings_form` under `system.admin_config_system`, weight 99
  (`release_version.links.menu.yml`).

## Extending

- Other modules can implement **`hook_release_version_alter(&$version)`** to transform the string
  before display (e.g. prefix the environment, shorten a SHA). See [config/settings.md](config/settings.md).
