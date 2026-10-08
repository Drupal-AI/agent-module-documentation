Provides the jQuery UI Touch Punch shim as the Drupal asset library `jquery_ui_touch_punch/touch-punch` so jQuery UI mouse widgets respond to touch on mobile devices.

---

`jquery_ui_touch_punch` bridges jQuery UI's mouse-based interactions (draggable, droppable, sortable, slider, resizable, selectable) to touch events, so they work on phones and tablets. jQuery UI's interactions listen for `mousedown`/`mousemove`/`mouseup`, which touch devices do not fire the same way; the Touch Punch shim monkey-patches jQuery UI to translate touch events into simulated mouse events. This module declares that shim as the Drupal asset library `jquery_ui_touch_punch/touch-punch` (which depends on `jquery_ui/core`) for themes and modules that still rely on jQuery UI. Unlike the pure widget shims, it needs the external `politsin/jquery-ui-touch-punch` package installed (served from `/libraries/jquery-ui-touch-punch/jquery.ui.touch-punch.min.js`). The module has no configuration, routes, or permissions — only a help page. jQuery UI is End-of-Life; treat this as a compatibility bridge and plan a modern replacement for new work.

---

- Make jQuery UI draggable elements respond to touch drags on mobile and tablet browsers.
- Enable touch reordering for jQuery UI sortable lists on touch devices.
- Make jQuery UI slider handles draggable by finger on phones/tablets.
- Make jQuery UI resizable handles work under touch input.
- Enable touch support for jQuery UI droppable/selectable interactions.
- Fix a contrib or custom module whose drag-and-drop UI works with a mouse but not on touch screens.
- Attach the shim only on pages that host jQuery UI interactions, keeping other pages lean.
- Add the library as a dependency of your own `*.libraries.yml` alongside your jQuery UI interaction library.
- Pair with `jquery_ui_slider` so range/value sliders are usable on mobile.
- Pair with `jquery_ui_resizable` so resizable panels are usable on mobile.
- Provide touch support for a legacy admin UI during a phased migration off jQuery UI.
- Support a Webform or custom widget that uses jQuery UI drag interactions on touch devices.
- Load the shim after jQuery UI core so its monkey-patch is applied to the loaded widgets.
- Serve the Touch Punch JS from a Composer-managed external library path (`/libraries/jquery-ui-touch-punch/`) rather than vendoring it by hand.
- Give agents/tools a stable library name to attach when a task requires touch-enabled jQuery UI interactions.
- Keep touch behavior consistent across Drupal 9.2, 10, 11, and 12.
- Read the module's help page for the deprecation background and change-record link before committing to jQuery UI.
