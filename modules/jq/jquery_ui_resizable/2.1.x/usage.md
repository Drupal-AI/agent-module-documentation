Provides the deprecated-from-core jQuery UI Resizable interaction as the Drupal asset library `jquery_ui_resizable/resizable`.

---

`jquery_ui_resizable` is a tiny compatibility shim. Drupal core removed the bundled jQuery UI asset libraries (they are deprecated and unmaintained upstream), so any theme or module that still calls `.resizable()` or referenced the old `core/jquery.ui.resizable` library needs another source for those assets. Enabling this module (which depends on the `jquery_ui` base module) makes the library `jquery_ui_resizable/resizable` available; attach it via a render array's `#attached[library]` or list it as a dependency in your own `*.libraries.yml`. The module ships no PHP, routes, permissions, configuration, or services — the base `jquery_ui` module declares the library and serves the JS/CSS (jQuery UI 1.13.2) on its behalf. Note jQuery UI is End-of-Life; treat this as a migration bridge and plan a modern replacement (e.g. the CSS `resize` property or a maintained library) for new work.

---

- Restore drag-to-resize handles on an existing theme/module that broke after upgrading to a Drupal core version without bundled jQuery UI.
- Replace a deprecated `core/jquery.ui.resizable` library reference with `jquery_ui_resizable/resizable` in a custom module.
- Replace a deprecated `core/jquery.ui.resizable` reference in a custom or contrib theme's `*.libraries.yml`.
- Attach the resizable library to a specific render array so the interaction loads only on pages that need it.
- Provide the resizable assets required by a contrib module that still depends on jQuery UI Resizable.
- Make a custom admin panel, preview pane, or `<div>` user-resizable via drag handles.
- Add resizable handles to a textarea or embedded editor container.
- Constrain resizing with `minWidth`/`maxWidth`/`aspectRatio`/`containment` via jQuery UI's own JS API after attaching the library.
- Wire `resize`/`stop` events to persist a panel's dimensions or re-layout dependent elements.
- Style the resize handles with the bundled base theme CSS (`resizable.css`) that ships with the library.
- Keep a legacy resizable UI working during a phased migration off jQuery UI.
- Support a contrib module (e.g. an image/layout tool) whose JS expects the jQuery UI resizable code to be present.
- Provide resizable assets to a JavaScript behavior (`Drupal.behaviors`) that initializes resizing on `.js-resizable` elements.
- Load the resizable interaction alongside other jQuery UI shims (datepicker, slider) that share the same `jquery_ui` base dependency.
- Ensure resizable handles render consistently across Drupal 9.2, 10, and 11.
- Combine with `jquery_ui_touch_punch` so resize handles work on touch devices.
- Ship a lightweight dependency (only `drupal/jquery_ui`) rather than re-vendoring jQuery UI assets in your own project.
- Give agents/tools a stable library name to attach when a task requires a jQuery UI resizable element on a Drupal page.
