<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Translation Deployments (custom_translation_deployments) — agent index

Register **synthetic locale "projects"** so custom `.po` interface-translation files placed in the
site's translations directory are imported automatically on a locale update — a way to **deploy
translation overrides with your code**. Version **2.0.3** (doc dir `2.x`).

- **The hooks, the mechanism, the file/naming convention, and the deploy workflow** →
  [api/hooks.md](api/hooks.md)

## What it actually is

- Requires only core **`locale`** (`custom_translation_deployments.info.yml`,
  `dependencies: - drupal:locale`). Core requirement `^8 || ^9 || ^10 || ^11`. GPL-2.0-or-later.
- **No routes, no controllers, no forms, no services, no permissions, no Drush commands, no
  config, no config schema, no plugins, no entities.** All logic lives in
  `custom_translation_deployments.module` (three hook implementations) plus a documented hook in
  `custom_translation_deployments.api.php`.
- It does **not** fetch, read, or write any file itself. It only injects project metadata into
  core locale's project list/storage; core's locale translation-update machinery does the actual
  `.po` discovery and import.

## Mechanism (from `custom_translation_deployments.module`)

- `custom_translation_deployments_cache_flush()` (`hook_cache_flush`): `invokeAll()`s
  `custom_translation_deployments_files`, tags each returned item with the constant
  `CUSTOM_TRANSLATION_DEPLOYMENTS_DATA_KEY` (`is_custom_translation_deployment_object`), and writes
  it into the `locale.project` storage (`LocaleProjectStorageInterface::set()`). It refuses to
  overwrite an existing project that it does not own (the ownership flag guard).
- `custom_translation_deployments_locale_translation_projects_alter(&$projects)`
  (`hook_locale_translation_projects_alter`): merges the same items into the `$projects` array
  passed to locale so they appear as translatable projects during an update.
- `custom_translation_deployments_custom_translation_deployments_files()`: the module's own default
  implementation, providing one project `name: project_specific`, `version: custom`,
  `project_type: module`, `core: 8.x`, `status: 1`, and a `server_pattern` on `ftp.drupal.org`.
- `hook_custom_translation_deployments_files()` (documented in `.api.php`): other modules return an
  array of items (`name`, `project_type`, `core`, `version`, `server_pattern`, `status`) to have
  their own file patterns imported.

## Naming / workflow

- Default file: `project_specific-custom.LANGUAGE.po` in the configured translations directory
  (locale's `translation.path`, e.g. `PROJECT_ROOT/translations`).
- Hook-provided example: `name: custom`, `version: mycompany` → `custom-mycompany.LANGUAGE.po`.
- Deploy step: keep the `.po` files in version control and run `drush locale:update` so core
  imports them alongside contrib translations. See [api/hooks.md](api/hooks.md).
