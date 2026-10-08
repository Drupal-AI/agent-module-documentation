<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor5 Bootstrap Integration (ckeditor5_bootstrap) — agent index

Three **CKEditor 5 plugins** that let editors author **Bootstrap 5** markup from the toolbar. Package
`CKEditor 5`. Depends on core **`ckeditor5`** and **`editor`**. Core `^11 || ^12`. License
GPL-2.0-or-later. Version 1.0.1. No routes, no permissions, no services, no `.module`/`.install`, no
Drush.

- **The three plugins, their toolbar buttons, allowed-HTML elements, libraries, JS layout** →
  [plugins/widgets.md](plugins/widgets.md)
- **Per-plugin settings (custom config JSON path), config schema, how to customize the button/component lists** →
  [config/settings.md](config/settings.md)

## What it actually is

Declared in `ckeditor5_bootstrap.ckeditor5.yml` (three CKEditor 5 plugin definitions):

- **`ckeditor5_bootstrap_div`** — JS plugin `bootstrapDiv.BootstrapDiv`. Toolbar item `bootstrapDiv`.
  Inserts a `<div>` with classes/id/background image/AOS/data-*/aria- attributes. No PHP class
  (pure JS-configured plugin). Library `ckeditor5_bootstrap/div`.
- **`ckeditor5_bootstrap_table`** — JS plugin `bootstrapTable.BootstrapTable`; PHP class
  `src/Plugin/CKEditor5Plugin/BootstrapTable.php`. Balloon toolbar for table caption + `table-*`
  classes. Library `ckeditor5_bootstrap/table`.
- **`ckeditor5_bootstrap_components`** — JS plugin `bootstrapComponents.BootstrapComponents`; PHP
  class `src/Plugin/CKEditor5Plugin/BootstrapComponents.php`. Inserts prebuilt Bootstrap components
  (accordion, alert, badge, card, carousel, collapse, list group, modal, offcanvas, toast, tooltip,
  popover, tabs). Library `ckeditor5_bootstrap/components`.

Each plugin becomes usable only after an admin drags its button onto a text format's CKEditor 5
toolbar (Admin → Configuration → Content authoring → Text formats and editors). The plugin's
declared `elements` are then added to that format's allowed HTML.

## Provided plugin classes (PHP)

- `BootstrapComponents` (`src/Plugin/CKEditor5Plugin/BootstrapComponents.php`) — extends
  `CKEditor5PluginDefault`, implements `CKEditor5PluginConfigurableInterface` +
  `ContainerFactoryPluginInterface`. Loads component definitions from a JSON file and passes them to
  the JS plugin via `getDynamicPluginConfig()` as `bootstrapComponents.components`. Has a settings
  form (`config_path`).
- `BootstrapTable` (`src/Plugin/CKEditor5Plugin/BootstrapTable.php`) — extends
  `CKEditor5PluginDefault`, implements `ContainerFactoryPluginInterface`. Passes the URL of
  `table_options.json` to the JS via `getDynamicPluginConfig()` as `bootstrapTable.optionsUrl`. Has a
  settings form (`config_path`).
- Bootstrap Div has **no PHP class** — it is configured entirely by the JS bundle and its JSON files.

## Config / schema

- Config schema in `config/schema/ckeditor5_bootstrap.schema.yml`: two mappings keyed
  `ckeditor5.plugin.ckeditor5_bootstrap_components` and `...table`, each with a single string
  `config_path`. Stored inside the editor entity's `settings.plugins`.
- Bundled JSON config (all under `js/ckeditor5_plugins/`): `bootstrapComponents/components_config.json`,
  `bootstrapDiv/bootstrap-config.json`, `bootstrapTable/table_options.json`.

## Build

Compiled bundles live in `js/build/` (`bootstrapDiv.js`, `bootstrapTable.js`, `bootstrapComponents.js`,
`minified: true, preprocess: false`). Source is `js/ckeditor5_plugins/**`; rebuild with
`yarn build` / `npm run build` (webpack). The packaged drupal.org release ships the built files.
Bootstrap's own CSS/JS is **not** bundled — supply it from your theme for authored markup to render.
