<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
jQuery UI Selectable makes the deprecated-in-core jQuery UI Selectable widget available again as a Drupal asset library, for themes and modules that still need `$.selectable()`.

---

jQuery UI was removed from Drupal core's actively-maintained libraries, so each interaction is
now re-provided by the `jquery_ui` contrib module plus a small per-widget companion module.
This module is that companion for **Selectable**: it ships only an `.info.yml` (no JS, no config,
no PHP) and depends on `jquery_ui` (`^1.7`). Enabling it lets the base `jquery_ui` module — via
its `hook_library_info_alter`, driven by `jquery_ui.libraries.data.json` — declare the asset
library **`jquery_ui_selectable/selectable`** (jQuery UI 1.13.2: `selectable-min.js` +
`selectable.css`, depending on `core/jquery`, `jquery_ui/mouse`, `jquery_ui/widget`). Your theme
or module then attaches `jquery_ui_selectable/selectable` and calls `.selectable()` to let users
box/lasso-select a group of DOM elements. There is no admin UI, no permissions, and no settings —
its entire job is to expose the library namespace.

---

- Re-enable the jQuery UI Selectable widget after core deprecated jQuery UI.
- Let users drag a selection box (lasso) to select multiple list items.
- Ctrl/Shift-click to select several elements in a custom widget.
- Build a multi-select grid or gallery where items are selected by dragging.
- Provide the `selectable` dependency required by another contrib module or theme.
- Add rubber-band selection to a dashboard of cards or tiles.
- Attach `jquery_ui_selectable/selectable` from a custom module's render array `#attached`.
- Attach the library from a theme's `*.libraries.yml` dependency list.
- Implement a "select all in region" interaction using the widget's events.
- Support a bulk-action UI where editors marquee-select rows.
- Keep a legacy front-end feature working during a Drupal 9→11 upgrade.
- Pair with jQuery UI Sortable/Draggable companion modules for richer interactions.
- Fire `selected`/`unselected` callbacks to sync selection state to a form field.
- Pin the jQuery UI Selectable JS to the vendored 1.13.2 version shipped by `jquery_ui`.
- Avoid loading all of jQuery UI when you only need selectable behaviour.
