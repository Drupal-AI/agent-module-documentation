<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin settings & customizing the class/component lists

The Bootstrap Table and Bootstrap Components plugins expose one setting each — a `config_path`
pointing at a JSON file that drives the dialog. Bootstrap Div has no PHP setting; it is customized by
editing its JSON file and rebuilding. All settings live inside the CKEditor 5 editor entity
(`settings.plugins.<plugin_id>`), edited on the text-format form, not on a module route.

## Config schema
`config/schema/ckeditor5_bootstrap.schema.yml` defines two mappings, each a single string:
- `ckeditor5.plugin.ckeditor5_bootstrap_components` → `config_path`
- `ckeditor5.plugin.ckeditor5_bootstrap_table` → `config_path`

## BootstrapComponents settings (`src/Plugin/CKEditor5Plugin/BootstrapComponents.php`)
- `defaultConfiguration()` → `['config_path' => '']` (empty = use bundled default).
- `buildConfigurationForm()` adds a `config_path` textfield (maxlength 512): "Optional. Absolute path
  (from Drupal root) to a custom JSON config file." Leave empty to use the bundled
  `js/ckeditor5_plugins/bootstrapComponents/components_config.json`.
- `validateConfigurationForm()` — if non-empty, resolves `DRUPAL_ROOT . '/' . ltrim($path,'/')` and
  errors unless the file exists, is readable, and contains valid JSON.
- `resolveConfigPath()` — uses the custom path when set and the file exists/readable; otherwise logs a
  warning (channel `ckeditor5_bootstrap`) and falls back to `getDefaultConfigPath()`
  (`extension.list.module`-derived module path + the bundled JSON).
- `getComponents()` reads the file, `json_decode`s it, injects each top-level key as the entry's `id`,
  and returns the array. `getDynamicPluginConfig()` sends it to JS as
  `bootstrapComponents.components`. Errors/invalid JSON are logged and yield `[]` (no components).

## BootstrapTable settings (`src/Plugin/CKEditor5Plugin/BootstrapTable.php`)
- `defaultConfiguration()` builds an **absolute URL** to the bundled
  `bootstrapTable/table_options.json` via `Url::fromUri('base:' . $module_path . '/…', ['absolute' =>
  TRUE])` and stores it as `config_path` (the JS fetches it by XHR, so it must be absolute).
- Same `config_path` textfield + validation (`file_exists` / `is_readable` / valid JSON) as above.
- `getDynamicPluginConfig()` passes `config_path` to JS as `bootstrapTable.optionsUrl`.

Note: the settings form's `#default_value`/placeholder are same-origin site paths; treat these config
files as trusted editor configuration, editable only by roles that administer text formats.

## Customizing without the settings form (bundled JSON)
- **Div classes / fields:** edit `js/ckeditor5_plugins/bootstrapDiv/bootstrap-config.json`
  (background colors/gradient/opacity, layout classes, AOS options, etc.), then `yarn build`.
- **Components:** edit `js/ckeditor5_plugins/bootstrapComponents/components_config.json` — each
  top-level key is a component id with `label`, `tooltip`, `icon` (from `icons/`), `cardinality`,
  `fields`, and a `template` (`wrapper`/`item` HTML with `{placeholder}` substitution). Add a
  component, rebuild, clear cache. Or point `config_path` at a themed copy (no rebuild).
- **Table options:** edit `js/ckeditor5_plugins/bootstrapTable/table_options.json` (tabs → groups →
  fields; field types `text`/`checkbox` with `saveAs: model|attribute`). The file's own `_readme`
  documents the schema; run `drush cr` after edits (no rebuild needed — it's fetched at runtime).

## Operating notes
- Changing bundled JS/JSON requires `yarn build` (except `table_options.json`, fetched at runtime) and
  `drush cr` so Drupal serves the new assets/aggregates.
- A custom `config_path` that later goes missing/unreadable: Components logs a warning and falls back
  to the bundled default; Table has no fallback (the JS XHR simply gets nothing if the URL 404s).
