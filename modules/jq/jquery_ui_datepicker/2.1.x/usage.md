Provides the deprecated-from-core jQuery UI Datepicker widget as the Drupal asset library `jquery_ui_datepicker/datepicker`.

---

`jquery_ui_datepicker` is a tiny compatibility shim. Drupal core removed the bundled jQuery UI asset libraries (they are deprecated and unmaintained upstream), so any theme or module that still calls `.datepicker()` or referenced the old `core/jquery.ui.datepicker` library needs another source for those assets. Enabling this module (which depends on the `jquery_ui` base module) makes the library `jquery_ui_datepicker/datepicker` available; attach it via a render array's `#attached[library]` or list it as a dependency in your own `*.libraries.yml`. The module ships no PHP, routes, permissions, configuration, or services — the base `jquery_ui` module declares the library and serves the JS/CSS (jQuery UI 1.13.2) on its behalf. Note jQuery UI is End-of-Life; treat this as a migration bridge and plan a modern replacement (e.g. a native `<input type="date">` or a maintained date-picker) for new work.

---

- Restore a datepicker calendar on an existing theme/module that broke after upgrading to a Drupal core version without bundled jQuery UI.
- Replace a deprecated `core/jquery.ui.datepicker` library reference with `jquery_ui_datepicker/datepicker` in a custom module.
- Replace a deprecated `core/jquery.ui.datepicker` reference in a custom or contrib theme's `*.libraries.yml`.
- Attach the datepicker library to a specific render array so the calendar loads only on pages that need it.
- Provide the datepicker assets required by a contrib module that still depends on jQuery UI Datepicker.
- Add an inline calendar to a `<div>` on a custom admin form or report page.
- Add a pop-up calendar to a plain text input in a custom form without pulling in an unrelated widget library.
- Enable min/max date ranges, disabled dates, or number-of-months options via jQuery UI Datepicker's own JS API after attaching the library.
- Localize the calendar (first day of week, RTL, translated month/day names) by also enabling core's `locale` module — the base module then wires `jquery_ui/locale` and Drupal locale settings into the datepicker library automatically.
- Style the calendar with the bundled base theme CSS (`datepicker.css`) that ships with the library.
- Keep a legacy date-entry UI working during a phased migration off jQuery UI.
- Support a Webform or custom form element that expects the jQuery UI datepicker JS to be present.
- Provide datepicker assets to a JavaScript behavior (`Drupal.behaviors`) that initializes calendars on `.js-datepicker` fields.
- Load the datepicker widget alongside other jQuery UI shims (slider, resizable) that share the same `jquery_ui` base dependency.
- Ensure a date field's client-side calendar renders consistently across Drupal 9.2, 10, and 11.
- Vet a site's jQuery UI dependency surface by seeing exactly which widget (datepicker) a module pulls in.
- Ship a lightweight dependency (only `drupal/jquery_ui`) rather than re-vendoring jQuery UI assets in your own project.
- Give agents/tools a stable library name to attach when a task requires a jQuery UI calendar on a Drupal page.
