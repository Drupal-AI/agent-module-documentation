<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin starter template

`ckeditor5_plugin_starter_template/` inside the module is a scaffold for building a **new module**
that provides a custom CKEditor 5 plugin. It is not itself a module (its info file is named
`MODULE_NAME.change-this-to-info.yml` specifically so Drupal does not discover it). You copy its
contents into the root of your own module and rename the `MODULE_NAME.*` files.

## What it contains

- `package.json` — yarn scripts `build` (`webpack`) and `watch` (`webpack --mode development --watch`);
  dev dependencies pin `ckeditor5` (~45.2.2 at 2.0.x), `webpack`, `webpack-cli`, `terser-webpack-plugin`.
- `webpack.config.js` — loops over every subdirectory of `js/ckeditor5_plugins/`, treating each as a
  separate plugin, and builds `<dir>/src/index.js` to `js/build/<dir>.js` as a UMD bundle under the
  `CKEditor5` global. Uses `DllReferencePlugin` against CKEditor 5's dll manifest so editor internals
  are not re-bundled. `--mode development` skips minification and is not for distribution.
- `MODULE_NAME.change-this-to-info.yml` — rename to `<module>.info.yml`. Declares `package: CKEditor 5`
  and `dependencies: [drupal:ckeditor5]`.
- `MODULE_NAME.ckeditor5.yml` — rename to `<module>.ckeditor5.yml`. The Drupal-side plugin definition:
  the `ckeditor5.plugins` list (e.g. `demoPlugin.SimpleBox`, matching the JS export), and the `drupal`
  block (label, `library`, `admin_library`, `toolbar_items`, and `elements` — each allowed tag AND each
  tag+attribute must be listed separately, e.g. `<h2>` and `<h2 class="simple-box-title">`).
- `MODULE_NAME.libraries.yml` — rename to `<module>.libraries.yml`. Defines the `demobox` library
  (loads `js/build/demoPlugin.js`, depends on `core/ckeditor5`) and an `admin.demobox` CSS library.
- `js/ckeditor5_plugins/demoPlugin/` — a complete working demo plugin (SimpleBox), based on CKEditor's
  block-widget tutorial with extra Drupal-oriented comments:
  - `src/index.js` — the required entry point; exports the discoverable plugin(s) (`export default { SimpleBox }`).
  - `src/simplebox.js` — the glue plugin; `static get requires()` pulls in editing + UI.
  - `src/simpleboxediting.js`, `src/simpleboxui.js`, `src/insertsimpleboxcommand.js` — model/schema/
    conversion, toolbar UI, and the insert command.
  - `icons/simpleBox.svg`, `css/demobox.admin.css`.
- `js/build/` — output folder (commit the production `yarn build` output, not `yarn watch` output).

## Workflow

1. Copy the template contents into your module root; rename the `MODULE_NAME.*` files to your module name.
2. Put plugin source in `js/ckeditor5_plugins/<pluginDir>/src/`, with an `index.js` exporting the plugin(s).
   (The `src/index.js` location is a convention of this template's `webpack.config.js`, not a CKEditor/Drupal
   requirement — change it in the config if desired.)
3. `yarn install` (first run is slow), then `yarn build` (production) or `yarn watch` (dev, unminified).
   Output lands in `js/build/<pluginDir>.js`.
4. Wire it up in `<module>.ckeditor5.yml` (plugin id + drupal block) and `<module>.libraries.yml`.

This is a local/CLI development workflow — no Drush command, no runtime code in the ckeditor5_dev module
drives it. The template just gives you a known-good starting point.
