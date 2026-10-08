jQuery UI re-provides the jQuery UI 1.13.2 asset library (JavaScript, CSS base theme and images) as a contrib module so themes and modules can keep depending on it after Drupal core deprecated and removed it as a public API.

---

Drupal core historically bundled jQuery UI as `core/jquery.ui`, but jQuery UI is no longer actively maintained and has been marked End of Life by the OpenJS Foundation, so core deprecated it (from Drupal 9) and made it internal. This module re-provides the same vendored asset library (version 1.13.2) outside of core so existing code does not break. It declares the base libraries `jquery_ui/core`, `jquery_ui/widget`, `jquery_ui/mouse`, `jquery_ui/position` and `jquery_ui/locale` in `jquery_ui.libraries.yml`, and dynamically declares the many internal sub-libraries and the widget/effect libraries on behalf of companion modules through a `hook_library_info_alter()` implementation (`jquery_ui_library_info_alter()` in `jquery_ui.module`) that reads `jquery_ui.libraries.data.json`. There is no configuration UI, no permissions, no routes (beyond `hook_help`) and no services; you install it and attach the libraries you need, or reference them as dependencies in your own `*.libraries.yml`. Individual widgets (accordion, autocomplete, datepicker, dialog, draggable, slider, tabs, tooltip, etc.) and the effects set are provided by separate companion projects such as `jquery_ui_datepicker`, `jquery_ui_dialog` and `jquery_ui_effects` that build on this base; those companion modules ship no PHP themselves — this base module declares their libraries for them. The `jquery_ui/locale` library wires the jQuery UI datepicker into Drupal's localization so translated month/day names and region defaults apply. The maintainers strongly recommend migrating off jQuery UI to a maintained alternative rather than adding new dependencies on it; in practice this module exists to keep legacy themes, modules and custom code working during that transition.

---

- Restore the jQuery UI library after upgrading to a Drupal core version where it was removed as a public API.
- Replace `core/jquery.ui` references in a custom theme with `jquery_ui/core`.
- Replace `core/jquery.ui.widget` references in a custom module with `jquery_ui/widget`.
- Provide the jQuery UI base position utility (`jquery_ui/position`) to a custom module's JavaScript.
- Provide the jQuery UI mouse interaction base (`jquery_ui/mouse`) for a drag/resize behavior.
- Attach `jquery_ui/core` from a render array via `$build['#attached']['library'][] = 'jquery_ui/core'`.
- Declare `jquery_ui/core` as a dependency of a custom library in `my_module.libraries.yml`.
- Keep a contributed module that still depends on jQuery UI installable on Drupal 10/11.
- Enable `jquery_ui_datepicker` (companion project) and let this base declare its `datepicker` library.
- Add localized datepicker month/day names by depending on `jquery_ui/locale` alongside the datepicker.
- Enable `jquery_ui_dialog` to power a legacy modal dialog that uses jQuery UI's dialog widget.
- Enable `jquery_ui_effects` to keep animations (blind, bounce, fade, slide, shake, etc.) working.
- Enable `jquery_ui_accordion` / `jquery_ui_tabs` for legacy collapsible content built on jQuery UI.
- Enable `jquery_ui_draggable` / `jquery_ui_droppable` / `jquery_ui_sortable` for drag-and-drop UIs.
- Enable `jquery_ui_slider` / `jquery_ui_spinner` for range/number widgets that predate core replacements.
- Enable `jquery_ui_autocomplete` / `jquery_ui_selectmenu` / `jquery_ui_menu` for legacy form widgets.
- Enable `jquery_ui_tooltip` / `jquery_ui_progressbar` / `jquery_ui_button` for legacy UI components.
- Enable `jquery_ui_resizable` / `jquery_ui_selectable` / `jquery_ui_checkboxradio` / `jquery_ui_controlgroup` as needed by inherited code.
- Ship the jQuery UI base CSS theme (`themes/base`) so widget styling renders correctly.
- Audit a site for jQuery UI usage before planning a migration to a maintained JavaScript library.
- Depend on `jquery_ui/widget` to build a custom jQuery UI widget with the widget factory.
- Keep a Views or Webform add-on that relies on jQuery UI functional during an upgrade window.
- Provide jQuery UI to a distribution or install profile whose bundled themes still require it.
- Reference the change record for the core deprecation from the module's help page (`hook_help`).
