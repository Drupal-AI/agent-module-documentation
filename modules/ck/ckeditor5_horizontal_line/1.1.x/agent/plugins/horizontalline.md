<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Horizontal Line CKEditor 5 plugin

Makes a "Horizontal Line" button available in CKEditor 5 that inserts an `<hr>` divider.

## Install / enable
- `composer require drupal/ckeditor5_horizontal_line` then `drush en ckeditor5_horizontal_line -y`.
- Requires core `ckeditor5`. No further install steps (empty `.module`, no install hooks, no config).

## The plugin definition
File: `ckeditor5_horizontal_line.ckeditor5.yml`, key `ckeditor5_horizontal_line_horizontalline`:
- `ckeditor5.plugins: [horizontalLine.HorizontalLine]` — loads the upstream CKEditor 5 plugin.
- `drupal.label: Horizontal Line`; `library: ckeditor5_horizontal_line/horizontalline`;
  `admin_library: ckeditor5_horizontal_line/admin.horizontalline`.
- `drupal.toolbar_items.horizontalline.label: Horizontal Line` — the draggable toolbar button id is
  `horizontalline`.
- `drupal.elements: false` — the plugin registers **no** additional allowed-HTML elements with
  Drupal's CKEditor 5 filter integration.

## Libraries (`ckeditor5_horizontal_line.libraries.yml`)
- `horizontalline`: JS `js/build/horizontal-line.js` (`minified: true`, `preprocess: false`) + theme
  CSS `css/horizontal-line.css`; depends on `core/ckeditor5`.
- `admin.horizontalline`: `css/horizontal-line.admin.css` — sets the toolbar-button background icon
  (`.ckeditor5-toolbar-button-horizontalline` → `icons/marker.svg`).

## JS source vs. build
- `js/ckeditor5_plugins/horizontalline/src/index.js` simply re-exports upstream `HorizontalLine`
  from `@ckeditor/ckeditor5-horizontal-line`.
- `js/build/horizontal-line.js` is the compiled webpack bundle actually loaded; it also registers the
  translatable "Horizontal line" string via `CKEDITOR_TRANSLATIONS`.

## Configure a text format
1. Go to `admin/config/content/formats/manage/<format>` (e.g. `full_html`).
2. Ensure the format uses **CKEditor 5**.
3. Drag the horizontal-line icon from Available to the Active toolbar.
4. On a format with "Limit allowed HTML tags and correct faulty HTML" enabled, add `<hr>` to the
   allowed tags — because `elements: false`, the module does not add it for you, so otherwise the
   inserted line is filtered out on save.
5. Save the format. Editors now see the button and inserted lines render as `<hr>`.

## Rendered output & styling
- Output markup is a plain `<hr>`. Front-end styling comes from `css/horizontal-line.css`
  (`.ck-content hr { margin:15px 0; height:4px; background:hsl(0,0%,87%); border:0 }`); in-editor,
  `.ck-editor__editable .ck-horizontal-line { display: flow-root }` fixes rendering next to floats.
- Override these rules in your theme to restyle the divider.

## Operate / uninstall
- No routes, permissions, services or drush commands are added by this module.
- Uninstalling leaves no config or schema behind; remove the button from any format toolbars if you
  want it gone from the UI.
