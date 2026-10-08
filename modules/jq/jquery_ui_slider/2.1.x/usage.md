Provides the deprecated-from-core jQuery UI Slider widget as the Drupal asset library `jquery_ui_slider/slider`.

---

`jquery_ui_slider` is a tiny compatibility shim. Drupal core removed the bundled jQuery UI asset libraries (they are deprecated and unmaintained upstream), so any theme or module that still calls `.slider()` or referenced the old `core/jquery.ui.slider` library needs another source for those assets. Enabling this module (which depends on the `jquery_ui` base module) makes the library `jquery_ui_slider/slider` available; attach it via a render array's `#attached[library]` or list it as a dependency in your own `*.libraries.yml`. The module ships no PHP, routes, permissions, configuration, or services — the base `jquery_ui` module declares the library and serves the JS/CSS (jQuery UI 1.13.2) on its behalf. Note jQuery UI is End-of-Life; treat this as a migration bridge and plan a modern replacement (e.g. a native `<input type="range">` or a maintained slider) for new work.

---

- Restore a slider control on an existing theme/module that broke after upgrading to a Drupal core version without bundled jQuery UI.
- Replace a deprecated `core/jquery.ui.slider` library reference with `jquery_ui_slider/slider` in a custom module.
- Replace a deprecated `core/jquery.ui.slider` reference in a custom or contrib theme's `*.libraries.yml`.
- Attach the slider library to a specific render array so the widget loads only on pages that need it.
- Provide the slider assets required by a contrib module that still depends on jQuery UI Slider.
- Build a single-handle value slider bound to a hidden form input.
- Build a two-handle range slider for min/max filtering (e.g. price ranges).
- Add a vertical slider control to a custom admin or dashboard widget.
- Wire slider `slide`/`change` events to live-update a displayed value or trigger an AJAX request.
- Style the slider with the bundled base theme CSS (`slider.css`) that ships with the library.
- Keep a legacy range/value UI working during a phased migration off jQuery UI.
- Support a Webform or custom form element that expects the jQuery UI slider JS to be present.
- Provide slider assets to a JavaScript behavior (`Drupal.behaviors`) that initializes sliders on `.js-slider` elements.
- Load the slider widget alongside other jQuery UI shims (datepicker, resizable) that share the same `jquery_ui` base dependency.
- Ensure a slider renders consistently across Drupal 9.2, 10, and 11.
- Combine with `jquery_ui_touch_punch` so slider handles are draggable on touch devices.
- Ship a lightweight dependency (only `drupal/jquery_ui`) rather than re-vendoring jQuery UI assets in your own project.
- Give agents/tools a stable library name to attach when a task requires a jQuery UI slider on a Drupal page.
