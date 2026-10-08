jQuery UI Tooltip re-provides the single jQuery UI Tooltip widget asset library as a standalone contrib module after jQuery UI was deprecated and removed from Drupal core. Install it and attach `jquery_ui_tooltip/tooltip` where you need the widget.

---

Drupal core used to bundle jQuery UI, including the Tooltip widget, but jQuery UI is End-of-Life upstream and core deprecated then removed it. This module is one of the split-out companion projects that restore an individual widget on top of the shared `jquery_ui` base module. It ships no PHP of its own beyond an `.info.yml`: the actual `tooltip` library is declared dynamically by the `jquery_ui` module's `hook_library_info_alter()`, which reads `jquery_ui.libraries.data.json` and registers the definition under this module's `jquery_ui_tooltip` namespace. The vendored asset is jQuery UI 1.13.2's `tooltip-min.js` plus the base theme `tooltip.css`, served from the `jquery_ui` module directory. The library depends on `core/jquery`, `jquery_ui/widget`, `jquery_ui/position` and several internal `jquery_ui/*` helpers, so `jquery_ui` (`>=8.x-1.7`) is a hard dependency. There is no configuration UI, no permissions, no services and no config schema — you enable the module and attach the library via `#attached` or a `dependencies:` entry. The maintainers recommend migrating off jQuery UI to a maintained tooltip solution for new code rather than adding fresh dependencies on it.

---

- Restore the jQuery UI Tooltip widget after upgrading to a Drupal core version where jQuery UI was removed.
- Attach `jquery_ui_tooltip/tooltip` to a render array so a page can call `.tooltip()`.
- Add the tooltip library as a `dependencies:` entry in a custom module's `*.libraries.yml`.
- Add the tooltip library as a `dependencies:` entry in a custom theme's `*.libraries.yml`.
- Keep a legacy contrib module that calls `$(...).tooltip()` working without patching it.
- Replace an old `core/jquery.ui.tooltip` library reference in custom code with `jquery_ui_tooltip/tooltip`.
- Serve the jQuery UI 1.13.2 `tooltip-min.js` widget script to a front end.
- Serve the jQuery UI base-theme `tooltip.css` styling for tooltips.
- Provide the tooltip widget to a legacy admin form that relies on jQuery UI tooltips.
- Enhance form field help text with jQuery UI tooltips in a custom module.
- Show hover tooltips on custom Twig-rendered markup via an attached behavior.
- Depend on the tooltip widget from a distribution that pins jQuery UI widgets explicitly.
- Bridge a contributed theme during migration away from jQuery UI to a modern tooltip library.
- Avoid deprecation warnings by depending on `jquery_ui_tooltip/tooltip` instead of a removed core library.
- Add the tooltip widget alongside other split-out widgets like jquery_ui_dialog and jquery_ui_datepicker.
- Ensure a consistent vendored jQuery UI tooltip version (1.13.2) across a multisite platform.
- Guarantee the `jquery_ui` base and its `position`/`widget` helpers load before tooltip code runs.
- Provide the tooltip widget to a custom JavaScript behavior attached in `Drupal.behaviors`.
- Let an upgrade audit swap a single removed core tooltip dependency for this focused module.
- Pull in only the tooltip widget rather than the entire jQuery UI widget set to keep the payload small.
