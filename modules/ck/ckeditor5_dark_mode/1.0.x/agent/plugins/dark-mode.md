<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dark Mode CKEditor 5 plugin

## Install & enable
1. `drush en ckeditor5_dark_mode` (core `ckeditor5` is a dependency).
2. Go to `/admin/config/content/formats`, edit a text format that uses the CKEditor 5 editor, and drag the "Dark Mode" button into the Active toolbar. Save. No further configuration exists.

## Plugin definition (`ckeditor5_dark_mode.ckeditor5.yml`)
Single plugin id `ckeditor5_dark_mode_dark_mode`:
- `ckeditor5.plugins: [darkMode.Dark]` — the JS plugin exported under the `darkMode` package.
- `drupal.label: Dark Mode`.
- `drupal.library: ckeditor5_dark_mode/dark_mode` — loaded into the editor.
- `drupal.admin_library: ckeditor5_dark_mode/dark_mode.admin` — loaded on the text-format admin form.
- `drupal.toolbar_items.darkMode.label: Dark Mode` — makes the button draggable in the toolbar UI.
- `drupal.elements: false` — the plugin registers NO HTML elements/attributes; it never alters, adds, or filters stored markup.

## Libraries (`ckeditor5_dark_mode.libraries.yml`)
- `dark_mode`: JS `js/build/darkMode.js` (`preprocess: false, minified: true`) + CSS `css/dark.css`; depends on `core/ckeditor5`.
- `dark_mode.admin`: CSS `css/dark.admin.css` only.

## JS behavior
Source in `js/ckeditor5_plugins/darkMode/src/` (bundled to `js/build/darkMode.js` via `webpack.config.js`):
- `index.js` exports `{ Dark }` so CKEditor 5 discovers the plugin.
- `dark.js` — class `Dark extends Plugin`; `static get requires()` returns `[DarkUI]`.
- `darkui.js` — class `DarkUI extends Plugin`. In `init()` it registers a `ButtonView` component named `darkMode` via `editor.ui.componentFactory.add`. It captures `editorRegion = editor.sourceElement.nextElementSibling` and keeps a local `state` (0/1). On the button's `execute` event it toggles the `ck-dark` class on `editorRegion` and swaps the button label/icon between "Dark Mode" (`icons/dark.svg`) and "Light Mode" (`icons/light.svg`).

State is a plain JS variable, so the toggle is per-page-load and per-editor; nothing is persisted client- or server-side. The effect is purely presentational: adding/removing the `ck-dark` class, which `css/dark.css` styles.

## CSS
- `css/dark.css` — the dark styling applied when `.ck-dark` is present on the editing region (theme layer).
- `css/dark.admin.css` — small overrides for the admin/toolbar context; `css/demobox.admin.css` is a project-page demo asset (not attached to a Drupal library).

## Notes for agents
- Nothing to configure beyond adding the toolbar button. No settings form, route, permission, service, hook, or config entity.
- `elements: false` means adding this button does not expand a format's allowed HTML and cannot introduce new stored markup.
