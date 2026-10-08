<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap CKEditor 5 widgets (bootstrapDiv, bootstrapTable, bootstrapComponents)

Source of truth: `ckeditor5_bootstrap.ckeditor5.yml` (plugin defs + allowed elements),
`ckeditor5_bootstrap.libraries.yml` (asset libraries), `js/ckeditor5_plugins/**` (JS),
`src/Plugin/CKEditor5Plugin/*.php` (PHP for table + components).

## Enable / operate

1. `drush en ckeditor5_bootstrap -y && drush cr`. (No permissions or menu links are added.)
2. Admin → Configuration → Content authoring → **Text formats and editors** → edit a format that
   uses CKEditor 5 (e.g. *Full HTML*).
3. Drag the desired buttons — **Div attribute**, **Table**, **Bootstrap Components** — from the
   available items onto the toolbar. This is what activates each plugin and adds its allowed HTML.
4. Save the format. Optionally open each plugin's settings (gear/vertical tab) to set a custom
   config JSON path — see [../config/settings.md](../config/settings.md).

Bootstrap CSS/JS is not shipped by this module; add it via your front-end theme so the saved markup
(and interactive components like modal/tooltip/collapse) works on the rendered page.

## The three plugins

### bootstrapDiv (toolbar item `bootstrapDiv`, library `ckeditor5_bootstrap/div`)
JS plugin `bootstrapDiv.BootstrapDiv` (`js/ckeditor5_plugins/bootstrapDiv/`, built to
`js/build/bootstrapDiv.js`). No PHP class. Inserts a `<div>` and opens a panel/dialog to pick
Bootstrap classes (list from `bootstrapDiv/bootstrap-config.json`), an id, a background image
(URL/position/size), AOS animation attributes, and freeform custom attributes. Model attributes
`divClass` and `divAttrs` (JSON) are written by `bootstrapdiv-editing.js` /
`bootstrapdivcommands-extra.js` and downcast to real DOM attributes.

**Allowed HTML added to the format:** `<div class id style data-* aria-*>`.

### bootstrapTable (toolbar item `bootstrapTable`, library `ckeditor5_bootstrap/table`)
JS plugin `bootstrapTable.BootstrapTable`; PHP class `BootstrapTable`. Shows a balloon toolbar over
a table; the dialog is built from `bootstrapTable/table_options.json`, whose absolute URL the PHP
passes to JS as `bootstrapTable.optionsUrl` (see settings doc). Toggles `table-*` classes and
manages a `<caption>`. Model attributes `bsTableClasses`, `bsTableCaption`, `bsTableDataAttrs`
(`modifybootstraptablecommand.js`, `bootstraptable-editing.js`). Works alongside core's Table
plugin (this only decorates the table).

**Allowed HTML added:** `<table class>` and `<caption>`. Also loads
`css/ckeditor5_bootstrap_table.css`.

### bootstrapComponents (toolbar item `bootstrapComponents`, library `ckeditor5_bootstrap/components`)
JS plugin `bootstrapComponents.BootstrapComponents`; PHP class `BootstrapComponents`. Reads component
definitions from `bootstrapComponents/components_config.json` and passes them to JS as
`bootstrapComponents.components` (object keyed by id, id also injected into each entry). Each
component defines a label/icon/fields/template; the editor fills fields and the template HTML is
inserted. Bundled components: accordion, alert, badge, card, carousel, collapse, list group, modal,
offcanvas, toast, tooltip, popover, tabs.

**Allowed HTML added:** `<div class id style role tabindex aria-* data-*>`, `<span class>`,
`<h2 class>`, `<button class type tabindex aria-* data-*>`, `<a class href role tabindex aria-*
data-*>`, `<img class src alt>`, `<ul class>`, `<ol class>`, `<li class>`, `<nav class aria-label>`,
`<p class>`.

## Allowed-HTML note (operational)
These `elements` are only added to a text format after an admin explicitly adds the button, and they
apply only to that format. They intentionally widen the format's allowed tags/attributes so Bootstrap
components render — plan which formats get these buttons the same way you would decide who may use
*Full HTML*. Grant the buttons only to formats reserved for trusted authoring roles.

## JS build layout
- Entry: `js/ckeditor5_plugins/index.js` (exports `BootstrapDiv`, `BootstrapTable`; the components
  plugin has its own entry `bootstrapComponents/index.js`). Webpack config `webpack.config.js`.
- Per-plugin `src/` holds editing (model↔view converters), ui (toolbar/balloon), command, formview,
  and panelview modules. Compiled output in `js/build/*.js` is what Drupal loads (`minified: true`).
- Admin CSS: `ckeditor5_bootstrap/admin` (`css/ckeditor5_bootstrap.admin.css`), a dependency of each
  plugin library.
