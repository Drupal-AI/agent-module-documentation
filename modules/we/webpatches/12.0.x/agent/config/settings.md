<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Web Patches settings

Form at **`/admin/config/development/webpatches`** (route `webpatches.settings`, the module's
`configure` route, menu link under `system.admin_config_development`). Permission
**`administer webpatches`** (`restrict access: TRUE`). Implemented by
`Form\WebpatchesSettingsForm` (extends `ConfigFormBase`, form id `webpatches_settings_form`,
editable config `webpatches.settings`), which injects `webpatches.collector` to resolve and
validate the project root and custom file path.

![Web Patches settings form](../../../../../../../screenshots/webpatches/12.0.x/settings-form.png)

## Config object `webpatches.settings`

Schema: `config/schema/webpatches.schema.yml` (`type: config_object`). Install defaults:
`config/install/webpatches.settings.yml`.

| Key | Type | Default | Meaning |
| --- | --- | --- | --- |
| `sources.root_composer` | boolean | `true` | Read `extra.patches` of the root `composer.json`. |
| `sources.patches_composer` | boolean | `true` | Read the Composer Patches patches file (`extra.composer-patches.patches-file` v2, default `patches.json`, or top-level `extra.patches-file` v1). |
| `sources.custom_file` | boolean | `false` | Read the custom patches file at `custom_file_path`. |
| `sources.dependency_packages` | boolean | `true` | Read patches contributed by installed dependency packages, filtered by the allowlist/ignore rules. |
| `custom_file_path` | string | `''` | Absolute, or relative to the Composer project root. Bare `{"patches": {…}}` or a `composer.json`-shaped file. |
| `only_installed_packages` | boolean | `true` | Hide patches targeting packages not installed on this site. |

The source keys map to the `PatchesCollectorInterface` constants `SOURCE_ROOT`,
`SOURCE_PATCHES_FILE`, `SOURCE_CUSTOM`, `SOURCE_DEPENDENCIES`.

## Form behavior

- The four source checkboxes live under a `#tree` fieldset **Patch declaration sources**.
- **Custom patches file path** is shown (via `#states`) only when the Custom patches file source is
  checked. Its description interpolates the resolved project root from
  `PatchesCollector::getProjectRoot()`.
- `validateForm()` — when the custom source is enabled and a path is given, resolves it (absolute as
  given, otherwise relative to project root) and sets an error if the file does not exist
  (`is_file`).
- `submitForm()` — writes each source checkbox, the trimmed `custom_file_path`, and
  `only_installed_packages` back to `webpatches.settings`.

Changing sources or `only_installed_packages` changes exactly what the report at
`/admin/reports/webpatches` lists. `only_installed_packages` only affects the displayed Patches and
Ignored lists — the `patches.lock.json` sync comparison always uses the full declared set.

## Enable

Enable with `drush en webpatches` (or via `recipes/default/recipe.yml`). No dependencies beyond
Drupal core `^11.4 || ^12`. After enabling, grant `view webpatches report` and
`administer webpatches` only to trusted administrator roles — both are `restrict access` because the
report reveals server file paths and installed package versions.
