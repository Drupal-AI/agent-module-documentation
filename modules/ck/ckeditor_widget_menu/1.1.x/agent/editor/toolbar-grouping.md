<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Grouping CKEditor toolbar buttons into a dropdown

`ckeditor_widget_menu` adds one toolbar item, `widgetMenu`, that turns the buttons to its right
(up to the next `|`) into a single labelled dropdown. It is a layout aid only — it changes no
stored markup and produces no output at display time.

## CKEditor 5 (Drupal 10/11) — how to configure
1. Enable the module. Edit the text format at
   `admin/config/content/formats/manage/<format>` (needs the **administer filters** permission).
2. In the CKEditor 5 toolbar configuration, drag the **Widget Menu** button (`widgetMenu`) into the
   active toolbar.
3. Immediately to its right, place the buttons you want hidden inside the dropdown, then end the run
   with a `|` separator (or let it run to the end of the toolbar).
4. Save. On any editor using this format, those buttons disappear from the flat toolbar and appear
   under a single "Widget Blocks" dropdown.

### The exact rule (from `hook_editor_js_settings_alter()`)
- Only editors whose toolbar `items` contains `widgetMenu` are touched.
- The grouped set = items **strictly between** `widgetMenu` and the **first `|` separator after it**;
  if no separator follows, everything to the end of the toolbar is grouped.
- Those items are spliced out and replaced by one nested dropdown item:
  `{ type: 'button', label: 'Widget Blocks', icon: <inline SVG>, items: [ ...grouped items... ] }`.
- The `widgetMenu` item itself remains at its position; the dropdown is inserted right after it.
- Consequence: put `widgetMenu` **before** the group you want collapsed, and terminate the group
  with `|`. Buttons left of `widgetMenu`, or after the terminating `|`, stay on the flat toolbar.

The CKEditor 5 JS plugin shipped by the module is an empty `Plugin` subclass (only `pluginName`);
the dropdown is produced by CKEditor 5's native toolbar consuming the nested `items` array. There
is no per-format settings form and no config schema.

## CKEditor 4 (legacy, still supported)
- Requires the contrib **CKEditor 4** module and the external npm library
  `ckeditor-widgetmenu` installed at `/libraries/widget_menu/` (verify `/libraries/widget_menu/
  plugin.js`). Icon at `/libraries/widget_menu/icons/widget_menu.png`.
- Add the **Widget Menu** button to a toolbar **Group**; every button in that group is moved into
  the dropdown. The `@CKEditor4To5Upgrade` plugin migrates the CKE4 `widget_menu` button to the
  CKE5 `widgetMenu` item automatically.

## Operational checks
- **Keyboard operability** — a grouped widget is only reachable through the dropdown, so confirm the
  dropdown is in the tab order and opens/navigates/closes by keyboard; otherwise keyboard-only
  editors lose every grouped widget. (Behaviour comes from CKEditor 5 core toolbar, not this module.)
- **Consistency across formats** — a widget grouped on one text format but loose on another reads to
  editors as "missing." Apply the same grouping to every format that offers those widgets.
- **No effect if `widgetMenu` is absent** — the hook is a no-op for formats that don't include the
  button, so enabling the module changes nothing until you edit a toolbar.
